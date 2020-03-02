class Singleton {
  static bool themeMode;
  static final Singleton _singleton = Singleton._internal();

  factory Singleton(String themeMode) {
    return _singleton;
  }

  Singleton._internal();
}