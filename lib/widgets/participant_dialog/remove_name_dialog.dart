import 'package:flutter/material.dart';

import '../../core/providers/bill_data_provider.dart';

class RemoveNameDialog extends StatelessWidget {
  const RemoveNameDialog({
    Key? key,
    required this.billDataProvider,
    required this.index
  }) : super(key: key);

  final BillDataProvider billDataProvider;
  final int index;

  @override
  Widget build(BuildContext context) {
    var name = billDataProvider.participantData[index].name;
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "ลบชื่อ",
              style: Theme.of(context).textTheme.headline6?.copyWith(
                color: Theme.of(context).colorScheme.primary
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'ลบ "$name" ออกจากรายชื่อ?',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary
              )
            ),
          ),
          ButtonBar(
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("ยกเลิก")
              ),
              TextButton(
                onPressed: () {
                  billDataProvider.removeParticipant(name);
                  Navigator.pop(context);
                },
                child: const Text("ลบ")
              )
            ],
          )
        ],
      ),
    );
  }
}
