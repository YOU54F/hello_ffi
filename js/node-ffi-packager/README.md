1. https://github.com/node-ffi-packager/node-ffi-generate
2. Find clang `mdfind -name libclang.dylib`



needed to monkey patch `js/node-ffi-packager/node_modules/@ffi-packager/ffi-generate/templates/ffi.mustache`


```handlebars
{{#sorted.types}}
types["{{typeReference}}"] = {{typeReference}};
{{/sorted.types}}
```