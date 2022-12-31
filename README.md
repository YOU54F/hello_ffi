# Hello Pact FFI

Inspired by [The Rust FFI Omnibus](http://jakegoulding.com/rust-ffi-omnibus/), this project aims to showcase the [Pact FFI](https://github.com/pact-foundation/pact-reference/tree/master/rust/pact_ffi) is as many languages as possible using the [Foreign Function Interface](https://en.wikipedia.org/wiki/Foreign_function_interface)

__Note:__ This code in this project is not intended for use in your actual Pact projects, but may serve as inspiration for future projects.

## Languages covered

- [x] - [Bun](https://github.com/oven-sh/bun)
- [x] - [Deno](https://deno.land/)
- [x] - [Haskell](https://www.haskell.org/)
- [x] - [Julia](https://julialang.org/)
- [x] - [Perl](https://www.perl.org/)
- [x] - [PHP](https://www.php.net/)
- [x] - [Python](https://www.python.org/)
- [x] - [Raku](https://www.raku.org/)
- [x] - [Ruby](https://www.ruby-lang.org/)
- [ ] - [R](https://www.r-project.org/about.html)

## Aims

1. Load the shared libraries cross platform
2. Print out the Pact FFI Library Version
3. Create a HTTP Pact test
4. Create a gRPC Pact test using a Pact Plugin
5. Create a Pact Plugin

Bonus points

1. Library downloader in each native language

## Contributing

Contributions are welcome. 

Things that could be useful

1. Create a website to display the code snippets (Docusaurus + Remote code tabs)
2. Create a cucumber test suite that can be used to execute each test in every language. Example feature file in `./features`
3. More languages
4. Create more examples of test suite lifecycles and proper arranging of FFI calls. See https://github.com/pact-foundation/pact-reference/blob/master/rust/pact_ffi/ARCHITECTURE.md
