import 'dart:convert';
import 'package:chat_bot/utils/app_key.dart';
import 'package:http/http.dart' as http;

class OpenAiServices{
  Future<String> getChatResponse(String message) async {
    final url = Uri.parse('https://api.openai.com/v1/engines/davinci-codex/completions');
    final headers = {
      'Authorization': 'Bearer $openAiToken',
      'Content-Type': 'application/json',
    };

    final requestBody = {
      'prompt': message,
      'max_tokens': 300,
    };

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      final responseGet =  json.decode(response.body);
      print("Text Devinci response  -------> ${responseGet['choices'][0]['text']}");
      return responseGet['choices'][0]['text'];
    } else {
      throw Exception('Failed to get chat response');
    }
  }

}