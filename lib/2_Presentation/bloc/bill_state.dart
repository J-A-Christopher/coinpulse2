part of 'bill_bloc.dart';

@immutable
abstract class BillState {}

class BillInitial extends BillState {}

class BillCreating extends BillState {}

class BillCreated extends BillState {
  final BillModel billData;

  BillCreated({required this.billData});
}

class BillRetrieving extends BillState {
  final List<BillModel> billRetrievedData;

  BillRetrieving({required this.billRetrievedData});
}
