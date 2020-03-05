import 'package:my_travel_wallet/utilities/currencies.dart';
import 'package:my_travel_wallet/utilities/shared_preferences.dart';

MySharedPreferences prefs = MySharedPreferences();
BaseCurrencyCardData baseCurrencyCardData = BaseCurrencyCardData();

List<String> currencyListInit = [];
Map<String, String> currencyNameAndCode = {};

Future<bool> initializeData() async {
  await prefs.init();
  baseCurrencyCardData.init();
  currencies.values.forEach((e) => currencyListInit.add(e["cur_name"]));
  currencies.values.forEach(
      (value) => currencyNameAndCode[value["cur_name"]] = value["cur_code"]);
  return true;
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
