part of 'income_bloc.dart';

sealed class IncomeEvent extends Equatable {
  const IncomeEvent();

  @override
  List<Object?> get props => [];
}

class CreateIncome extends IncomeEvent {
  final IncomeModel createIncome;
  const CreateIncome({required this.createIncome});
  @override
  List<Object?> get props => [createIncome];
}

class RetrieveIncome extends IncomeEvent {}

class GetTotalIncomeAmount extends IncomeEvent {}

class DeleteIncome extends IncomeEvent {
  final String id;
  const DeleteIncome({required this.id});
}
