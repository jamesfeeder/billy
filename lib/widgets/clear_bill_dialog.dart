import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/providers/bill_data_provider.dart';

class ClearBillDialog extends StatelessWidget {
  const ClearBillDialog({
    Key? key,
    required this.billDataProvider
  }) : super(key: key);

  final BillDataProvider billDataProvider;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: min(400, double.infinity),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "ล้างบิลล์",
                style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: Theme.of(context).colorScheme.primary
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'ทุกอย่างจะถูกลบออก ดำเนินการต่อ?',
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
                    billDataProvider.clear();
                    Navigator.pop(context);
                  },
                  child: Text(
                    "ตกลง",
                    style: TextStyle(color: Colors.red[900]),
                  )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
