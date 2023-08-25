import 'package:coinpulse2/0_Data/exception/general_exception.dart';
import 'package:coinpulse2/0_Data/models/bill_model.dart';

abstract class BillDataSource {
  ExpenseModel createBill(ExpenseModel model);
  int tAmount();
}

class BillStore implements BillDataSource {
  final List<ExpenseModel> _expenseModel = [];

  List<ExpenseModel> get billModel => [..._expenseModel];

  @override
  ExpenseModel createBill(ExpenseModel model) {
    try {
      var newBill = ExpenseModel(
          amount: model.amount,
          createdDate: model.createdDate,
          id: model.id,
          title: model.title);
      _expenseModel.add(newBill);
      print(_expenseModel.first.title);
      return newBill;
    } catch (error) {
      throw ErrorException();
    }
  }

  @override
  int tAmount() {
    int totalExpenses = 0;
    final amount =
        _expenseModel.map((expenses) => int.tryParse(expenses.amount)).toList();
    totalExpenses =
        amount.fold(0, (previousValue, element) => previousValue + element!);

    print('hem$totalExpenses');

    return totalExpenses;
  }
}
