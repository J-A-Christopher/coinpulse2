import 'package:coinpulse2/2_Presentation/bloc/income_bloc.dart';
import 'package:coinpulse2/2_Presentation/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class IncomeConstructor extends StatefulWidget {
  const IncomeConstructor({
    super.key,
  });

  @override
  State<IncomeConstructor> createState() => _IncomeConstructorState();
}

class _IncomeConstructorState extends State<IncomeConstructor> {
  @override
  void initState() {
    super.initState();
    context.read<IncomeBloc>().add(RetrieveIncome());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IncomeBloc, IncomeState>(builder: (context, state) {
      if (state is IncomeRetrieving) {
        return state.incomeRetrievedData.isEmpty
            ? const Center(
                child: Text(
                    'Nothing to display tap on the two zeros below Income(ksh) text to add an income.'))
            : SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      final entireExpense = state.incomeRetrievedData;
                      final expenseItem = state.incomeRetrievedData[index];
                      final convertDate = expenseItem.createdDate;
                      final cDate = DateFormat.yMMMEd().format(convertDate);
                      final cTime = DateFormat.jm().format(convertDate);
                      final clickedItemId = expenseItem.id;
                      final expenseToDelete = entireExpense.firstWhere(
                        (element) => element.id == clickedItemId,
                      );
                      final String idToDelete = expenseToDelete.id;

                      return ListTile(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    //print(idToDelete);
                                    context
                                        .read<IncomeBloc>()
                                        .add(DeleteIncome(id: idToDelete));

                                    context
                                        .read<IncomeBloc>()
                                        .add(RetrieveIncome());
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                  )),
                            )
                          ],
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Column(
                            children: [
                              Text(
                                '+ksh ${expenseItem.amount}',
                                style: const TextStyle(
                                  color: ColorsUsed.selectedNavColor,
                                ),
                              ),
                              Text(cTime)
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 7,
                        color: Colors.grey[700],
                      );
                    },
                    itemCount: state.incomeRetrievedData.length),
              );
      }
      return const SizedBox.shrink();
    });
  }
}
