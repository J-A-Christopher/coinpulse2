import 'package:coinpulse2/0_Data/models/bill_model.dart';
import 'package:coinpulse2/1_Domain/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class BillRepo {
  Either<Failure, BillModel> createBill(BillModel model);
  List<BillModel> getBills();
}
