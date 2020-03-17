// Сервис: https://currate.ru/ \\
// Лимит(бесплатный тариф): 1000 запросов в сутки
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:my_travel_wallet/constants.dart';
import 'package:my_travel_wallet/data/main_data.dart';
import 'package:my_travel_wallet/secrets/secrets.dart';

String _apiToken = secretData["currateApiToken"];
String _apiRequestUrl = "https://currate.ru/api/";

class ApiData {
  void addDataToBox(Map jsonResponse) {
    if (jsonResponse["status"] == 200) {
      DateTime dt = DateTime.now();
      jsonResponse["data"].forEach((key, value) {
        Map<dynamic, dynamic> tempDic =
            currencyPageDataBox.get(kCurrencyPageValueKey) ?? {};
        tempDic[key] = {
          "value": value,
        };
        currencyPageDataBox.put(kCurrencyPageValueKey, tempDic);
      });
      currencyPageDataBox.put(kCurrenciesUpdateTimeKey, {
        "updatedAt":
            "${dt.day} ${months[dt.month]["fullDeclination"]} ${dt.hour}:${dt.minute < 10 ? "0" + dt.minute.toString() : dt.minute}"
      });
    }
  }

  void initApiData(List<String> allPairs) async {
    String pairs = "";
    allPairs.forEach((e) {
      pairs += e + (e == allPairs.last ? "" : ",");
    });
    try {
      http.Response response = await http.get(
        "$_apiRequestUrl?get=rates&pairs=$pairs&key=$_apiToken",
      );
      Map jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) addDataToBox(jsonResponse);
    } on SocketException catch (_) {}

//    print(jsonResponse);
  }
}
