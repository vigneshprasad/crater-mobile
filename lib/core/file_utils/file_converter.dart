import 'dart:convert';
import 'dart:io';

String getBase64FormateFile(String path) {
  final File file = File(path);
  final List<int> fileInByte = file.readAsBytesSync();
  final String fileInBase64 = base64Encode(fileInByte);
  return 'data:image/jpeg;base64,$fileInBase64';
}
