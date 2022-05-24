import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:billy/core/models/bill_model.dart';

String billDataToBase64(BillData data) {
  var jsonString = json.encode(data);
  var jsonBytes = utf8.encode(jsonString);
  var gzipBytes = GZipEncoder().encode(jsonBytes, level: 9);
  var b64String = base64Url.encode(gzipBytes!);
  return b64String;
}

BillData base64ToBillData(String data) {
  var gzipBytes = base64Url.decode(data);
  var jsonBytes = GZipDecoder().decodeBytes(gzipBytes);
  var jsonString = utf8.decode(jsonBytes);
  var jsonObj = json.decode(jsonString);
  return BillData.fromJson(jsonObj);
}
