import 'package:bloc/bloc.dart';
import 'package:coinpulse2/0_Data/models/bill_model.dart';
import 'package:coinpulse2/bill_store.dart';
import 'package:meta/meta.dart';

part 'bill_event.dart';
part 'bill_state.dart';

class BillBloc extends Bloc<BillEvent, BillState> {
  BillBloc() : super(BillInitial()) {
    final billStore = BillStore();
    on<CreateBill>((event, emit) {
      emit(BillCreating());
      final createdBill = billStore.createBill(event.createdBill);
      emit(BillCreated(billData: createdBill));
    });

    on<RetrieveBill>((event, emit) {
      emit(BillRetrieving(billRetrievedData: billStore.billModel));
    });
  }
}
