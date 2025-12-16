import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

// Web implementation - accepts XFile directly
Future<MultipartFile> createMultipartFile(dynamic file) async {
  if (file is XFile) {
    // Read bytes from XFile
    final bytes = await file.readAsBytes();
    
    // Determine content type from file name
    String? mimeType;
    final extension = file.name.split('.').last.toLowerCase();
    if (extension == 'jpg' || extension == 'jpeg') {
      mimeType = 'image/jpeg';
    } else if (extension == 'png') {
      mimeType = 'image/png';
    } else if (extension == 'gif') {
      mimeType = 'image/gif';
    } else {
      mimeType = 'image/jpeg'; // Default
    }
    
    return MultipartFile.fromBytes(
      bytes,
      filename: file.name,
      contentType: MediaType.parse(mimeType),
    );
  }
  
  throw ArgumentError('Expected XFile type for web platform, got ${file.runtimeType}');
}
