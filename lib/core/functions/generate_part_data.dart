import '../models/bill_model.dart';
import '../models/participant_model.dart';

List<ParticipantData> generateParticipantBillData(BillData data) {
  List<ParticipantData> participantCardData = [];
  for (String participant in data.participants) {
    List<List<dynamic>> dataList = [];
    var totalPrice = 0;
    for (BillItemData data in data.items) {
      if (data.participantsData.containsKey(participant)) {
        var pricePerItem = data.totalPrice/data.quantity;
        var price = 0;
        if (data.equallyPay) {
          price = (data.totalPrice/data.participantsData.length).ceil();
          dataList.add([data.name,price]);
        } else {
          price = (pricePerItem*data.participantsData[participant]!.toInt()).ceil();
          dataList.add(['${data.name} x${data.participantsData[participant]}',price]);
        }
        totalPrice += price;
      }
    }
    participantCardData.add(
      ParticipantData(
        name: participant,
        items: dataList,
        totalPrice: totalPrice
      )
    );
  }
  return participantCardData;
}
