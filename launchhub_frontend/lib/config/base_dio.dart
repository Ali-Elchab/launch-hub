import 'package:dio/dio.dart';

final BaseOptions options = BaseOptions(
  baseUrl: 'http://192.168.0.106:8000/api/',
  contentType: Headers.jsonContentType,
);

final Dio myDio = Dio(options);
