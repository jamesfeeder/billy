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
    participants =  List<String>.from(data['participants']),
    paidList = List<String>.from(data['paidList']),
    items = List<Map<String, dynamic>>.from(data['items'])
            .map((e) => BillItemData.fromJson(e))
            .toList();

  Map<String,dynamic> toJson() {
    return {
      'participants':participants,
      'paidList':paidList,
      'items':items.map((e) => e.toJson()).toList()
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
    name = data['name'],
    totalPrice = data['totalPrice'],
    quantity = data['quantity'],
    participantsData = Map.from(data['participantsData']),
    equallyPay = data['equallyPay'];

  Map<String,dynamic> toJson() {
    return {
      'name':name,
      'totalPrice':totalPrice,
      'quantity':quantity,
      'participantsData':participantsData,
      'equallyPay':equallyPay
    };
  }
}
