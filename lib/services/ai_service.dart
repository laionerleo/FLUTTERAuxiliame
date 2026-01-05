import 'package:google_generative_ai/google_generative_ai.dart';

class AIService {
  // --- IMPORTANTE ---
  // Pega tu clave de API de Google AI Studio aquí.
  // Obtén una en: https://aistudio.google.com/
 // static const String _apiKey = "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";

  static const String _apiKey = "";

  final GenerativeModel _model;

  AIService()
      : _model = GenerativeModel(
          model: 'gemini-pro',
          apiKey: _apiKey,
        );

  Future<String> getResponse(String message) async {
  

    try {
      final content = [Content.text(message)];
      final response = await _model.generateContent(content);
      return response.text ?? "No se pudo obtener una respuesta.";
    } catch (e) {
      print("Error calling Gemini API: $e");
      return "Error al conectar con la IA de Gemini. Inténtalo de nuevo.";
    }
  }
}
