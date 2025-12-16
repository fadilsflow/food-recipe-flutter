import 'dart:html' as html;
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

// Web implementation
Future<MultipartFile> createMultipartFile(dynamic file) async {
  if (file is html.File) {
    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);
    await reader.onLoad.first;
    
    final bytes = reader.result as Uint8List;
    
    return MultipartFile.fromBytes(
      bytes,
      filename: file.name,
      contentType: MediaType.parse(file.type),
    );
  }
  
  throw ArgumentError('Expected html.File type for web platform');
}
