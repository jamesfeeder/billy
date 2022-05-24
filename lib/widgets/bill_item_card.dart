import 'package:billy/core/models/bill_model.dart';
import 'package:flutter/material.dart';

class BillItemCard extends StatelessWidget {
  const BillItemCard({
    Key? key,
    required this.data,
    required this.editItemAction,
    required this.removeItemAction
  }) : super(key: key);

  final BillItemData data;
  final VoidCallback editItemAction;
  final VoidCallback removeItemAction;

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${data.name} x${data.quantity}",
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Theme.of(context).colorScheme.primary
                        )
                      ),
                      data.equallyPay && data.participantsData.isNotEmpty
                      ? Text(
                          "* แบ่งจ่ายเท่ากัน คนละ ${(data.totalPrice/data.participantsData.length).ceil()} บาท",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.secondary
                          ),
                          overflow: TextOverflow.visible,
                          maxLines: 1,
                        )
                      : const SizedBox(height: 0),
                    ],
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Wrap(
                  runSpacing: 8,
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
                )
              ],
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                style: const ButtonStyle(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap
                ),
                onPressed: editItemAction,
                icon: const Icon(Icons.edit),
                label: const Text("แก้ไข")
              ),
              TextButton.icon(
                style: const ButtonStyle(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap
                ),
                onPressed: removeItemAction,
                icon: const Icon(Icons.delete),
                label: const Text("ลบรายการ")
              )
            ],
          ),
        ],
      ),
    );
  }
}
