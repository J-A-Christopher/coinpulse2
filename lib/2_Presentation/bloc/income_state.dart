part of 'income_bloc.dart';

abstract class IncomeState extends Equatable {
  const IncomeState();

  @override
  List<Object?> get props => [];
}

class IncomeInitial extends IncomeState {}

class IncomeCreating extends IncomeState {}

class IncomeCreated extends IncomeState {
  final IncomeModel incomeData;

  const IncomeCreated({required this.incomeData});
  @override
  List<Object?> get props => [incomeData];
}

class IncomeRetrieving extends IncomeState {
  final List<IncomeModel> incomeRetrievedData;

  const IncomeRetrieving({required this.incomeRetrievedData});
  @override
  List<Object?> get props => [incomeRetrievedData];
}

class TotalIncomeRetrieved extends IncomeState {
  final int totalAmount;
  const TotalIncomeRetrieved({required this.totalAmount});
}

class NewsError extends IncomeState {
  final String error;
  const NewsError({required this.error});
  @override
  List<Object?> get props => [error];
}
