import 'package:coinpulse2/0_Data/datasources/helpers/db_helper.dart';
import 'package:coinpulse2/0_Data/datasources/helpers/income_helper.dart';
import 'package:coinpulse2/0_Data/exception/general_exception.dart';
import 'package:coinpulse2/0_Data/models/bill_model.dart';
import 'package:coinpulse2/0_Data/models/income_model.dart';

abstract class BillDataSource {
  ExpenseModel createBill(ExpenseModel model);
  int tAmount();
  IncomeModel createIncome(IncomeModel model);
  int tIncome();
  Future<void> fetchandSetPExpenses();
  Future<void> fetchandSetIncomes();
}

class BillStore implements BillDataSource {
  List<ExpenseModel> _expenseModel = [];

  List<IncomeModel> _incomeModel = [];

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
      DBHelper.insert('expenses', {
        'id': newBill.id,
        'title': newBill.title,
        'amount': newBill.amount,
        'time': newBill.createdDate.toIso8601String()
      });

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
      IncomeDBHelper.insert('incomes', {
        'id': newIncome.id,
        'title': newIncome.title,
        'amount': newIncome.amount,
        'time': newIncome.createdDate.toIso8601String()
      });
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

  @override
  Future<List<ExpenseModel>> fetchandSetPExpenses() async {
    try {
      final dataList = await DBHelper.getData('expenses');
      print('Number of records fetched: ${dataList.length}');

      _expenseModel = dataList
          .map((expense) => ExpenseModel(
                amount: expense['amount'],
                createdDate: DateTime.parse(expense['time']),
                title: expense['title'],
                id: expense['id'], // Removed the extra space here
              ))
          .toList();
      print('Number of records after mapping: ${_expenseModel.length}');
      return _expenseModel;
    } catch (error) {
      print('Error fetching expenses: $error');
      rethrow;
    }
  }

  Future<void> deleteExpense(String pracId) async {
    await DBHelper.deleteExpense(pracId);
    fetchandSetPExpenses();
  }

  @override
  Future<List<IncomeModel>> fetchandSetIncomes() async {
    try {
      final dataList = await IncomeDBHelper.getData('incomes');
      print('Number of records fetched: ${dataList.length}');

      _incomeModel = dataList
          .map((expense) => IncomeModel(
                amount: expense['amount'],
                createdDate: DateTime.parse(expense['time']),
                title: expense['title'],
                id: expense['id'], // Removed the extra space here
              ))
          .toList();
      print('Number of records after mapping: ${_incomeModel.length}');
      return _incomeModel;
    } catch (error) {
      print('Error fetching expenses: $error');
      rethrow;
    }
  }

  Future<String> deleteIncome(String incomeId) async {
    await IncomeDBHelper.deleteExpense(incomeId);
    fetchandSetIncomes();
    return 'true';
  }
}
