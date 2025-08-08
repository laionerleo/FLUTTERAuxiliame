import 'package:google_generative_ai/google_generative_ai.dart';

class AIService {
  // --- IMPORTANTE ---
  // Pega tu clave de API de Google AI Studio aquí.
  // Obtén una en: https://aistudio.google.com/
  static const String _apiKey = "PEGAR_AQUI_TU_API_KEY_DE_GEMINI";

  final GenerativeModel _model;

  AIService()
      : _model = GenerativeModel(
          model: 'gemini-pro',
          apiKey: _apiKey,
        );

  Future<String> getResponse(String message) async {
    if (_apiKey == "PEGAR_AQUI_TU_API_KEY_DE_GEMINI") {
      return "Error: La clave de API de Gemini no ha sido configurada.";
    }

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
