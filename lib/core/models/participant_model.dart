class ParticipantData {
  String name;
  Map<String,int> items;
  int totalPrice;
  bool isExpanded;

  ParticipantData({
    required this.name,
    required this.items,
    required this.totalPrice,
    this.isExpanded = false
  });
}
