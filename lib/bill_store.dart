import 'package:coinpulse2/0_Data/models/bill_model.dart';

class BillStore {
  final List<BillModel> _billModel = [];

  List<BillModel> get billModel => [..._billModel];

  BillModel createBill(BillModel model) {
    var newBill =
        BillModel(billAmount: model.billAmount, billName: model.billName);
    _billModel.add(newBill);
    print(_billModel.first.billName);
    return newBill;
  }
}
