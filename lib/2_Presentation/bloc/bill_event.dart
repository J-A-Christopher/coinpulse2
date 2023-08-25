part of 'bill_bloc.dart';

@immutable
abstract class BillEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateBill extends BillEvent {
  final BillModel createdBill;
  CreateBill({required this.createdBill});
  @override
  List<Object?> get props => [createdBill];
}

class RetrieveBill extends BillEvent {}
