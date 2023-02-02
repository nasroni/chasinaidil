import 'package:get/get.dart';

class AppController extends GetxController {
  static String transcribe(String input) {
    return input.toLowerCase().split('').map((e) {
      if (!cyrillicLatin.containsKey(e)) return e;
      return cyrillicLatin[e];
    }).join('');
  }

  static Map<String, String> cyrillicLatin = {
    'а': 'a',
    'б': 'b',
    'в': 'v',
    'г': 'g',
    'д': 'd',
    'е': 'e',
    'ё': 'jo',
    'ж': 'zh',
    'з': 'z',
    'и': 'i',
    'й': 'j',
    'к': 'k',
    'л': 'l',
    'м': 'm',
    'н': 'n',
    'о': 'o',
    'п': 'p',
    'р': 'r',
    'с': 's',
    'т': 't',
    'у': 'u',
    'ф': 'f',
    'х': 'kh',
    'ц': 'c',
    'ч': 'ch',
    'ш': 'sh',
    'щ': 'shh',
    'ъ': '',
    'ы': 'y',
    'ь': '',
    'э': 'eh',
    'ю': 'ju',
    'я': 'ja',
    'ғ': 'gh',
    'ӣ': 'i',
    'қ': 'q',
    'ӯ': 'u',
    'ҳ': 'h',
    'ҷ': 'j',
  };
}
