#lang racket/base
(require ffi/unsafe
         racket/runtime-path
         (for-syntax racket/base))
(define pact_ffi (ffi-lib "libpact_ffi" '("2" #f)))

(define pactffi_version
    (get-ffi-obj "pactffi_version" pact_ffi
                 (_fun -> _string)))
(define pactffi_logger_init
    (get-ffi-obj "pactffi_logger_init" pact_ffi
                 (_fun -> _void)))
(define pactffi_logger_attach_sink
    (get-ffi-obj "pactffi_logger_attach_sink" pact_ffi
                 (_fun _string _int32 -> _int32)))
(define pactffi_logger_apply
    (get-ffi-obj "pactffi_logger_apply" pact_ffi
                 (_fun -> _void)))
(define pactffi_log_message
    (get-ffi-obj "pactffi_log_message" pact_ffi
                 (_fun _string _string _string -> _void)))

(pactffi_logger_init)
(void pactffi_logger_attach_sink "stdout" 3)
(pactffi_logger_apply)
(pactffi_log_message "pact-racket" "INFO" (string-append "hello from ffi version: " (pactffi_version)))