import '../models/bill_model.dart';
import '../models/participant_model.dart';

List<ParticipantData> generateParticipantBillData(BillData data) {
  List<ParticipantData> participantCardData = [];
  for (String participant in data.participants) {
    List<List<dynamic>> dataList = [];
    double totalPrice = 0;
    for (BillItemData data in data.items) {
      if (data.participantsData.containsKey(participant)) {
        double pricePerItem =
            double.parse((data.totalPrice / data.quantity).toStringAsFixed(2));
        double price = 0;
        if (data.equallyPay) {
          price = double.parse((data.totalPrice / data.participantsData.length)
              .toStringAsFixed(2));
          dataList.add([data.name, price]);
        } else {
          price = double.parse(
              (pricePerItem * data.participantsData[participant]!)
                  .toStringAsFixed(2));
          dataList.add(
              ['${data.name} x${data.participantsData[participant]}', price]);
        }
        totalPrice += price;
      }
    }
    participantCardData.add(ParticipantData(
        name: participant, items: dataList, totalPrice: totalPrice));
  }
  return participantCardData;
}
