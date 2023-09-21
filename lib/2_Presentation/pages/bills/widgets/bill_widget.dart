import 'package:coinpulse2/2_Presentation/bloc/bill_bloc.dart';
import 'package:coinpulse2/2_Presentation/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BillConstructor extends StatelessWidget {
  const BillConstructor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillBloc, BillState>(builder: (context, state) {
      if (state is BillRetrieving) {
        return state.billRetrievedData.isEmpty
            ? const Center(child: Text('Nothing to display'))
            : SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      final entireExpense = state.billRetrievedData;
                      final expenseItem = state.billRetrievedData[index];
                      final convertDate = expenseItem.createdDate;
                      final cDate = DateFormat.yMMMEd().format(convertDate);
                      final cTime = DateFormat.jm().format(convertDate);
                      final clickedItemId = expenseItem.id;
                      final expenseToDelete = entireExpense.firstWhere(
                        (element) => element.id == clickedItemId,
                      );
                      final String idToDelete = expenseToDelete.id;

                      final creationTime =
                          state.billRetrievedData[index].createdDate;
                      final currentDate = DateTime.now();
                      final difference =
                          currentDate.difference(creationTime).inDays;

                      return difference <= 7
                          ? ListTile(
                              leading: const CircleAvatar(
                                backgroundColor: ColorsUsed.secondaryColor,
                                child: Icon(
                                  Icons.camera,
                                  color: ColorsUsed.primaryColor,
                                ),
                              ),
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(expenseItem.title),
                                        Text(cDate),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 40.0),
                                    child: IconButton(
                                        onPressed: () {
                                          showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (_) => AlertDialog(
                                                    title: const Text(
                                                        'Confirmation'),
                                                    content: const Text(
                                                        'Are you sure you wanna delete?'),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            context
                                                                .read<
                                                                    BillBloc>()
                                                                .add(DeleteBill(
                                                                    id: idToDelete));

                                                            context
                                                                .read<
                                                                    BillBloc>()
                                                                .add(
                                                                    RetrieveBill());
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Text(
                                                              'Yes')),
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child:
                                                              const Text('No'))
                                                    ],
                                                  ));
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.redAccent,
                                        )),
                                  )
                                ],
                              ),
                              trailing: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Column(
                                  children: [
                                    Text(
                                      '-ksh ${expenseItem.amount}',
                                      style: const TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                    Text(cTime)
                                  ],
                                ),
                              ),
                            )
                          : const Center(
                              child: Text(
                                  'No expense added during the previous week !'),
                            );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 7,
                        color: Colors.grey[700],
                      );
                    },
                    itemCount: state.billRetrievedData.length),
              );
      }
      return const SizedBox.shrink();
    });
  }
}
