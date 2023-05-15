class ParticipantData {
  String name;
  List<List<dynamic>> items;
  double totalPrice;
  bool isExpanded;

  ParticipantData(
      {required this.name,
      required this.items,
      required this.totalPrice,
      this.isExpanded = false});
}
