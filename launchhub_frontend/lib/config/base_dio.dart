import 'package:dio/dio.dart';

const baseUrl = 'http://13.37.250.77:80/';

final BaseOptions options = BaseOptions(
  baseUrl: '${baseUrl}api/',
  contentType: Headers.jsonContentType,
);

final Dio myDio = Dio(options);
