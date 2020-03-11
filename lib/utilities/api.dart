// Сервис: https://currate.ru/ \\
// Лимит(бесплатный тариф): 1000 запросов в сутки
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_travel_wallet/constants.dart';
import 'package:my_travel_wallet/data/main_data.dart';

String _apiToken = "9832a39cd35297cbb96b049b9a38e36d";
String _apiRequestUrl = "https://currate.ru/api/";

class ApiData {
  void updateApiData(String baseCurrency, List<String> toCurrency) async {
    String pairs = "";
    toCurrency.forEach((e) {
      pairs = pairs +
          baseCurrency +
          e.toString() +
          (e == toCurrency.last ? "" : ",");
    });
    print("$_apiRequestUrl?get=rates&pairs=$pairs&key=$_apiToken");
    http.Response response = await http.get(
      "$_apiRequestUrl?get=rates&pairs=$pairs&key=$_apiToken",
    );
    Map jsonResponse = jsonDecode(response.body);
    addDataToBox(jsonResponse);
    print(currencyPageDataBox.get(kCurrencyPageValueKey));
    print(jsonResponse);
  }

  void addDataToBox(Map jsonResponse) {
    if (jsonResponse["status"] == 200) {
      DateTime dt = DateTime.now();
      jsonResponse["data"].forEach((key, value) {
        Map<dynamic, dynamic> tempDic =
            currencyPageDataBox.get(kCurrencyPageValueKey) ?? {};
        tempDic[key] = {"value": value,};
        currencyPageDataBox.put(kCurrencyPageValueKey, tempDic);
      });
      currencyPageDataBox.put(kCurrenciesUpdateTimeKey, {"updatedAt":
      "${dt.day} ${months[dt.month]} ${dt.hour}:${dt.minute < 10 ? "0" + dt.minute.toString() : dt.minute}"});
    }
  }

  void initApiData(List<String> allPairs) async {
    String pairs = "";
    allPairs.forEach((e) {
      pairs += e + (e == allPairs.last ? "" : ",");
    });
    http.Response response = await http.get(
      "$_apiRequestUrl?get=rates&pairs=$pairs&key=$_apiToken",
    );
    Map jsonResponse = jsonDecode(response.body);
    addDataToBox(jsonResponse);
//    print(jsonResponse);
  }
}
