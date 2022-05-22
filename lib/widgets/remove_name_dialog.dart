import 'package:flutter/material.dart';

import '../core/providers/bill_data_provider.dart';

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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16,16,16,4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ลบชื่อ",
              style: Theme.of(context).textTheme.headline6?.copyWith(
                color: Theme.of(context).colorScheme.primary
              )
            ),
            const SizedBox(height: 8,),
            Text(
              'ลบ "$name" ออกจากรายชื่อ?',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary
              )
            ),
            const SizedBox(height: 4,),
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
      ),
    );
  }
}
