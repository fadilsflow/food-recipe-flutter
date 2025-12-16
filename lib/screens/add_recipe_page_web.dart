import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// Web implementation
Future<html.File> convertToFile(XFile xFile) async {
  final bytes = await xFile.readAsBytes();
  final blob = html.Blob([bytes]);
  return html.File([blob], xFile.name);
}

ImageProvider getFileImage(dynamic file) {
  // This won't be used on web since we use MemoryImage with bytes
  throw UnsupportedError('Use MemoryImage on web');
}
