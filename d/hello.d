/* This program prints a
   hello world message
   to the console.  */

import std.stdio;

extern (C)  void pactffi_logger_init();

void main()
{
    pactffi_logger_init();
    // printf("+main()\n");

    // void* lh = dlopen("pact_ffi", RTLD_LAZY); //The path is absolutely correct
    // if (!lh)
    // {
    //     fprintf(stderr, "dlopen error: %s\n", dlerror());
    //     exit(1);
    // }
    // printf("libdll.so is loaded\n");
}