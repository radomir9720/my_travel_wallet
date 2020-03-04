// Сервис: https://fixer.io/ \\
// Лимит(бесплатный тариф): 1000 API запросов в месяц(календарный)
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiData {

  String _apiToken = "4df2d72c8a7bbedbce12d39888f37e35";
  String _apiRequestUrl = "";

  void updateApiData() async {
    http.Response response = await http.get(_apiRequestUrl,);
    Map jsonResponse = jsonDecode(response.body);
  }

}