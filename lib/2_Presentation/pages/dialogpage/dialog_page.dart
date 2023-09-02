import 'package:coinpulse2/0_Data/models/bill_model.dart';
import 'package:coinpulse2/0_Data/models/income_model.dart';
import 'package:coinpulse2/2_Presentation/bloc/bill_bloc.dart';
import 'package:coinpulse2/2_Presentation/bloc/income_bloc.dart';
import 'package:coinpulse2/2_Presentation/core/utils/colors.dart';
import 'package:coinpulse2/2_Presentation/pages/tab_bar/tab_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DialogueWrapper extends StatelessWidget {
  const DialogueWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BillBloc>(
          create: (context) => BillBloc(),
        ),
        BlocProvider(
          create: (context) => IncomeBloc(),
        ),
      ],
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
  GlobalKey<FormState> incomeState = GlobalKey<FormState>();

  ExpenseModel newBill = ExpenseModel(
      amount: '',
      createdDate: DateTime.now(),
      title: '',
      id: DateTime.now().toString());

  IncomeModel newIncome = IncomeModel(
      amount: '',
      createdDate: DateTime.now(),
      title: '',
      id: DateTime.now().toString());

  void _submitForm() {
    formState.currentState!.save();
    final billBloc = context.read<BillBloc>();

    billBloc.add(CreateBill(createdBill: newBill));

    billBloc.add(RetrieveBill());
    context.read<BillBloc>().add(GetTotalAmount());

    Navigator.of(context).pop();
  }

  void saveIncomeForm() {
    incomeState.currentState!.save();

    context.read<IncomeBloc>().add(CreateIncome(createIncome: newIncome));

    context.read<IncomeBloc>().add(RetrieveIncome());

    Navigator.of(context).pop();
  }

  void _showDialog() {
    List<String> expenseCategoryTypes = [
      'shopping',
      'repairs',
      'fees/education',
      'rent',
      'healthcare',
      'entertainment',
      'debt',
      'savings',
      'tax',
      'Transport',
      'other'
    ];
    showDialog(
      context: context,
      builder: (context) {
        return BlocProvider<BillBloc>(
          create: (_) => BillBloc(),
          child: AlertDialog(
            title: const Text('Create an expense'),
            content: Form(
                key: formState,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField(
                      items: expenseCategoryTypes
                          .map((String type) => DropdownMenuItem<String>(
                                value: type,
                                child: Text(
                                  type,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      onSaved: (value) {
                        newBill = ExpenseModel(
                            amount: '',
                            createdDate: DateTime.now(),
                            title: value!,
                            id: DateTime.now.toString());
                      },
                      onChanged: (String? value) {
                        setState(() {
                          //selectedValue = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Input Cannot Be Empty !';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        contentPadding: EdgeInsets.all(8),
                        hintText: 'Select Expense Category',
                      ),
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
              TextButton(
                  onPressed: () {
                    _submitForm();
                    //BlocProvider.of<BillBloc>(context).add(GetTotalAmount());
                  },
                  child: const Text('Submit'))
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<BillBloc>().add(RetrieveBill());
    //context.read<IncomeBloc>().add(GetTotalIncomeAmount());
  }

  void showIncomeDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Enter Income'),
            content: Form(
                key: incomeState,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      onSaved: (value) {
                        newIncome = IncomeModel(
                            amount: newIncome.amount,
                            createdDate: DateTime.now(),
                            title: value!,
                            id: DateTime.now().toString());
                      },
                      decoration:
                          const InputDecoration(hintText: 'Income name'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onSaved: (value) {
                        newIncome = IncomeModel(
                            amount: value!,
                            createdDate: DateTime.now(),
                            title: newIncome.title,
                            id: DateTime.now().toString());
                      },
                      decoration:
                          const InputDecoration(hintText: 'Income amount'),
                    ),
                  ],
                )),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel')),
              TextButton(onPressed: saveIncomeForm, child: const Text('Submit'))
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
        child: ListView(
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
                                  child: BlocBuilder<IncomeBloc, IncomeState>(
                                    builder: (context, state) {
                                      if (state is TotalIncomeRetrieved) {
                                        print('kk${state.totalAmount}');
                                        return Text('${state.totalAmount}');
                                      }
                                      return const Text('00');
                                    },
                                  ),
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
                                    print('kj${state.totalAmount}');
                                    return Text('${state.totalAmount}');
                                  }
                                  return const Text('00');
                                }),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const TopTabBar(),
          ],
        ),
      ),
    );
  }
}
