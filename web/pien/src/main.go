package main

import (
	"encoding/base64"
	"fmt"
	"io"
	"math/rand"
	"net/http"
	"os"

	"github.com/bwmarrin/snowflake"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"github.com/labstack/gommon/log"
)

const KEYLEN = 2048

var (
	flag      string = "FAKELIVE{this_is_a_fake_flag}"
	indexHTML string
	key       []byte
	node      *snowflake.Node
	DATA      string
)

func init() {
	file, err := os.Open("./index.html")
	if err != nil {
		panic(err)
	}
	defer file.Close()
	data, err := io.ReadAll(file)
	if err != nil {
		fmt.Println("Error reading file:", err)
		return
	}
	indexHTML = string(data)

	node, err = snowflake.NewNode(1)
	if err != nil {
		panic(err)
	}

	DATA = os.Getenv("DATADIR")
	if DATA == "" {
		DATA = "./data"
	}

	key = make([]byte, KEYLEN)
	_, err = rand.Read(key)
	if err != nil {
		panic(err)
	}
}

func dec(s string) (string, error) {
	b, err := base64.URLEncoding.DecodeString(s)
	if err != nil || len(b) > KEYLEN {
		return "", err
	}
	for i := 0; i < len(b); i++ {
		b[i] ^= key[i]
	}
	return string(b), nil
}

func enc(s string) string {
	b := []byte(s)
	for i := 0; i < len(b); i++ {
		b[i] ^= key[i]
	}
	return base64.URLEncoding.EncodeToString(b)
}

type PostNote struct {
	Data string `json:"data"`
}

func main() {
	e := echo.New()
	e.Use(middleware.Logger())

	e.GET("/", func(c echo.Context) error {
		return c.HTML(http.StatusOK, indexHTML)
	})

	e.GET("/id", func(c echo.Context) error {
		id := node.Generate()
		return c.String(http.StatusOK, id.String())
	})

	e.POST("/note", func(c echo.Context) error {
		pn := new(PostNote)
		if err := c.Bind(pn); err != nil {
			return c.String(http.StatusBadRequest, "Invalid request")
		}
		data := pn.Data
		if len(data) > 1024 {
			return c.String(http.StatusBadRequest, "Invalid request")
		}
		id := node.Generate()
		f, err := os.Create(DATA + "/" + id.String())
		if err != nil {
			fmt.Printf("Open Error: %v\n", err)
			return c.String(http.StatusInternalServerError, "Internal Server Error")
		}
		_, err = f.WriteString(data)
		if err != nil {
			fmt.Printf("Write Error: %v\n", err)
			return c.String(http.StatusInternalServerError, "Internal Server Error")
		}
		encodedID := enc(id.String())
		// redirect to /note?id=<uuid>
		return c.Redirect(http.StatusFound, "/note/"+encodedID)
	})

	// /note?id=<uuid>
	e.GET("/note/:noteID", func(c echo.Context) error {
		encodedID := c.Param("noteID")
		if encodedID == "" {
			return c.String(http.StatusBadRequest, "Invalid id")
		}
		id, err := dec(encodedID)
		if err != nil {
			return c.String(http.StatusBadRequest, "Invalid id")
		}

		fmt.Printf("File: %s\n", DATA+"/"+id)

		f, err := os.Open(DATA + "/" + id)
		if err != nil {
			return c.String(http.StatusInternalServerError, "Internal Server Error")
		}
		data, err := io.ReadAll(f)
		if err != nil {
			return c.String(http.StatusInternalServerError, "Internal Server Error")
		}

		return c.String(http.StatusOK, string(data))
	})

	e.GET("/view/note/:noteID", func(c echo.Context) error {
		return c.HTML(http.StatusOK, indexHTML)
	})

	e.Debug = true
	e.Logger.SetLevel(log.DEBUG)
	panic(e.Start(":8081"))
}
