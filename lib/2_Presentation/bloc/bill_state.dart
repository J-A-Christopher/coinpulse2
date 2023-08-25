part of 'bill_bloc.dart';

@immutable
abstract class BillState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BillInitial extends BillState {}

class BillCreating extends BillState {}

class BillCreated extends BillState {
  final ExpenseModel billData;

  BillCreated({required this.billData});
  @override
  List<Object?> get props => [billData];
}

class BillRetrieving extends BillState {
  final List<ExpenseModel> billRetrievedData;

  BillRetrieving({required this.billRetrievedData});
  @override
  List<Object?> get props => [billRetrievedData];
}

class TotalAmountRetrieved extends BillState {
  final int totalAmount;
  TotalAmountRetrieved({required this.totalAmount});
}

class NewsError extends BillState {
  final String error;
  NewsError({required this.error});
  @override
  List<Object?> get props => [error];
}
