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

void initializeData() async {
  await prefs.init();
  initCurrencyPageData();
  if (prefs.getAuthorizedStatus()) await signInWithGoogle();
//  baseCurrencyCardData.init();
  currencies.values.forEach((e) => currencyListInit.add(e["cur_name"]));
  currencies.values.forEach(
      (value) => currencyNameAndCode[value["cur_name"]] = value["cur_code"]);
}

//class BaseCurrencyCardData {
//  String _imageName;
//  String _currencyCode;
//  String _currencyName;
//  String _currencySymbol;

//  void init() {
//    _imageName = currencies[prefs.getBaseCurrency()]["img_name"];
//    _currencyCode = currencies[prefs.getBaseCurrency()]["cur_code"];
//    _currencyName = currencies[prefs.getBaseCurrency()]["cur_name"];
//    _currencySymbol = currencies[prefs.getBaseCurrency()]["cur_symbol"];
//  }

//  String getCurrencyImageName() => _imageName;
//  String getCurrencyName() => _currencyName;
//  String getCurrencyCode() => _currencyCode;
//  String getCurrencySymbol() => _currencySymbol;
//
//  void updateValues(
//      {imageName: String,
//      currencyName: String,
//      currencyCode: String,
//      currencySymbol: String}) {
//    _currencySymbol = currencySymbol;
//    _currencyCode = currencyCode;
//    _currencyName = currencyName;
//    _imageName = imageName;
//  }
//}

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
      0: {
        "currencyCode": currencies["RUB"]["cur_code"],
      }
    });
  }

  List<String> _allPairs = [];
  currencies.forEach((key, value) {
    for (String k in currencies[key]["allowable_cur_list"]) {
      _allPairs.add(key+k);
    }
  });
  ApiData().initApiData(_allPairs);
}
