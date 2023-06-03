import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:fp/screens/chatbotScreen/chat_model.dart';
import 'api_constant.dart';

class ApiService {
  // send messages
  static Future<List<ChatModel>> sendMessage(
      {required String message}) async {
    try {
      var response = await http.post(Uri.parse('$BASE_URL/chat/completions'),
          headers: {
            'Authorization': 'Bearer $API_KEY',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            "messages": [
              {
                "role": "user",
                "content": message,
              }
            ],
            "temperature": 0.7,

          }));
      Map jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }

      List<ChatModel> chatList = [];
      if (jsonResponse['choices'].length > 0) {
        chatList = List.generate(
            jsonResponse['choices'].length,
                (index) => ChatModel(
                msg: jsonResponse['choices'][0]['message']['content'],
                chatIndex: 1));
      }
      return chatList;
    } catch (e) {
      log('error is: $e');
      rethrow;
    }
  }
}
