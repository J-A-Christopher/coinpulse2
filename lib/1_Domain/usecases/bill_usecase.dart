import 'package:coinpulse2/0_Data/models/bill_model.dart';
import 'package:coinpulse2/0_Data/models/income_model.dart';
import 'package:coinpulse2/0_Data/repositories/bill_repository.dart';
import 'package:coinpulse2/1_Domain/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class BillUseCases {
  final billRepo = BillRepoImpl();
  Either<Failure, ExpenseModel> createBill(ExpenseModel model) {
    final result = billRepo.createBill(model);
    return result;
  }

  // Future<void> getBills() async{
  //   return await billRepo.getBills();
  // }

  int totalAmount() {
    return billRepo.totalAmount();
  }

  Either<Failure, IncomeModel> createIncome(IncomeModel model) {
    final result = billRepo.createIncome(model);
    return result;
  }

  List<IncomeModel> getIncome() {
    return billRepo.getIncome();
  }

  int totalIncome() {
    return billRepo.totalIncome();
  }

  Future<List<ExpenseModel>> fetchandSetPExpenses() async {
    return await billRepo.fetchandSetPExpenses();
  }

  Future deleteExpense(String expenseId) async {
    return await billRepo.deleteExpense(expenseId);
  }

  Future<List<IncomeModel>> fetchandSetIncomes() async {
    return await billRepo.fetchandSetIncomes();
  }

  Future<String> deleteIncome(String incomeId) async {
    return await billRepo.deleteIncome(incomeId);
  }
}
