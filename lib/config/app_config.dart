class AppConfig {
  AppConfig._();

  static const String baseUrl = String.fromEnvironment('SUPABASE_URL');
  static const String apiKey = String.fromEnvironment('SUPABASE_API_KEY');

  static void validate() {
    final Map<String, String> envVariables = <String, String>{
      'SUPABASE_URL': baseUrl,
      'SUPABASE_API_KEY': apiKey,
    };

    final List<String> missing = envVariables.entries
        .where((MapEntry<String, String> entry) => entry.value.trim().isEmpty)
        .map((MapEntry<String, String> entry) => entry.key)
        .toList();

    if (missing.isNotEmpty) {
      throw StateError(
        '\n❌ Variables faltantes: ${missing.join(', ')}\n'
        '→ Revisa tu .env.json\n',
      );
    }
  }
}
