import 'dart:io';

import 'package:http/http.dart';

Future<List<MultipartFile>> getMultiPartFiles(
    List<File> files, String field) async {
  final list = await Future.wait(files.map((file) async {
    final item = await MultipartFile.fromPath(field, file.path);
    return item;
  }));
  return list;
}
