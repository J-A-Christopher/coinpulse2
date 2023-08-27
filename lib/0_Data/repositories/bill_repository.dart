import 'package:coinpulse2/0_Data/datasources/bill_store.dart';
import 'package:coinpulse2/0_Data/exception/general_exception.dart';
import 'package:coinpulse2/0_Data/models/bill_model.dart';
import 'package:coinpulse2/0_Data/models/income_model.dart';
import 'package:coinpulse2/1_Domain/failures/failures.dart';
import 'package:coinpulse2/1_Domain/repositories/bill_repo.dart';
import 'package:dartz/dartz.dart';

class BillRepoImpl implements BillRepo {
  final billStrore = BillStore();
  @override
  Either<Failure, ExpenseModel> createBill(ExpenseModel model) {
    try {
      final result = billStrore.createBill(model);
      return right(result);
    } on ErrorException catch (_) {
      return left(GeneralFailure());
    }
  }

  @override
  List<ExpenseModel> getBills() {
    return billStrore.billModel;
  }

  @override
  int totalAmount() {
    return billStrore.tAmount();
  }

  @override
  Either<Failure, IncomeModel> createIncome(IncomeModel model) {
    try {
      final result = billStrore.createIncome(model);
      return right(result);
    } on ErrorException catch (_) {
      return left(GeneralFailure());
    }
  }

  @override
  List<IncomeModel> getIncome() {
    return billStrore.incomeModel;
  }

  @override
  int totalIncome() {
    return billStrore.tIncome();
  }
}
