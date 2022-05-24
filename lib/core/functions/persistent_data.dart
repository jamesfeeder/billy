import 'package:shared_preferences/shared_preferences.dart';

void saveBill(String billString) async {
  var prefs = await SharedPreferences.getInstance();
  prefs.setString("bill", billString);
}

Future<String?> loadBill() async {
  var prefs = await SharedPreferences.getInstance();
  return prefs.getString("bill");
}
