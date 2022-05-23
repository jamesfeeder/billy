import 'package:billy/core/models/bill_model.dart';
import 'package:flutter/material.dart';

class BillItemCard extends StatelessWidget {
  const BillItemCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  final BillItemData data;

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Text(
                    "${data.name} x${data.quantity}",
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Theme.of(context).colorScheme.primary
                    )
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${data.totalPrice.toString()} บาท",
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Theme.of(context).colorScheme.primary
                      )
                    ),
                    Text(
                      "${(data.totalPrice/data.quantity).ceil()} บาท/รายการ",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.secondary
                      )
                    )
                  ],
                )
              ],
            ),
            Wrap(
              spacing: 8,
              children: data.participantsData.entries.map((e) {
                return Chip(
                  label: Text(
                    data.equallyPay
                    ? e.key
                    : "${e.key} x${e.value}",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary
                    )
                  )
                );
                }).toList(),
            ),
            SizedBox(
              height: data.equallyPay && data.participantsData.isNotEmpty ? 8 : 0,
            ),
            data.equallyPay && data.participantsData.isNotEmpty
            ? Text(
                "* หารเท่ากัน คนละ ${(data.totalPrice/data.participantsData.length).ceil()} บาท",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.secondary
                )
              )
            : const SizedBox()
          ],
        ),
      ),
    );
  }
}
