import 'package:billy/core/models/bill_model.dart';
import 'package:billy/core/providers/bill_data_provider.dart';
import 'package:billy/widgets/bill_item_dialog/edit_item_dialog.dart';
import 'package:billy/widgets/bill_item_dialog/remove_item_dialog.dart';
import 'package:billy/widgets/clear_bill_dialog.dart';
import 'package:billy/widgets/participant_dialog/add_name_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../widgets/bill_item_card.dart';
import '../widgets/bill_item_dialog/add_item_dialog.dart';
import '../widgets/participant_dialog/remove_name_dialog.dart';
import '../widgets/participant_dialog/rename_name_dialog.dart';
import '../widgets/participant_card.dart';

class BillPage extends StatefulWidget {
  const BillPage({super.key});

  @override
  State<BillPage> createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> with SingleTickerProviderStateMixin {

  late TabController _tabController;
  late BillData _billData;

  String fabText = "เพิ่มรายการ";

  @override
  void initState() {
    _billData = BillData(
      participants: ["เจมส์","บูม","ต้นน้ำ"],
      paidList: ["เจมส์"],
      items: [
        BillItemData(
          name: "แฮมเบอร์เกอร์",
          totalPrice: 300,
          quantity: 3,
          participantsData: {
            "เจมส์":2,
            "บูม":1
          },
          equallyPay: false
        ),
        BillItemData(
          name: "โค้ก",
          totalPrice: 60,
          quantity: 3,
          participantsData: {
            "เจมส์":1,
            "บูม":2
          },
          equallyPay: true
        )
      ]
    );
    _tabController = TabController(initialIndex: 0,length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        if (_tabController.index == 0) {
          fabText = "เพิ่มรายการ";
        } else {
          fabText = "เพิ่มผู้ชำระ";
        }
      });
    });
    super.initState();
    Provider.of<BillDataProvider>(context, listen: false).billData = _billData;
  }

  @override
  Widget build(BuildContext context) {
    final billDataProvider = Provider.of<BillDataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "billy",
          style: GoogleFonts.sriracha(fontSize: 28),
          ),
        bottom: TabBar(
          labelStyle: Theme.of(context).textTheme.bodyLarge,
          automaticIndicatorColorAdjustment: true,
          indicatorSize: TabBarIndicatorSize.label,
          controller: _tabController,
          tabs: const [
            Tab(text: "รายการ"),
            Tab(text: "ผู้ร่วมชำระ")
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          billDataProvider.billData.items.isEmpty
          ? Center(
            child: Text(
              "ไม่มีรายการ",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.secondary
              )
            )
          )
          : ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: billDataProvider.billData.items.length,
            itemBuilder: (context, index) {
              return BillItemCard(
                data: billDataProvider.billData.items[index],
                editItemAction: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return EditItemDialog(
                          billDataProvider: billDataProvider,
                          index: index
                        );
                      },
                      fullscreenDialog: true
                    )
                  );
                },
                removeItemAction: () {
                  showDialog(
                    context: context, 
                    builder: (context) {
                      return RemoveItemDialog(
                        billDataProvider: billDataProvider,
                        index: index
                      );
                    }
                  );
                },
              );
            }
          ),
          billDataProvider.participantData.isEmpty
          ? Center(
            child: Text(
              "ไม่มีผู้ชำระ",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.secondary
              )
            )
          )
          : ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: billDataProvider.participantData.length,
            itemBuilder: (context, index) {
              return ParticipantCard(
                data: billDataProvider.participantData[index],
                paidList: billDataProvider.billData.paidList,
                markAsPaidAction: (_) {
                  billDataProvider.togglePaid(
                    billDataProvider.participantData[index].name
                  );
                },
                renameAction: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return RenameNameDialog(
                        billDataProvider: billDataProvider,
                        index: index,
                      );
                    }
                  );
                },
                removeAction: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return RemoveNameDialog(
                        billDataProvider: billDataProvider,
                        index: index,
                      );
                    }
                  );
                },
              );
            },
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.surface,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 16, 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ButtonBar(
                children: [
                    TextButton.icon(
                      style: const ButtonStyle(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ClearBillDialog(
                              billDataProvider: billDataProvider
                            );
                          }
                        );
                      },
                      icon: const Icon(Icons.clear),
                      label: const Text("ล้างบิลล์")
                    )
                  ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "ยอดทั้งหมด",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary
                    )
                  ),
                  Text(
                    "${billDataProvider.totalPrice} บาท",
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Theme.of(context).colorScheme.primary
                    )
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_tabController.index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AddItemDialog(
                    billDataProvider: billDataProvider
                  );
                },
                fullscreenDialog: true
              )
            );
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return AddNameDialog(billDataProvider: billDataProvider);
              }
            );
          }
        },
        icon: const Icon(Icons.add),
        label: Text(fabText),
      ),
    );
  }
}
