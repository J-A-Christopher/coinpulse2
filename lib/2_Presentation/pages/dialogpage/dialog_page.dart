import 'package:coinpulse2/0_Data/models/bill_model.dart';
import 'package:coinpulse2/2_Presentation/bloc/bill_bloc.dart';
import 'package:coinpulse2/2_Presentation/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DialogueWrapper extends StatelessWidget {
  const DialogueWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BillBloc(),
      child: const DialogPage(),
    );
  }
}

class DialogPage extends StatefulWidget {
  const DialogPage({super.key});

  @override
  State<DialogPage> createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  ExpenseModel newBill = ExpenseModel(
      amount: '',
      createdDate: DateTime.now(),
      title: '',
      id: DateTime.now().toString());

  void _submitForm() {
    formState.currentState!.save();

    context.read<BillBloc>().add(CreateBill(createdBill: newBill));
    context.read<BillBloc>().add(RetrieveBill());
    context.read<BillBloc>().add(GetTotalAmount());

    Navigator.of(context).pop();
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create an expense'),
          content: Form(
              key: formState,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    onSaved: (value) {
                      newBill = ExpenseModel(
                          amount: '',
                          createdDate: DateTime.now(),
                          title: value!,
                          id: DateTime.now.toString());
                    },
                    decoration: const InputDecoration(hintText: 'Expense name'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      newBill = ExpenseModel(
                          amount: value!,
                          createdDate: DateTime.now(),
                          title: newBill.title,
                          id: DateTime.now().toString());
                    },
                    decoration:
                        const InputDecoration(hintText: 'Expense amount'),
                  )
                ],
              )),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel')),
            TextButton(onPressed: _submitForm, child: const Text('Submit'))
          ],
        );
      },
    );
  }

  void showIncomeDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Enter Income'),
            content: Form(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Income name'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Income amount'),
                ),
              ],
            )),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel')),
              TextButton(onPressed: () {}, child: const Text('Submit'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Coin Pulse'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Card(
                child: Container(
                  decoration:
                      const BoxDecoration(color: ColorsUsed.secondaryColor),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Column(
                              children: [
                                Text('Total Balance (Ksh)'),
                                Text('34')
                              ],
                            ),
                            const SizedBox(
                              width: 130,
                            ),
                            Column(
                              children: [
                                const Text('Income (Ksh)'),
                                GestureDetector(
                                  onTap: showIncomeDialog,
                                  child: const Text('34'),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                const Text('Total Expenses (Ksh)'),
                                BlocBuilder<BillBloc, BillState>(
                                    builder: (context, state) {
                                  if (state is TotalAmountRetrieved) {
                                    return Text('${state.totalAmount}');
                                  }
                                  return const Text('0');
                                })
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            BlocBuilder<BillBloc, BillState>(builder: (context, state) {
              if (state is BillCreating) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is BillRetrieving) {
                return state.billRetrievedData.isEmpty
                    ? const Text('Noting to display')
                    : Text(state.billRetrievedData.first.title);
              }
              return const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }
}
