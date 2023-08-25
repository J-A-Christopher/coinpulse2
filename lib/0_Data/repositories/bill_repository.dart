import 'package:coinpulse2/0_Data/datasources/bill_store.dart';
import 'package:coinpulse2/0_Data/exception/general_exception.dart';
import 'package:coinpulse2/0_Data/models/bill_model.dart';
import 'package:coinpulse2/1_Domain/failures/failures.dart';
import 'package:coinpulse2/1_Domain/repositories/bill_repo.dart';
import 'package:dartz/dartz.dart';

class BillRepoImpl implements BillRepo {
  final billStrore = BillStore();
  @override
  Either<Failure, BillModel> createBill(BillModel model) {
    try {
      final result = billStrore.createBill(model);
      return right(result);
    } on ErrorException catch (_) {
      return left(GeneralFailure());
    }
  }

  @override
  List<BillModel> getBills() {
    return billStrore.billModel;
  }
}
