import 'package:billy/core/models/bill_model.dart';
import 'package:billy/core/providers/bill_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../widgets/bill_item_card.dart';
import '../widgets/remove_name_dialog.dart';
import '../widgets/rename_name_dialog.dart';
import '../widgets/participant_card.dart';

class BillPage extends StatefulWidget {
  const BillPage({super.key});

  @override
  State<BillPage> createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> with SingleTickerProviderStateMixin {

  late TabController _tabController;
  late BillData _billData;

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
    _tabController = TabController(initialIndex: 1,length: 2, vsync: this);
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
            Tab(text: "รายการหนี้"),
            Tab(text: "ผู้ร่วมชะตากรรม")
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: billDataProvider.billData.items.length,
            itemBuilder: (context, index) {
              return BillItemCard(data: billDataProvider.billData.items[index]);
            }
          ),
          ListView.builder(
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
          padding: const EdgeInsets.all(16),
          child: Column(
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
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Test Dialog")
                    ],
                  ),
                ),
              );
            }
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
