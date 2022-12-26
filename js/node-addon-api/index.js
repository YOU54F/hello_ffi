// const ffiLib = require('bindings')('pact.node');

const ffiLib = require('./build/Release/pact.node');

console.log(ffiLib.PactffiVersion())
