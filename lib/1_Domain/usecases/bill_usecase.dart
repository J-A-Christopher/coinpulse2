import 'package:coinpulse2/0_Data/models/bill_model.dart';
import 'package:coinpulse2/0_Data/repositories/bill_repository.dart';
import 'package:coinpulse2/1_Domain/failures/failures.dart';
import 'package:dartz/dartz.dart';

class BillUseCases {
  final billRepo = BillRepoImpl();
  Either<Failure, ExpenseModel> createBill(ExpenseModel model) {
    final result = billRepo.createBill(model);
    return result;
  }

  List<ExpenseModel> getBills() {
    return billRepo.getBills();
  }

  int totalAmount() {
    return billRepo.totalAmount();
  }
}
