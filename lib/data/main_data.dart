import 'dart:io';
import 'package:my_travel_wallet/constants.dart';
import 'package:my_travel_wallet/utilities/api.dart';
import 'package:my_travel_wallet/utilities/currencies.dart';
import 'package:my_travel_wallet/utilities/google_auth.dart';
import 'package:my_travel_wallet/utilities/shared_preferences.dart';
import 'package:hive/hive.dart';

// ============================== Shared Preferences ============================== \\

MySharedPreferences prefs = MySharedPreferences();
//BaseCurrencyCardData baseCurrencyCardData = BaseCurrencyCardData();

List<String> currencyListInit = [];
Map<String, String> currencyNameAndCode = {};
bool sessionWithConnection = false;

void initializeData() async {
  await prefs.init();
  await initCurrencyPageData();
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      sessionWithConnection = true;
    }
  } on SocketException catch (_) {
    print('not connected');
  }
  try {
    if (prefs.getAuthorizedStatus() && sessionWithConnection)
      await signInWithGoogle();
  } catch (_) {}

//  baseCurrencyCardData.init();
  currencies.values.forEach((e) => currencyListInit.add(e["cur_name"]));
  currencies.values.forEach(
      (value) => currencyNameAndCode[value["cur_name"]] = value["cur_code"]);
}

// ============================== HIVE ============================== \\

Box currencyPageDataBox;
//Box hiveBoxData;

void initCurrencyPageData() async {
  String path = Directory.systemTemp.path;
  Hive.init(path);
  await Hive.openBox(kCurrencyPageDataKey);
  currencyPageDataBox = await Hive.box(kCurrencyPageDataKey);
  if (currencyPageDataBox.get(kBaseCurrencyKey) == null) {
    currencyPageDataBox.put(kBaseCurrencyKey, {
      "currencyCode": currencies["USD"]["cur_code"],
      "currencyName": currencies["USD"]["cur_name"],
      "currencySymbol": currencies["USD"]["cur_symbol"],
      "imageName": currencies["USD"]["img_name"],
    });
  }
  if (currencyPageDataBox.get(kCurrencyPageToConvertCardKey) == null) {
    currencyPageDataBox.put(kCurrencyPageToConvertCardKey, {
      "0": {
        "currencyCode": currencies["RUB"]["cur_code"],
      }
    });
  }
  if (currencyPageDataBox.get(kCurrencyPageEnterSumFieldKey) == null) {
    currencyPageDataBox.put(kCurrencyPageEnterSumFieldKey, {"sum": "1"});
  }

  List<String> _allPairs = [];
  currencies.forEach((key, value) {
    for (String k in currencies[key]["allowable_cur_list"]) {
      _allPairs.add(key + k);
    }
  });
  ApiData().initApiData(_allPairs);

}
