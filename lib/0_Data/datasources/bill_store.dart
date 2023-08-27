import 'package:coinpulse2/0_Data/exception/general_exception.dart';
import 'package:coinpulse2/0_Data/models/bill_model.dart';
import 'package:coinpulse2/0_Data/models/income_model.dart';

abstract class BillDataSource {
  ExpenseModel createBill(ExpenseModel model);
  int tAmount();
  IncomeModel createIncome(IncomeModel model);
  int tIncome();
}

class BillStore implements BillDataSource {
  final List<ExpenseModel> _expenseModel = [];

  final List<IncomeModel> _incomeModel = [];

  List<ExpenseModel> get billModel => [..._expenseModel];

  List<IncomeModel> get incomeModel => [..._incomeModel];

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

  @override
  IncomeModel createIncome(IncomeModel model) {
    try {
      var newIncome = IncomeModel(
          amount: model.amount,
          createdDate: model.createdDate,
          id: model.id,
          title: model.title);
      _incomeModel.add(newIncome);
      print('hi${_incomeModel.first.title}');
      return newIncome;
    } catch (error) {
      throw ErrorException();
    }
  }

  @override
  int tIncome() {
    int totalIncome = 0;
    final amount =
        _incomeModel.map((income) => int.tryParse(income.amount)).toList();
    totalIncome =
        amount.fold(0, (previousValue, element) => previousValue + element!);

    print('hak$totalIncome');

    return totalIncome;
  }
}
