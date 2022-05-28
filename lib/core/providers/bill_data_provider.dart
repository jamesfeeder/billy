import 'package:flutter/material.dart';

import '../functions/data_convert.dart';
import '../functions/generate_part_data.dart';
import '../functions/persistent_data.dart';
import '../models/bill_model.dart';
import '../models/participant_model.dart';

class BillDataProvider extends ChangeNotifier {

  BillData _billData = BillData(
    participants: [],
    paidList: [],
    items: []
  );
  BillData get billData => _billData;

  List<ParticipantData> _participantData = [];
  List<ParticipantData> get participantData => _participantData;

  int _totalPrice = 0;
  int get totalPrice => _totalPrice;

  set billData(BillData data) {
    _billData = data;
    _participantData = generateParticipantBillData(_billData);
    _totalPrice = calculateTotalPrice(_billData.items);
    save();
  }

  int calculateTotalPrice(List<BillItemData> data) {
    var sum = 0.0;
    for (var i in data) {
      sum += i.totalPrice;
    }
    return sum.ceil();
  }

  void addItem(BillItemData item) {
    BillData newBillData = _billData;
    newBillData.items.add(item);
    billData = newBillData;
    notifyListeners();
  }

  void editItem(int index, BillItemData item) {
    BillData newBillData = _billData;
    newBillData.items[index] = item;
    billData = newBillData;
    notifyListeners();
  }

  void removeItem(int index) {
    BillData newBillData = _billData;
    newBillData.items.removeAt(index);
    billData = newBillData;
    notifyListeners();
  }

  void addParticipant(String name) {
    BillData newBillData = _billData;
    newBillData.participants.add(name);
    billData = newBillData;
    notifyListeners();
  }

  void renameParticipant(String oldName, String newName) {
    BillData newBillData = _billData;

    var index = newBillData.participants.indexOf(oldName);
    newBillData.participants[index] = newName;

    if (newBillData.paidList.contains(oldName)) {
      var index = newBillData.paidList.indexOf(oldName);
      newBillData.paidList[index] = newName;
    }

    for (BillItemData item in newBillData.items) {
      if (item.participantsData.containsKey(oldName)) {
        int v = item.participantsData[oldName]!.toInt();
        item.participantsData.addAll({newName:v});
        item.participantsData.remove(oldName);
      }
    }

    billData = newBillData;
    notifyListeners();
  }

  void removeParticipant(String name) {
    BillData newBillData = _billData;

    newBillData.participants.remove(name);

    if (newBillData.paidList.contains(name)) {
      newBillData.paidList.remove(name);
    }

    for (BillItemData item in newBillData.items) {
      if (item.participantsData.containsKey(name)) {
        item.participantsData.remove(name);
      }
    }

    billData = newBillData;
    notifyListeners();
  }

  void togglePaid(String name) {
    BillData newBillData = _billData;
    
    if (newBillData.paidList.contains(name)) {
      newBillData.paidList.remove(name);
    } else {
      newBillData.paidList.add(name);
    }

    billData = newBillData;
    notifyListeners();
  }

  void clear() {
    billData = BillData(
      participants: [], 
      paidList: [], 
      items: []
    );
    notifyListeners();
  }

  void save() {
    saveBill(billDataToBase64(_billData));
  }

  void load() async {
    var billString = await loadBill();
    if (billString != null) {
      billData = base64ToBillData(billString);
    } else {
      billData = BillData(
        participants: [], 
        paidList: [], 
        items: []
      );
    }
    notifyListeners();
  }
}
