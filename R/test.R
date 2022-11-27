# # Setting up R

# https://code.visualstudio.com/docs/languages/r
# https://github.com/randy3k/radian
# https://github.com/nx10/httpgd
# https://github.com/REditorSupport/languageserver
# https://marketplace.visualstudio.com/items?itemName=REditorSupport.r
# https://ubco-biology.github.io/BIOL202/trying-to-use-cran-without-setting-a-mirror.html

## Make some HTTP requests

# https://cran.r-project.org/web/packages/httr/vignettes/quickstart.html
# library(httr)
# r <- GET("http://httpbin.org/get")
# r


## FFI

library(rdyncall)

# # help(rdyncall)


lib <- dyn.load('/Users/saf/.pact/ffi/osxaarch64/libpact_ffi.dylib', auto.unload=TRUE)
# # is.loaded('pactffi_init')
# is.loaded('pactffi_version')
# output = .Call('pactffi_version')
# output
# output$x

# helloA1 <- function() {
#   result <- .C("pactffi_version","")
# }
# greeting <- helloA1()
# greeting
# greeting$x #0 #1

# arg = .C("pactffi_version",foo='bar')
# arg
# result <- as.matrix(output)
# print(result)
# # .Call("pactffi_version", x = as.list('foo'))
# # .dynunload(x)

# library('/Users/saf/.pact/ffi/osxaarch64/libpact_ffi.dylib')
# pactffi_version()


# lib <- dynfind(c("pact_ffi_h","m","/Users/saf/.pact/ffi/osxaarch64/libpact_ffi.dylib"))
# print(lib)
# lib
# lib
# x <- .dynsym(lib,"pactffi_version")
# .dyncall(x, "d)d", 144L)


# https://stackoverflow.com/questions/28026818/how-to-call-c-function-from-r


# .C('pactffi_logger_init')
# .C("pactffi_logger_attach_sink",('stdout', 5))
# .Call('pactffi_logger_apply')


pactinternals <- file.path('/Users/saf/.pact/ffi/pact.h')
# file.show(pactinternals)

add <- function() {
  .Call("pactffi_version")
}

add()