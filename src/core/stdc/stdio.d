/**
 * D header file for C99.
 *
 * Copyright: Public Domain
 * License:   Public Domain
 * Authors:   Sean Kelly, Walter Bright
 * Standards: ISO/IEC 9899:1999 (E)
 */
module core.stdc.stdio;

private
{
    import core.stdc.stdarg;
    import core.stdc.stddef;
    import core.stdc.config;
}

extern (C){

    //const int BUFSIZ      = 0x4000;
    const int EOF           = -1;
    const int FOPEN_MAX     = 16;
    const int FILENAME_MAX  = 4095;
    const int TMP_MAX       = 238328;
    const int L_tmpnam      = 20;
    
    enum
    {
        SEEK_SET,
        SEEK_CUR,
        SEEK_END
    }

    struct _iobuf
    {
        align (1):

        char*   _read_ptr;
        char*   _read_end;
        char*   _read_base;
        char*   _write_base;
        char*   _write_ptr;
        char*   _write_end;
        char*   _buf_base;
        char*   _buf_end;
        char*   _save_base;
        char*   _backup_base;
        char*   _save_end;
        void*   _markers;
        _iobuf* _chain;
        int     _fileno;
        int     _blksize;
        int     _old_offset;
        ushort  _cur_column;
        byte    _vtable_offset;
        char[1] _shortbuf;
        void*   _lock;
    }

    alias _iobuf FILE;

    enum
    {
        _F_RDWR = 0x0003,
        _F_READ = 0x0001,
        _F_WRIT = 0x0002,
        _F_BUF  = 0x0004,
        _F_LBUF = 0x0008,
        _F_ERR  = 0x0010,
        _F_EOF  = 0x0020,
        _F_BIN  = 0x0040,
        _F_IN   = 0x0080,
        _F_OUT  = 0x0100,
        _F_TERM = 0x0200,
    }
}

enum
{
    _IOFBF = 0,
    _IOLBF = 1,
    _IONBF = 2,
}

extern(C)
{
    extern FILE* stdin;
    extern FILE* stdout;
    extern FILE* stderr;
}

alias int fpos_t;

extern(C){
    int remove(in char* filename);
    int rename(in char* from, in char* to);

    FILE* tmpfile();
    char* tmpnam(char* s);

    int   fclose(FILE* stream);
    int   fflush(FILE* stream);
    FILE* fopen(in char* filename, in char* mode);
    FILE* freopen(in char* filename, in char* mode, FILE* stream);

    void setbuf(FILE* stream, char* buf);
    int  setvbuf(FILE* stream, char* buf, int mode, size_t size);

    int fprintf(FILE* stream, in char* format, ...);
    int fscanf(FILE* stream, in char* format, ...);
    int sprintf(char* s, in char* format, ...);
    int sscanf(in char* s, in char* format, ...);
    int vfprintf(FILE* stream, in char* format, va_list arg);
    int vfscanf(FILE* stream, in char* format, va_list arg);
    int vsprintf(char* s, in char* format, va_list arg);
    int vsscanf(in char* s, in char* format, va_list arg);
    int vprintf(in char* format, va_list arg);
    int vscanf(in char* format, va_list arg);
    int printf(in char* format, ...);
    int scanf(in char* format, ...);

    int fgetc(FILE* stream);
    int fputc(int c, FILE* stream);

    char* fgets(char* s, int n, FILE* stream);
    int   fputs(in char* s, FILE* stream);
    char* gets(char* s);
    int   puts(in char* s);
}

extern (D)
{
    int getchar()                 { return getc(stdin);     }
    int putchar(int c)            { return putc(c,stdout);  }
    int getc(FILE* stream)        { return fgetc(stream);   }
    int putc(int c, FILE* stream) { return fputc(c,stream); }
}

extern(C) {
    int ungetc(int c, FILE* stream);

    size_t fread(void* ptr, size_t size, size_t nmemb, FILE* stream);
    size_t fwrite(in void* ptr, size_t size, size_t nmemb, FILE* stream);

    int fgetpos(FILE* stream, fpos_t * pos);
    int fsetpos(FILE* stream, in fpos_t* pos);

    int    fseek(FILE* stream, c_long offset, int whence);
    c_long ftell(FILE* stream);
}

extern(C):

void rewind(FILE* stream);
void clearerr(FILE* stream);
int  feof(FILE* stream);
int  ferror(FILE* stream);
int  fileno(FILE *);

int  snprintf(char* s, size_t n, in char* format, ...);
int  vsnprintf(char* s, size_t n, in char* format, va_list arg);

void perror(in char* s);

int fwprintf(FILE* stream, in wchar_t* format, ...);
int fwscanf(FILE* stream, in wchar_t* format, ...);
int swprintf(wchar_t* s, size_t n, in wchar_t* format, ...);
int swscanf(in wchar_t* s, in wchar_t* format, ...);
int vfwprintf(FILE* stream, in wchar_t* format, va_list arg);
int vfwscanf(FILE* stream, in wchar_t* format, va_list arg);
int vswprintf(wchar_t* s, size_t n, in wchar_t* format, va_list arg);
int vswscanf(in wchar_t* s, in wchar_t* format, va_list arg);
int vwprintf(in wchar_t* format, va_list arg);
int vwscanf(in wchar_t* format, va_list arg);
int wprintf(in wchar_t* format, ...);
int wscanf(in wchar_t* format, ...);

wint_t fgetwc(FILE* stream);
wint_t fputwc(wchar_t c, FILE* stream);

wchar_t* fgetws(wchar_t* s, int n, FILE* stream);
int      fputws(in wchar_t* s, FILE* stream);

extern (D)
{
    wint_t getwchar()                     { return fgetwc(stdin);     }
    wint_t putwchar(wchar_t c)            { return fputwc(c,stdout);  }
    wint_t getwc(FILE* stream)            { return fgetwc(stream);    }
    wint_t putwc(wchar_t c, FILE* stream) { return fputwc(c, stream); }
}

wint_t ungetwc(wint_t c, FILE* stream);
int    fwide(FILE* stream, int mode);
