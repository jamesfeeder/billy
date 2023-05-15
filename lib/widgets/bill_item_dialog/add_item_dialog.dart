import 'package:flutter/material.dart';

import '../../core/models/bill_model.dart';
import '../../core/providers/bill_data_provider.dart';

class AddItemDialog extends StatefulWidget {
  const AddItemDialog({
    Key? key,
    required this.billDataProvider,
  }) : super(key: key);

  final BillDataProvider billDataProvider;

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  final _formKey = GlobalKey<FormState>();
  late BillItemData billItemData;
  late List<String> participants;
  int assignedSlot = 0;

  @override
  void initState() {
    billItemData = BillItemData(
        name: "",
        totalPrice: 0,
        quantity: 1,
        participantsData: {},
        equallyPay: false);
    participants = widget.billDataProvider.billData.participants;
    billItemData.participantsData
        .forEach((key, value) => assignedSlot += value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("แก้ไขรายการ"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(0, 24, 0, 88),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text("ข้อมูลรายการ",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: Theme.of(context).colorScheme.primary)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 80,
                child: TextFormField(
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Theme.of(context).colorScheme.primary),
                  initialValue: billItemData.name,
                  decoration: const InputDecoration(label: Text("ชื่อรายการ")),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "ยังไม่กรอกชื่อรายการ";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      billItemData.name = value;
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 80,
                    width: ((scrWidth - 16) / 2) - 4,
                    child: TextFormField(
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                      initialValue: billItemData.quantity.toString(),
                      decoration: const InputDecoration(label: Text("จำนวน")),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "ยังไม่กรอกจำนวน";
                        } else if (int.tryParse(value) == null) {
                          return "ข้อมูลไม่ถูกต้อง";
                        } else if (int.tryParse(value)! < 1) {
                          return "มีอย่างน้อย 1 หน่วย";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        if (int.tryParse(value) != null) {
                          setState(() {
                            billItemData.quantity = int.parse(value);
                            manageAssignedSlot();
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    width: ((scrWidth - (16 * 4)) / 2) - 4,
                    child: TextFormField(
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                      initialValue: billItemData.totalPrice.toString(),
                      decoration: const InputDecoration(label: Text("ราคารวม")),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "ยังไม่กรอกราคารวม";
                        } else if (double.tryParse(value) == null) {
                          return "ข้อมูลไม่ถูกต้อง";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        if (double.tryParse(value) != null) {
                          setState(() {
                            billItemData.totalPrice = double.parse(value);
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Checkbox(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      value: billItemData.equallyPay,
                      onChanged: (value) {
                        setState(() {
                          billItemData.equallyPay = value!;
                          manageAssignedSlot();
                        });
                      }),
                  Expanded(
                    child: Text("แบ่งจ่ายเท่ากัน",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 8, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("ผู้ร่วมชำระ",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              color: Theme.of(context).colorScheme.primary)),
                  ButtonBar(
                    alignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                          style: const ButtonStyle(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                          onPressed: billItemData.equallyPay
                              ? () {
                                  setState(() {
                                    Map<String, int> value = {};
                                    for (var e in participants) {
                                      value.addAll({e: 1});
                                      assignedSlot++;
                                    }
                                    billItemData.participantsData = value;
                                  });
                                }
                              : null,
                          child: const Text("เลือกทั้งหมด")),
                      OutlinedButton(
                          style: const ButtonStyle(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                          onPressed: () {
                            setState(() {
                              billItemData.participantsData = {};
                              assignedSlot = 0;
                            });
                          },
                          child: const Text("ล้างทั้งหมด"))
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 8,
                children: participants.map((e) {
                  return FilterChip(
                      label: Text(e),
                      selectedColor: Theme.of(context).colorScheme.onSecondary,
                      selected: billItemData.participantsData.containsKey(e),
                      onSelected: !billItemData.participantsData
                                  .containsKey(e) &&
                              billItemData.quantity <= assignedSlot &&
                              !billItemData.equallyPay
                          ? null
                          : (value) {
                              setState(() {
                                if (billItemData.participantsData
                                    .containsKey(e)) {
                                  assignedSlot -=
                                      billItemData.participantsData[e]!.toInt();
                                  billItemData.participantsData.remove(e);
                                } else {
                                  billItemData.participantsData.addAll({e: 1});
                                  assignedSlot++;
                                }
                              });
                            });
                }).toList(),
              ),
            ),
            AnimatedCrossFade(
                firstChild: const SizedBox(),
                secondChild: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text("เลือกผู้ชำระอย่างน้อย 1 ท่าน",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.red[600])),
                ),
                crossFadeState: billItemData.participantsData.isEmpty
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 120)),
            !billItemData.equallyPay && billItemData.participantsData.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                            "${billItemData.quantity - assignedSlot} รายการที่ยังไม่มีเจ้าของ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              billItemData.participantsData.entries.map((e) {
                            return Card(
                              clipBehavior: Clip.hardEdge,
                              margin: const EdgeInsets.only(bottom: 16),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(e.key,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary)),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: e.value > 1
                                                ? () {
                                                    setState(() {
                                                      billItemData
                                                          .participantsData
                                                          .update(
                                                              e.key,
                                                              (value) =>
                                                                  value - 1);
                                                      assignedSlot--;
                                                    });
                                                  }
                                                : null,
                                            icon: const Icon(Icons.remove)),
                                        ConstrainedBox(
                                          constraints: const BoxConstraints(
                                              minWidth: 48),
                                          child: Text(e.value.toString(),
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall
                                                  ?.copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary)),
                                        ),
                                        IconButton(
                                            onPressed: assignedSlot <
                                                    billItemData.quantity
                                                ? () {
                                                    setState(() {
                                                      billItemData
                                                          .participantsData
                                                          .update(
                                                              e.key,
                                                              (value) =>
                                                                  value + 1);
                                                      assignedSlot++;
                                                    });
                                                  }
                                                : null,
                                            icon: const Icon(Icons.add))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  )
                : const SizedBox()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.edit),
        label: const Text("บันทึก"),
        onPressed: () {
          var form = _formKey.currentState;
          if (form!.validate() && billItemData.participantsData.isNotEmpty) {
            widget.billDataProvider.addItem(billItemData);
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  void manageAssignedSlot() {
    if (!billItemData.equallyPay) {
      var itemAmount = billItemData.quantity;
      Map<String, int> newMap = Map.from(billItemData.participantsData);
      if (assignedSlot > itemAmount) {
        assignedSlot = itemAmount;
      }
      var count = 0;
      billItemData.participantsData.forEach((key, value) {
        count += value;
        if (count > itemAmount) {
          if (count - itemAmount < value) {
            newMap.update(key, (value) => value - (count - itemAmount));
          } else {
            newMap.remove(key);
          }
          assignedSlot = itemAmount;
        } else {
          assignedSlot = count;
        }
      });
      billItemData.participantsData = newMap;
    }
  }
}
