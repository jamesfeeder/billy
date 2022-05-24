import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/providers/bill_data_provider.dart';

class RemoveItemDialog extends StatelessWidget {
  const RemoveItemDialog({
    Key? key,
    required this.billDataProvider,
    required this.index
  }) : super(key: key);

  final BillDataProvider billDataProvider;
  final int index;

  @override
  Widget build(BuildContext context) {
    var name = billDataProvider.billData.items[index].name;
    var quantity = billDataProvider.billData.items[index].quantity;
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
                "ลบรายการ",
                style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: Theme.of(context).colorScheme.primary
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'ลบ "$name x$quantity" ออกจากรายการ?',
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
                    billDataProvider.removeItem(index);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "ลบ",
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
