import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/config/base_dio.dart';
import 'package:launchhub_frontend/data/api_constants.dart';
import 'package:launchhub_frontend/models/message.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

final messagesProvider = ChangeNotifierProvider<MessagesProvider>((ref) {
  return MessagesProvider();
});

class MessagesProvider with ChangeNotifier {
  List<Message> _messages = [];

  List<Message> get messages {
    return [..._messages];
  }

  Future fetchMessages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await myDio.get(
        ApiRoute.getMessages,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final List<Message> loadedMessages = Message.fromJsonList(response.data);
      _messages = loadedMessages;
      notifyListeners();
      return _messages;
    } on DioException catch (e) {
      print(e.response!.data);
      return e.response!.data;
    } catch (e) {
      print(e);
      return e;
    }
  }
}
