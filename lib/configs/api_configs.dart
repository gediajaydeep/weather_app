class ApiConfigs {
  static const String weatherUrl = 'api.openweathermap.org';
  static const String apiKey = '43863022e64feec5674d8e2be9b8be10';

  static String getImageUrl(String icon) {
    return 'https://openweathermap.org/img/wn/$icon@4x.png';
  }
}
