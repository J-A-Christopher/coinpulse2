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
  Widget build(BuildContext context) {
    return BlocBuilder<IncomeBloc, IncomeState>(builder: (context, state) {
      if (state is IncomeRetrieving) {
        return state.incomeRetrievedData.isEmpty
            ? const Center(child: Text('Nothing to display'))
            : SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      final expenseItem = state.incomeRetrievedData[index];
                      final convertDate = expenseItem.createdDate;
                      final cDate = DateFormat.yMMMEd().format(convertDate);
                      final cTime = DateFormat.jm().format(convertDate);

                      return ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: ColorsUsed.secondaryColor,
                          child: Icon(
                            Icons.camera,
                            color: ColorsUsed.primaryColor,
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(expenseItem.title),
                            Text(cDate),
                          ],
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
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
