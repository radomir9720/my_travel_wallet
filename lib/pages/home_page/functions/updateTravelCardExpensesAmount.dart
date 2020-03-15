import 'package:my_travel_wallet/data/main_data.dart';

import '../../../constants.dart';

void updateExpensesAmount(String travelCardKey) {
  Map<dynamic, dynamic> generalTempMap =
  (currencyPageDataBox.get(kHomePageTravelCardKey));
  Map<dynamic, dynamic> tempMap = generalTempMap[travelCardKey];
  double travelAmount = 0;
  (currencyPageDataBox.get(kHomePageTravelExpensesKey) ??
      {}[travelCardKey])
      .forEach((key, value) {
    value.forEach((k, v) {
      travelAmount += double.parse(v["convertedExpenseSum"]);
    });
  });
  tempMap["expensesAmount"] = travelAmount;
  generalTempMap[travelCardKey] = tempMap;
  currencyPageDataBox.put(kHomePageTravelCardKey, generalTempMap);
}