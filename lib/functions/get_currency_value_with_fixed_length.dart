String getCurrencyValueWithFixedLength(
    double doubleValue, String currencySymbol) {
  String retValue;
  if (doubleValue > 1000000000000) {
    retValue = (doubleValue / 1000000000000).toStringAsFixed(2) +
        " трлн $currencySymbol";
  } else if (doubleValue > 1000000000) {
    retValue = (doubleValue / 1000000000).toStringAsFixed(2) +
        " млрд $currencySymbol";
  } else if (doubleValue > 1000000) {
    retValue =
        (doubleValue / 1000000).toStringAsFixed(2) + " млн $currencySymbol";
  } else if (doubleValue > 100000) {
    retValue =
        (doubleValue / 1000).toStringAsFixed(2) + " тыс $currencySymbol";
  } else {
    retValue = doubleValue.toStringAsFixed(2) + " $currencySymbol";
  }
  return retValue;
}