import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// Web implementation - just return the XFile as-is
Future<XFile> convertToFile(XFile xFile) async {
  return xFile;
}

ImageProvider getFileImage(dynamic file) {
  // This won't be used on web since we use MemoryImage with bytes
  throw UnsupportedError('Use MemoryImage on web');
}
