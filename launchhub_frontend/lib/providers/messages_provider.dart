import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/config/base_dio.dart';
import 'package:launchhub_frontend/data/api_constants.dart';
import 'package:launchhub_frontend/models/message.dart';
import 'package:shared_preferences/shared_preferences.dart';

final messagesProvider = ChangeNotifierProvider<MessagesProvider>((ref) {
  return MessagesProvider();
});

class MessagesProvider with ChangeNotifier {
  final StreamController<List<Message>> _messagesController =
      StreamController.broadcast();
  Stream<List<Message>> get messagesStream => _messagesController.stream;

  List<Message> messages = [];

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
      final List<Message> loadedmessages = Message.fromJsonList(response.data);
      loadedmessages.sort((b, a) => a.createdAt.compareTo(b.createdAt));
      messages = loadedmessages;
      _messagesController.add(loadedmessages);
      notifyListeners();
    } on DioException catch (e) {
      return e.response!.data;
    } catch (e) {
      return e;
    }
  }

  Future sendMessage(String message) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await myDio.post(
        ApiRoute.sendMessage,
        data: {
          'text': message,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final res = response.data;
      // final Message userMessage = Message(
      //     createdAt: res['created_at'],
      //     id: res['id'],
      //     sender: 'user',
      //     text: message,
      //     userId: res['user_id']);
      // messages.insert(0, userMessage);
      // _messagesController.add(messages);
      final Message loadedMessage = Message.fromJson(res);
      messages.insert(0, loadedMessage);
      _messagesController.add(messages);
      notifyListeners();
    } on DioException catch (e) {
      return e.response!.data;
    } catch (e) {
      return e;
    }
  }

  void insertMessage(Message message) async {
    messages.insert(0, message);
    _messagesController.add(messages);
    notifyListeners();
  }

  Future clearMessages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      messages = [];
      myDio.delete(
        ApiRoute.clearMessages,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      fetchMessages();
      notifyListeners();
    } catch (e) {
      return e;
    }
  }

  @override
  void dispose() {
    _messagesController.close();
    super.dispose();
  }
}
