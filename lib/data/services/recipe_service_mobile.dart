import 'dart:io';
import 'package:dio/dio.dart';

// Mobile implementation (iOS/Android)
Future<MultipartFile> createMultipartFile(dynamic file) async {
  if (file is! File) {
    throw ArgumentError('Expected File type for mobile platform');
  }
  
  String fileName = file.path.split('/').last;
  return await MultipartFile.fromFile(file.path, filename: fileName);
}
