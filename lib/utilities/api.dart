// Сервис: https://currate.ru/ \\
// Лимит(бесплатный тариф): 1000 запросов в сутки
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_travel_wallet/data/main_data.dart';

class ApiData {
//  String _apiToken = "4df2d72c8a7bbedbce12d39888f37e35";
  String _apiToken = "9832a39cd35297cbb96b049b9a38e36d";
//  String _apiRequestUrl = "http://data.fixer.io/api/latest";
  String _apiRequestUrl = "https://currate.ru/api/";

  void updateApiData(String baseCurrency, List<String> toCurrency) async {
//    http.Response response = await http.get("$_apiRequestUrl?access_key=$_apiToken&base=$baseCurrency",);
    String pairs = "";
    toCurrency.forEach((e) {
      pairs = pairs + baseCurrency + e.toString() + (e == toCurrency.last ? "" : ",");
    });
    print("$_apiRequestUrl?get=rates&pairs=$pairs&key=$_apiToken");
    http.Response response = await http.get("$_apiRequestUrl?get=rates&pairs=$pairs&key=$_apiToken",);
    Map jsonResponse = jsonDecode(response.body);
    if (jsonResponse["status"] == 200) {
      jsonResponse["data"].forEach((key, value) {
        currencyPageDataBox.toMap().forEach((k, v) {
          if (v["currencyCode"] == key.toString().substring(3,6)) {
            Map<dynamic, dynamic> tempValue = v;
            tempValue["currencyValue"] = value;
            currencyPageDataBox.put(k, tempValue);
          }
        });
      });
    }
    print(jsonResponse);
  }
}
