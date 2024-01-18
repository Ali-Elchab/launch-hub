import 'package:dio/dio.dart';

const baseUrl = 'http://192.168.0.106:8000/';
final BaseOptions options = BaseOptions(
  baseUrl: '${baseUrl}api/',
  contentType: Headers.jsonContentType,
);

final Dio myDio = Dio(options);
