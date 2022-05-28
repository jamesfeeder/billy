import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../core/models/participant_model.dart';

class ParticipantCard extends StatelessWidget {
  const ParticipantCard({
    Key? key,
    required this.data,
    required this.paidList,
    required this.markAsPaidAction,
    required this.renameAction,
    required this.removeAction
  }) : super(key: key);

  final ParticipantData data;
  final List<String> paidList;
  final void Function(bool?)? markAsPaidAction;
  final VoidCallback? renameAction;
  final VoidCallback? removeAction;

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpandablePanel(
        theme: ExpandableThemeData(
          iconColor: Theme.of(context).colorScheme.primary,
          inkWellBorderRadius: BorderRadius.circular(12),
          headerAlignment: ExpandablePanelHeaderAlignment.center
        ),
        header: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      data.name,
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: Theme.of(context).colorScheme.primary
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: AnimatedOpacity(
                        opacity: paidList.contains(data.name) ? 1 : 0,
                        duration: const Duration(milliseconds: 120),
                        curve: Curves.linear,
                        child: Chip(
                          label: Text(
                            "จ่ายแล้ว",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.green[900]
                            )
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                "${data.totalPrice} บาท",
                style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: Theme.of(context).colorScheme.primary
                )
              ),
            ],
          ),
        ),
        collapsed: const SizedBox(width: 0,), 
        expanded: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12)
              ),
              child: data.items.isNotEmpty 
              ? Column(
                  children: data.items
                  .map((e) {
                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          e[0],
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary
                          )
                        ),
                        Text(
                          '${e[1]} บาท',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary
                          )
                        ),
                      ],
                    );
                  }).toList(),
                )
              : Align(
                alignment: Alignment.center,
                child: Text(
                  "ไม่มีรายการ",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary
                  )
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)
                          ),
                          fillColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.primary
                          ),
                          value: paidList.contains(data.name),
                          onChanged: markAsPaidAction
                        ),
                        Expanded(
                          child: Text(
                            "จ่ายแล้ว",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      style: const ButtonStyle(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap
                      ),
                      onPressed: renameAction,
                      icon: const Icon(Icons.edit),
                      label: const Text("เปลี่ยนชื่อ")
                    ),
                    TextButton.icon(
                      style: const ButtonStyle(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap
                      ),
                      onPressed: removeAction,
                      icon: const Icon(Icons.delete),
                      label: const Text("ลบชื่อ")
                    )
                  ],
                ),
              ],
            )
          ],
        )
      ),
    );
  }
}
