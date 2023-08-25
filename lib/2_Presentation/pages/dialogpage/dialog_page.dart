import 'package:coinpulse2/0_Data/models/bill_model.dart';
import 'package:coinpulse2/2_Presentation/bloc/bill_bloc.dart';
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
  var newBill = BillModel(billAmount: '', billName: '');

  void _submitForm() {
    formState.currentState!.save();

    context.read<BillBloc>().add(CreateBill(createdBill: newBill));
    context.read<BillBloc>().add(RetrieveBill());

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
                      newBill = BillModel(
                          billAmount: newBill.billAmount, billName: value!);
                    },
                    decoration: const InputDecoration(hintText: 'Name of bill'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      newBill = BillModel(
                          billAmount: value!, billName: newBill.billName);
                    },
                    decoration:
                        const InputDecoration(hintText: 'Amount of bill'),
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
      body: Column(
        children: [
          BlocBuilder<BillBloc, BillState>(builder: (context, state) {
            if (state is BillCreating) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is BillRetrieving) {
              return state.billRetrievedData.isEmpty
                  ? const Text('Noting to display')
                  : Text(state.billRetrievedData.first.billAmount);
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
