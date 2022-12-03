#include <stdio.h>
#include <stdint.h>

extern char *
pactffi_version();

extern void
pactffi_logger_init();
extern int
pactffi_logger_attach_sink(const char *value,int);
extern int
pactffi_logger_apply();
extern void pactffi_log_message(const char *source, const char *log_level, const char *message);

int main(void) {
  char *version = pactffi_version();
  printf("%s\n", version);
  pactffi_logger_init();
  pactffi_logger_attach_sink("stdout",3);
  pactffi_logger_apply();
  pactffi_log_message("pact-c-ffi","INFO",version);
}