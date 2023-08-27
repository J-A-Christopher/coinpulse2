import 'package:bloc/bloc.dart';
import 'package:coinpulse2/0_Data/models/income_model.dart';
import 'package:coinpulse2/1_Domain/usecases/bill_usecase.dart';
import 'package:equatable/equatable.dart';

part 'income_event.dart';
part 'income_state.dart';

class IncomeBloc extends Bloc<IncomeEvent, IncomeState> {
  IncomeBloc() : super(IncomeInitial()) {
    final billUseCases = BillUseCases();
    on<CreateIncome>((event, emit) {
      emit(IncomeCreating());
      final createdIncome = billUseCases.createIncome(event.createIncome);
      createdIncome.fold(
          (failure) =>
              emit(const NewsError(error: 'An error occured. Try again later')),
          (income) => emit(IncomeCreated(incomeData: income)));
    });

    on<RetrieveIncome>((event, emit) {
      emit(IncomeRetrieving(incomeRetrievedData: billUseCases.getIncome()));
    });
    on<GetTotalIncomeAmount>((event, emit) {
      emit(TotalIncomeRetrieved(totalAmount: billUseCases.totalIncome()));
    });
  }
}
