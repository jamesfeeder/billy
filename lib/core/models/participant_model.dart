class ParticipantData {
  String name;
  List<List<dynamic>> items;
  int totalPrice;
  bool isExpanded;

  ParticipantData({
    required this.name,
    required this.items,
    required this.totalPrice,
    this.isExpanded = false
  });
}
