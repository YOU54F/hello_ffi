{-# LANGUAGE ForeignFunctionInterface #-}
import Data.Word (Word8)
import Foreign.Ptr (nullPtr)
import Foreign.C.String (CString(..), peekCString)

foreign import ccall "pact-cpp.h pactffi_version"
     c_pactffi_version :: IO (CString)


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
    Just str -> putStrLn str