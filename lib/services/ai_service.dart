import 'package:dart_openai/dart_openai.dart';
//import 'package:flutter_dotenv/flutter_dotenv.dart';

class AIService {
  AIService() {
    //OpenAI.apiKey = "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"; // dotenv.env['OPENAI_API_KEY']!;
  }

  Future<String> getResponse(String message) async {
    try {
      final chatCompletion = await OpenAI.instance.chat.create(
        model: 'gpt-3.5-turbo',
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            content: [
              OpenAIChatCompletionChoiceMessageContentItemModel.text(message),
            ],
            role: OpenAIChatMessageRole.user,
          ),
        ],
      );
      return chatCompletion.choices.first.message.content?.first.text ??
          "No se pudo obtener una respuesta.";
    } catch (e) {
      print("Error calling OpenAI API: $e");
      return "Error al conectar con la IA. Inténtalo de nuevo.";
    }
  }
}
