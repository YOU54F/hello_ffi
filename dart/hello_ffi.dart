import 'dart:ffi';
import 'pact_ffi_bindings.dart';
import 'package:ffi/ffi.dart';
import 'dart:io' show Platform, Directory;

import 'package:path/path.dart' as path;

void main(List<String> args) async {
  print('hello ffi');
  var libraryPath = path.join(Directory.current.path, 'libpact_ffi.so');
  if (Platform.isMacOS) {
    libraryPath = path.join(Directory.current.path, 'libpact_ffi.dylib');
  } else if (Platform.isWindows) {
    libraryPath = path.join(Directory.current.path, 'pact_ffi.dll');
  }
  final lib = PactFfiBindings(DynamicLibrary.open(libraryPath));

  final version = lib.pactffi_version();
  print(version.cast<Utf8>().toDartString());
}
