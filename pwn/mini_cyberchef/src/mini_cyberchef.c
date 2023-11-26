#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include "base64.h"
#include "base64.c"

struct Recipe {
    char buf[0x100];
    int num, cnt;
    char out_buf[0x100];
    void (*converter) (struct Recipe*);
};

int readline_n(char* buf, int n)
{
    char tmp[1];
    int cnt = 0;
    for(int i=0; i<n; i++)
    {
        read(STDIN_FILENO, tmp, 1);
        if (tmp[0] == '\n')
        {
            break;
        }
        buf[i] = tmp[0];
        cnt += 1;
    }
    return cnt;
}

int read_int()
{
    char num[5] = {0};
    readline_n(num, 4);
    return atoi(num);
}

void add_result(char* buf, int cnt)
{
    memmove(buf+8, buf, cnt);
    memcpy(buf, "Result: ", 8);
    return;
}

void base64_dec(struct Recipe* recipe);

void base64_enc(struct Recipe* recipe)
{
    recipe->converter = &base64_dec;
    puts("Base64 Encoding");
    recipe->cnt = b64_encode((unsigned char*)recipe->buf, recipe->cnt, (unsigned char*)recipe->out_buf);
    add_result(recipe->out_buf, recipe->cnt);
    return;
}

void base64_dec(struct Recipe* recipe)
{
    recipe->converter = &base64_enc;
    puts("Base64 Decoding");
    recipe->cnt = b64_decode((unsigned char*)recipe->buf, recipe->cnt, (unsigned char*)recipe->out_buf);
    add_result(recipe->out_buf, recipe->cnt);
    return;
}

void rot13(struct Recipe* recipe)
{
    puts("ROT13 Shift");
    for (int i = 0; i < recipe->cnt; i++) {
        char now = recipe->buf[i];
        if ('a' <= now && now <= 'z') {
            now = ((now - 'a') + 13) % 26 + 'a';
        }
        if ('A' <= now && now <= 'Z') {
            now = ((now - 'A') + 13) % 26 + 'A';
        }
        recipe->out_buf[i] = now;
    }
    add_result(recipe->out_buf, recipe->cnt);
    return;
}

void win()
{
    system("/bin/sh");
    return;
}

int main()
{
    setvbuf(stdout, (char*) NULL, _IONBF, 0);

    struct Recipe* recipe = malloc(sizeof(struct Recipe));
    memset(recipe, '\0', sizeof(*recipe));

    puts("Specify Operations");
    puts("1. To Base64\n2. From Base64\n3. ROT13");
    printf("> ");
    recipe->num = read_int();

    puts("Enter Recipe");
    printf("> ");

    switch (recipe->num) {
        case 1:
            recipe->converter = &base64_enc;
            // size limitation
            recipe->cnt = readline_n(recipe->buf, 0x20);
            break;
        case 2:
            recipe->converter = &base64_dec;
            recipe->cnt = readline_n(recipe->buf, 0x100);
            break;
        case 3:
            recipe->converter = &rot13;
            recipe->cnt = readline_n(recipe->buf, 0x100);
            break;
        default:
            puts("Bye");
            exit(0);
    }
    recipe->converter(recipe);
    puts(recipe->out_buf);

    puts("\nRestore");
    memset(recipe->buf, '\0', sizeof(recipe->buf));
    memcpy(recipe->buf, &recipe->out_buf[8] ,recipe->cnt);
    memset(recipe->out_buf, '\0', sizeof(recipe->out_buf));
    recipe->converter(recipe);
    puts(recipe->out_buf);

    puts("Bye");
    exit(0);
}
