require 'fiddle'
require_relative '../detect_os'

lib = Fiddle.dlopen(DetectOS.get_bin_path)

pactffi_version = Fiddle::Function.new(
  lib['pactffi_version'],
  [],
  Fiddle::TYPE_VOIDP
)
pactffi_logger_init = Fiddle::Function.new(
  lib['pactffi_logger_init'],
  [],
  Fiddle::TYPE_VOIDP
)
pactffi_logger_apply = Fiddle::Function.new(
  lib['pactffi_logger_apply'],
  [],
  Fiddle::TYPE_VOIDP
)
pactffi_logger_attach_sink = Fiddle::Function.new(
  lib['pactffi_logger_attach_sink'],
  [Fiddle::TYPE_VOIDP, Fiddle::TYPE_INT],
  Fiddle::TYPE_VOIDP
)
pactffi_log_message = Fiddle::Function.new(
  lib['pactffi_log_message'],
  [Fiddle::TYPE_VOIDP, Fiddle::TYPE_VOIDP, Fiddle::TYPE_VOIDP],
  Fiddle::TYPE_VOIDP
)


# puts pactffi_version.call #=> 0.3.14

pactffi_logger_init.call
pactffi_logger_attach_sink.call('stdout', 5)
# pactffi_logger_attach_sink.call('stderr', 5)
pactffi_logger_apply.call
pactffi_log_message.call('pact-ruby-fiddle', 'INFO', "hello from ffi version: #{pactffi_version.call}")
