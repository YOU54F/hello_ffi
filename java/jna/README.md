
https://github.com/java-native-access/jna/blob/master/www/GettingStarted.md
https://github.com/java-native-access/jna/blob/master/www/Mappings.md


- JNI (Java Native Interface) is the official way. It is fast, but a bit clumsy, it requires programmers to write a lot of boilerplate interoperability code.
- JNA (Java Native Access) is relatively easier on programmers, but is slower, because it relies on dynamic behavior.
- The OpenJDK project Panama attempts to make it significantly easier to interoperate with native code, but is still in the experimental stage. (Check out SLinC to use it from Scala: GitHub repository and an introductory blogpost.)
- Of honorable mention is Scala Native, which compiles Scala to native code (in the same manner as is typical for Go or Haskell or Rust for that matter), allowing for direct use of native libraries. But it is also in the experimental phase of its life and, more importantly, by its nature the code doesn’t run on JVM, so it’s not relevant for our use case.