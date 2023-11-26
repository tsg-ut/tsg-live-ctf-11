package main

import (
	"bufio"
	"errors"
	"fmt"
	"io"
	"net"
	"os"
	"strings"

	"github.com/google/uuid"
)

func main() {
	listener, err := net.Listen("tcp", ":8080")
	if err != nil {
		panic(err)
	}
	defer listener.Close()

	fmt.Println("HTTP Server is running on port 8080...")

	for {
		conn, err := listener.Accept()
		if err != nil {
			fmt.Println("Error accepting connection:", err)
			continue
		}

		go handleConnection(conn)
	}
}

const OKHEADER = "HTTP/1.1 200 OK\r\n" + "Content-Type: text/plain; charset=utf-8\r\n" + "Connection: close\r\n" + "\r\n"

const HTMLHEADER = "HTTP/1.1 200 OK\r\n" + "Content-Type: text/html; charset=utf-8\r\n" + "Connection: close\r\n" + "\r\n"

type Meta struct {
	safe  bool
	index int
}

var (
	notes     []string
	meta      map[string]Meta
	flag      string
	indexHTML string
)

func init() {
	notes = make([]string, 0)
	meta = make(map[string]Meta)
	flag = os.Getenv("FLAG")
	if flag == "" {
		flag = "FAKELIVE{this_is_a_fake_flag}"
	}
	file, err := os.Open("./index.html")
	if err != nil {
		panic(err)
	}
	defer file.Close()
	data, err := io.ReadAll(file)
	if err != nil {
		// エラー処理
		fmt.Println("Error reading file:", err)
		return
	}
	indexHTML = string(data)
}

func getHello(conn net.Conn) {
	conn.Write([]byte(HTMLHEADER + "\r\n" + indexHTML))
}

func getFlag(conn net.Conn) {
	response := "HTTP/1.1 403 Forbidden\r\n" + "Content-Type: text/plain; charset=utf-8\r\n" + "Connection: close\r\n" + "\r\n" + "You are not allowed to access flag!"
	conn.Write([]byte(response))
}

func parseID(arg string) (string, error) {
	arg, ok := strings.CutPrefix(arg, "?id=")
	if arg == "" || !ok {
		return "", errors.New("Invalid arg")
	}
	return arg, nil
}

func getNote(conn net.Conn, post string) {
	id, err := parseID(post)
	if err != nil {
		badRequest(conn)
		return
	}
	m, ok := meta[id]
	if !ok {
		notFound(conn)
	} else if m.safe {
		conn.Write([]byte(OKHEADER + notes[m.index]))
	} else {
		getFlag(conn)
	}
}

func redirectTo(conn net.Conn, url string) {
	response := "HTTP/1.1 302 Found\r\n" + "Location: " + url + "\r\n" + "Connection: close\r\n" + "\r\n"
	conn.Write([]byte(response))
}

func postFlag(conn net.Conn) {
	uuid, err := uuid.NewRandom()
	if err != nil {
		panic(err)
	}
	id := uuid.String()
	idx := len(notes)
	notes = append(notes, flag)
	meta[id] = Meta{safe: false, index: idx}
	redirectTo(conn, "/note?id="+id)
}

func postNote(conn net.Conn, post string, reader *bufio.Reader) {
	uuid, err := uuid.NewRandom()
	buffer := make([]byte, 40)
	if err != nil {
		panic(err)
	}
	id := uuid.String()
	idx := len(notes)
	reader.Read(buffer)
	notes = append(notes, string(buffer))
	meta[id] = Meta{safe: true, index: idx}
	redirectTo(conn, "/note?id="+id)
}

func notFound(conn net.Conn) {
	response := "HTTP/1.1 404 Not Found\r\n"
	conn.Write([]byte(response))
}

func badRequest(conn net.Conn) {
	response := "HTTP/1.1 400 Bad Request\r\n"
	conn.Write([]byte(response))
}

func readHeader(reader *bufio.Reader) ([]string, error) {
	res := []string{}
	for i := 0; i < 40; i++ {
		line, err := reader.ReadString('\n')
		if err == io.EOF {
			return res, nil
		}
		if err != nil {
			return []string{}, err
		}
		if line == "\r\n" {
			return res, nil
		}
		res = append(res, line)
	}
	return []string{}, errors.New("Too long headers")
}

func handleConnection(conn net.Conn) {
	defer conn.Close()

	reader := bufio.NewReader(conn)
	headers, err := readHeader(reader)
	if err != nil || len(headers) == 0 {
		fmt.Println("Error reading request:", err)
		badRequest(conn)
		return
	}
	request := headers[0]
	fmt.Println("Received request:", strings.TrimSpace(request))

	parts := strings.Split(request, " ")

	if len(parts) != 3 {
		badRequest(conn)
		return
	}
	method := parts[0]
	path := parts[1]
	if method == "GET" {
		if path == "" || path == "/" || strings.HasPrefix(path, "/view/note") {
			getHello(conn)
		} else if strings.HasPrefix(path, "/flag") {
			getFlag(conn)
		} else if strings.HasPrefix(path, "/note") {
			x, _ := strings.CutPrefix(path, "/note")
			getNote(conn, x)
		} else {
			notFound(conn)
		}
	} else if method == "POST" {
		if path == "" || path == "/" {
			badRequest(conn)
		} else if path == "/flag" {
			postFlag(conn)
		} else if strings.HasPrefix(path, "/note") {
			x, _ := strings.CutPrefix(path, "/note")
			postNote(conn, x, reader)
		} else {
			notFound(conn)
		}
	} else {
		badRequest(conn)
	}
}
