import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:my_travel_wallet/utilities/currencies.dart';
import 'package:my_travel_wallet/utilities/google_auth.dart';
import 'package:my_travel_wallet/utilities/shared_preferences.dart';
import 'package:my_travel_wallet/data/hive.dart';
import 'package:hive/hive.dart';

import '../constants.dart';

// ============================== Shared Preferences ============================== \\

MySharedPreferences prefs = MySharedPreferences();
BaseCurrencyCardData baseCurrencyCardData = BaseCurrencyCardData();

List<String> currencyListInit = [];
Map<String, String> currencyNameAndCode = {};

void initializeData() async {
  await prefs.init();
  initCurrencyPageData();
  if (prefs.getAuthorizedStatus()) await signInWithGoogle();
  baseCurrencyCardData.init();
  currencies.values.forEach((e) => currencyListInit.add(e["cur_name"]));
  currencies.values.forEach(
      (value) => currencyNameAndCode[value["cur_name"]] = value["cur_code"]);
}

class BaseCurrencyCardData {
  String _imageName;
  String _currencyCode;
  String _currencyName;
  String _currencySymbol;

  void init() {
    _imageName = currencies[prefs.getBaseCurrency()]["img_name"];
    _currencyCode = currencies[prefs.getBaseCurrency()]["cur_code"];
    _currencyName = currencies[prefs.getBaseCurrency()]["cur_name"];
    _currencySymbol = currencies[prefs.getBaseCurrency()]["cur_symbol"];
  }

  String getCurrencyImageName() => _imageName;
  String getCurrencyName() => _currencyName;
  String getCurrencyCode() => _currencyCode;
  String getCurrencySymbol() => _currencySymbol;

  void updateValues(
      {imageName: String,
      currencyName: String,
      currencyCode: String,
      currencySymbol: String}) {
    _currencySymbol = currencySymbol;
    _currencyCode = currencyCode;
    _currencyName = currencyName;
    _imageName = imageName;
  }
}

// ============================== HIVE ============================== \\

void initCurrencyPageData() async {
  Box currencyPageDataBox;
  String path = Directory.systemTemp.path;
  Hive
    ..init(path)
    ..registerAdapter(CurrencyDataModelAdapter());
  await Hive.openBox(kCurrencyPageDataKey);
  currencyPageDataBox = await Hive.box(kCurrencyPageDataKey);
}
