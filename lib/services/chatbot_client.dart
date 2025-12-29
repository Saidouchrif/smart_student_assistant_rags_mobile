import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../models/chat_request.dart';
import '../models/chat_response.dart';

part 'chatbot_client.g.dart';

@RestApi()
abstract class ChatbotClient {
  factory ChatbotClient(Dio dio, {String? baseUrl}) = _ChatbotClient;

  @POST("/chat")
  Future<ChatResponse> sendQuestion(@Body() ChatRequest request);
}
