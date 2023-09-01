import 'package:coinpulse2/2_Presentation/pages/bills/widgets/bill_widget.dart';
import 'package:coinpulse2/2_Presentation/pages/dialogpage/dialog_page.dart';
import 'package:coinpulse2/2_Presentation/pages/income/income.dart';
import 'package:flutter/material.dart';

class TopTabBar extends StatefulWidget {
  const TopTabBar({super.key});

  @override
  State<TopTabBar> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<TopTabBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: const Color(0xfff8f6f0),
            body: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    bottom: const TabBar(
                        indicatorSize: TabBarIndicatorSize.label,
                        isScrollable: true,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          Tab(
                            text: 'Expenses',
                          ),
                          Tab(
                            text: 'Incomes',
                          ),
                        ]),
                  ),
                ),
                const Expanded(
                    child: TabBarView(
                        children: [BillConstructor(), IncomeConstructor()])),
              ],
            )),
      ),
    );
  }
}
