import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/models/bill_model.dart';
import '../../core/providers/bill_data_provider.dart';

class RenameNameDialog extends StatefulWidget {
  const RenameNameDialog({
    Key? key,
    required this.billDataProvider,
    required this.index
  }) : super(key: key);

  final BillDataProvider billDataProvider;
  final int index;

  @override
  State<RenameNameDialog> createState() => _RenameNameDialogState();
}

class _RenameNameDialogState extends State<RenameNameDialog> {
  late String _oldName;
  late String _newName;
  late BillData _billData;
  late TextEditingController _controller;
  bool canSave = false;

  @override
  void initState() {
    _billData = widget.billDataProvider.billData;
    _oldName = _newName = widget.billDataProvider
                                .participantData[widget.index].name;
    _controller = TextEditingController(text: _newName);
    _controller.addListener(updateState);
    super.initState();
  }

  void updateState() {
    var value = _controller.text;
    setState(() {
      if (value.isEmpty) {
        canSave = false;
      } else if (_billData.participants.contains(value)) {
        canSave = false;
      } else {
        canSave = true;
      }
    });
  }

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
              padding: const EdgeInsets.all(16),
              child: Text(
                "แก้ไขชื่อ",
                style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: Theme.of(context).colorScheme.primary
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 72,
                child: TextFormField(
                  controller: _controller,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary
                  ),
                  decoration: const InputDecoration(hintText: "ชื่อ"),
                  autofocus: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    _newName = value!;
                    if (value.isEmpty) {
                      canSave = false;
                      return "ยังไม่กรอกชื่อ";
                    } else if (_billData.participants.contains(value)) {
                      canSave = false;
                      return "มีชื่อนี้อยู่แล้ว";
                    } else {
                      canSave = true;
                      return null;
                    }
                  }
                ),
              ),
            ),
            ButtonBar(
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("ยกเลิก")
                ),
                TextButton(
                  onPressed: canSave
                  ? () {
                    widget.billDataProvider
                          .renameParticipant(
                            _oldName,
                            _newName
                          );
                    Navigator.pop(context);
                  }
                  : null,
                  child: const Text("บันทึก")
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
