import 'package:fp/screens/chatbotScreen/chat_model.dart';
import '../../constants/api_constant.dart';
import 'package:dio/dio.dart';

class ChatbotApiService {
  static Future<List<ChatModel>> sendMessage({required String message}) async {
    try {
      Dio dio = Dio();
      dio.options.baseUrl = '$CHATBOT_BASE_URL/chatbot';
      dio.options.headers['Content-Type'] = 'application/json';
      var response = await dio.post('', data: {'message': message,});
      Map jsonResponse = response.data;
      List<ChatModel> chatList = List.generate(
          1, (index) => ChatModel(msg: jsonResponse['data'], chatIndex: 1));
      return chatList;
    } catch (e) {
      return getErrorMessage();
    }
  }

  static Future<List<ChatModel>> getWelcomeMessage() async {
    try {
      Dio dio = Dio();
      dio.options.baseUrl = '$CHATBOT_BASE_URL/chatbot/welcome';
      dio.options.headers['Content-Type'] = 'application/json';
      var response = await dio.get('');
      Map jsonResponse = response.data;
      List<ChatModel> chatList = List.generate(3,
          (index) => ChatModel(msg: jsonResponse['data']["$index"], chatIndex: 1));
      return chatList;
    } catch (e) {
      return getErrorMessage();
    }
  }



  static List<ChatModel> getErrorMessage() {
    return [
      ChatModel(
          msg: "خطأ في الاتصال بالخادم، برجاء المحاولة في وقت لاحق",
          chatIndex: 1)
    ];
  }
}
