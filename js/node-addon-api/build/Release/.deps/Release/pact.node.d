cmd_Release/pact.node := c++ -bundle -undefined dynamic_lookup -Wl,-search_paths_first -mmacosx-version-min=10.7 -arch arm64 -L./Release -stdlib=libc++ -Wl,-rpath,/Users/saf/.tea -o Release/pact.node Release/obj.target/pact/ffi.o Release/nothing.a 
