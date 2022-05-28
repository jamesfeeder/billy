class BillData {
  List<String> participants;
  List<String> paidList;
  List<BillItemData> items;

  BillData({
    required this.participants,
    required this.paidList,
    required this.items
  });

  BillData.fromJson(Map<String,dynamic> data):
    participants =  List<String>.from(data['p']),
    paidList = List<String>.from(data['pl']),
    items = List<Map<String, dynamic>>.from(data['i'])
            .map((e) => BillItemData.fromJson(e))
            .toList();

  Map<String,dynamic> toJson() {
    return {
      'p':participants,
      'pl':paidList,
      'i':items.map((e) => e.toJson()).toList()
    };
  }
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

  BillItemData.from(BillItemData data):
    name = data.name,
    totalPrice = data.totalPrice,
    quantity = data.quantity,
    participantsData = data.participantsData,
    equallyPay = data.equallyPay;

  BillItemData.fromJson(Map<String,dynamic> data):
    name = data['n'],
    totalPrice = data['tp'],
    quantity = data['q'],
    participantsData = Map.from(data['pd']),
    equallyPay = data['ep'];

  Map<String,dynamic> toJson() {
    return {
      'n':name,
      'tp':totalPrice,
      'q':quantity,
      'pd':participantsData,
      'ep':equallyPay
    };
  }
}
