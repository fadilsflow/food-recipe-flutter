import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// Mobile implementation
Future<File> convertToFile(XFile xFile) async {
  return File(xFile.path);
}

ImageProvider getFileImage(dynamic file) {
  return FileImage(file as File);
}
