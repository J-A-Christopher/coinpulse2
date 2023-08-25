part of 'bill_bloc.dart';

@immutable
abstract class BillEvent {}

class CreateBill extends BillEvent {
  final BillModel createdBill;
  CreateBill({required this.createdBill});
}

class RetrieveBill extends BillEvent {}
