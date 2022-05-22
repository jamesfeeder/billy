class BillData {
  String? name;
  DateTime? timestamp;
  List<String> participants;
  List<String> paidList;
  List<BillItemData> items;

  BillData({
    this.name,
    this.timestamp,
    required this.participants,
    required this.paidList,
    required this.items
  });
}

class BillItemData {
  String name;
  double totalPrice;
  int quantity;
  Map<String,int> participantsData;
  bool equallyPay;

  BillItemData({
    required this.name,
    required this.totalPrice,
    required this.quantity,
    required this.participantsData,
    required this.equallyPay
  });
}
