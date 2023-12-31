import 'package:bloc/bloc.dart';
import 'package:coinpulse2/0_Data/models/income_model.dart';
import 'package:coinpulse2/1_Domain/usecases/bill_usecase.dart';
import 'package:coinpulse2/di/injection.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'income_event.dart';
part 'income_state.dart';

@injectable
class IncomeBloc extends Bloc<IncomeEvent, IncomeState> {
  IncomeBloc() : super(IncomeInitial()) {
    final billUseCases = getIt<BillUseCases>();
    on<CreateIncome>((event, emit) {
      emit(IncomeCreating());
      final createdIncome = billUseCases.createIncome(event.createIncome);
      createdIncome.fold(
          (failure) =>
              emit(const NewsError(error: 'An error occured. Try again later')),
          (income) => emit(IncomeCreated(incomeData: income)));
    });

    on<RetrieveIncome>((event, emit) async {
      emit(IncomeRetrieving(
          incomeRetrievedData: await billUseCases.fetchandSetIncomes()));
    });
    on<GetTotalIncomeAmount>((event, emit) {
      emit(TotalIncomeRetrieved(totalAmount: billUseCases.totalIncome()));
    });
    on<DeleteIncome>(
      (event, emit) async {
        emit(DeletingIncome(id: await billUseCases.deleteIncome(event.id)));
      },
    );
  }
}
