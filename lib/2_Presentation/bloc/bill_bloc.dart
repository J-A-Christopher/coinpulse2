import 'package:bloc/bloc.dart';
import 'package:coinpulse2/0_Data/models/bill_model.dart';
import 'package:coinpulse2/0_Data/datasources/bill_store.dart';
import 'package:coinpulse2/1_Domain/usecases/bill_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'bill_event.dart';
part 'bill_state.dart';

class BillBloc extends Bloc<BillEvent, BillState> {
  BillBloc() : super(BillInitial()) {
    final billUseCases = BillUseCases();
    on<CreateBill>((event, emit) {
      emit(BillCreating());
      final createdBill = billUseCases.createBill(event.createdBill);
      createdBill.fold(
          (failure) =>
              emit(NewsError(error: 'An error occured. Try again later')),
          (bill) => emit(BillCreated(billData: bill)));
    });

    on<RetrieveBill>((event, emit) {
      emit(BillRetrieving(billRetrievedData: billUseCases.getBills()));
    });
    on<GetTotalAmount>((event, emit) {
      emit(TotalAmountRetrieved(totalAmount: billUseCases.totalAmount()));
    });
  }
}
