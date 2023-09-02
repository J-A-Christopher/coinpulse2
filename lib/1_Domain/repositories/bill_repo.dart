import 'package:coinpulse2/0_Data/models/bill_model.dart';
import 'package:coinpulse2/0_Data/models/income_model.dart';
import 'package:coinpulse2/1_Domain/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class BillRepo {
  Either<Failure, ExpenseModel> createBill(ExpenseModel model);
  //List<ExpenseModel> getBills();
  int totalAmount();
  Either<Failure, IncomeModel> createIncome(IncomeModel model);
  List<IncomeModel> getIncome();
  int totalIncome();
  Future<void> fetchandSetPExpenses();
  Future<void> deleteExpense(String expenseId);
}
