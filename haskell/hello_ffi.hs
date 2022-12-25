{-# LANGUAGE ForeignFunctionInterface #-}
import Data.Word (Word8)
import Foreign.Ptr (nullPtr,Ptr)
import Foreign.C.String (CString(..), peekCString)
import Foreign.C
import Foreign.ForeignPtr


foreign import ccall "pact-cpp.h pactffi_version"
     c_pactffi_version :: IO (CString) 
foreign import ccall "pact-cpp.h pactffi_logger_init"
     c_pactffi_logger_init  :: IO ()
foreign import ccall "pact-cpp.h pactffi_logger_attach_sink"
     c_pactffi_logger_attach_sink :: CString -> CInt -> IO ()
foreign import ccall "pact-cpp.h pactffi_logger_apply"
     c_pactffi_logger_apply :: IO ()
foreign import ccall "pact-cpp.h pactffi_log_message"
     c_pactffi_log_message :: CString -> CString -> CString -> IO ()

getFFIVersion :: IO (Maybe (String))
getFFIVersion = do
  ptr <- c_pactffi_version
  if ptr /= nullPtr
    then do
      str <- peekCString ptr
      return $ Just str
    else
      return Nothing


main :: IO ()
main = do
  version <- getFFIVersion
  case version of
    Nothing -> putStrLn "Unable to get version of ffi"
    Just str -> do 
      -- putStrLn $ "Haskell - hello from ffi version:" ++ show (str)
      c_pactffi_logger_init
      sinkSpecifier <- newCString "stdout"
      c_pactffi_logger_attach_sink sinkSpecifier 3
      c_pactffi_logger_apply
      source <- newCString "pact-haskell"
      logLevel <- newCString "INFO"
      message <- newCString ("hello from ffi version: "++id (str))
      c_pactffi_log_message source logLevel message