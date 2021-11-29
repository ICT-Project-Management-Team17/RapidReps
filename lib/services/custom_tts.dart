import 'package:flutter_tts/flutter_tts.dart';

class CustomTTS extends FlutterTts {
  bool _isSpeaking = false;

  bool getSpeaking() {
    return _isSpeaking;
  }

  @override
  Future speak(String text) async {
    _isSpeaking = true;
    await super.setLanguage("en-GB");
    await super.speak(text);
  }

  @override
  Future stop() async {
    await super.stop();
    _isSpeaking = false;
  }
}
