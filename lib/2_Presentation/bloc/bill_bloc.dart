import 'package:bloc/bloc.dart';
import 'package:coinpulse2/0_Data/models/bill_model.dart';
import 'package:coinpulse2/0_Data/datasources/bill_store.dart';
import 'package:coinpulse2/1_Domain/usecases/bill_usecase.dart';
import 'package:coinpulse2/di/injection.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'bill_event.dart';
part 'bill_state.dart';

@injectable
class BillBloc extends Bloc<BillEvent, BillState> {
  BillBloc() : super(BillInitial()) {
    final billUseCases = getIt<BillUseCases>();
    on<CreateBill>((event, emit) {
      emit(BillCreating());
      final createdBill = billUseCases.createBill(event.createdBill);
      createdBill.fold(
          (failure) =>
              emit(NewsError(error: 'An error occured. Try again later')),
          (bill) => emit(BillCreated(billData: bill)));
    });

    on<RetrieveBill>((event, emit) async {
      emit(BillRetrieving(
          billRetrievedData: await billUseCases.fetchandSetPExpenses()));
    });
    on<GetTotalAmount>((event, emit) {
      emit(TotalAmountRetrieved(totalAmount: billUseCases.totalAmount()));
    });

    on<DeleteBill>(((event, emit) async {
      emit(DeletingBill(id: await billUseCases.deleteExpense(event.id)));
    }));
  }
}
