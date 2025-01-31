class Alert {
  final List<String> alerts;

 const  Alert({required this.alerts});

  factory Alert.fromJson(List<dynamic> json) {
    return Alert(alerts: List<String>.from(json));
  }
}

class AzanFiles {
  final Map<String, List<String>> arabic;
  final Map<String, List<String>> egyptian;
  final Map<String, List<String>> turkish;
  static String url = 'https://app.ayine.tv/Ayine/AzanFiles/';
  const AzanFiles({
    required this.arabic,
    required this.egyptian,
    required this.turkish,
  });

  factory AzanFiles.fromJson(Map<String, dynamic> json) {
    return AzanFiles(
      arabic: tidyUp(json['Arabic'], 'Arabic') ?? {},
      egyptian: tidyUp(json['Egyptian'], 'Egyptian') ?? {},
      turkish: tidyUp(json['Turkish'], 'Turkish') ?? {},
    );
  }
  static Map<String, List<String>>? tidyUp(
          Map<String, dynamic> json, String urlType) =>
      {
        '01-Fajr': List.from(json['01-Fajr'])
            .map((item) => '$url/$urlType/01-Fajr/$item')
            .toList(),
        '02-Tulu': List.from(json['02-Tulu'])
            .map((item) => '$url/$urlType/02-Tulu/$item')
            .toList(),
        '03-Dhuhr': List.from(json['03-Dhuhr'])
            .map((item) => '$url/$urlType/03-Dhuhr/$item')
            .toList(),
        '04-Asr': List.from(json['04-Asr'])
            .map((item) => '$url/$urlType/04-Asr/$item')
            .toList(),
        '05-Maghrib': List.from(json['05-Maghrib'])
            .map((item) => '$url/$urlType/05-Maghrib/$item')
            .toList(),
        '06-Isha': List.from(json['06-Isha'])
            .map((item) => '$url/$urlType/06-Isha/$item')
            .toList(),
        '07-Suhoor': List.from(json['07-Suhoor'])
            .map((item) => '$url/$urlType/07-Suhoor/$item')
            .toList(),
        '08-Iftar': List.from(json['08-Iftar'])
            .map((item) => '$url/$urlType/08-Iftar/$item')
            .toList(),
      };
}

class Quran {
  final Map<String, dynamic> content;
  List<String> muhammedSiddiq;
  List<String> muhammedJibril;
  List<String> mustafa;
  final qariNameList = [
      'Muhammad Siddiq Minshawi',
      'Muhammed Jibril',
      'Mustafa Ismail'
    ];
    final qariImageList = [
      'assets/qari/Muhammad_Siddiq_Minshawi.jpeg',
      'assets/qari/Muhammed_Jibril.jpeg',
      'assets/qari/Mustafa_Ismail.jpeg'
    ];
  static String url = 'https://app.ayine.tv/Ayine/Quran/';
  Quran({required this.content})
      : muhammedSiddiq = prepareUrl(content, 'Muhammad Siddiq Minshawi'),
        muhammedJibril = prepareUrl(content, 'Muhammed Jibril'),
        mustafa = prepareUrl(content, 'Muhammed Jibril');

  factory Quran.fromJson(Map<String, dynamic> json) {
    return Quran(content: json);
  }
  static List<String> prepareUrl(Map<String, dynamic> json, String name) {
    List<String> urlList = List<String>.from(json[name]['Hatim']);
    urlList = urlList.map((item) => '$url/$name/Hatim/$item').toList();
    return urlList;
  }
}

class ScreenSaver {
  final Map<String, dynamic> screens;
  List<String> us;
  List<String> ar;
  List<String> de;
  List<String> tr;
  List<String> midnight;
  List<String> usLocal = [];
  List<String> arLocal = [];
  List<String> deLocal = [];
  List<String> trLocal = [];
  List<String> midnightLocal = [];
  List<String> getLocalImages(String locale) {
    switch (locale) {
      case 'en':
        return usLocal;
      case 'ar':
        return arLocal;
      case 'de':
        return deLocal;
      case 'tr':
        return trLocal;
      default:
        return trLocal;
    }
  }

  List<String> getImages(String locale) {
    switch (locale) {
      case 'en':
        return us;
      case 'ar':
        return ar;
      case 'de':
        return de;
      case 'tr':
        return tr;
      default:
        return tr;
    }
  }

  void saveToLocal(String path, String locale) {
   
    switch (locale) {
      case 'en':
        usLocal.add(path);
      case 'ar':
        arLocal.add(path);
      case 'de':
        deLocal.add(path);
      case 'tr':
        trLocal.add(path);
      default:
        trLocal.add(path);
    }
  }

  static String url = 'https://app.ayine.tv/Ayine/ScreenSaver';
  ScreenSaver({required this.screens})
      : us = prepareUrl(screens, 'us'),
        ar = prepareUrl(screens, 'ar'),
        de = prepareUrl(screens, 'de'),
        midnight = prepareUrl(screens, 'midnight'),
        tr = prepareUrl(screens, 'tr');
  static List<String> prepareUrl(Map<String, dynamic> json, String name) {
    List<String> urlList = List<String>.from(json[name]);
    urlList = urlList.map((item) => '$url/$name/$item').toList();
    return urlList;
  }

  factory ScreenSaver.fromJson(Map<String, dynamic> json) {
    return ScreenSaver(
      screens: json,
    );
  }
  
}
