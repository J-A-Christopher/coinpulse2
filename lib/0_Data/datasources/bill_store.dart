import 'package:coinpulse2/0_Data/exception/general_exception.dart';
import 'package:coinpulse2/0_Data/models/bill_model.dart';

abstract class BillDataSource {
  BillModel createBill(BillModel model);
}

class BillStore implements BillDataSource {
  final List<BillModel> _billModel = [];

  List<BillModel> get billModel => [..._billModel];

  @override
  BillModel createBill(BillModel model) {
    try {
      var newBill =
          BillModel(billAmount: model.billAmount, billName: model.billName);
      _billModel.add(newBill);
      print(_billModel.first.billName);
      return newBill;
    } catch (error) {
      throw ErrorException();
    }
  }
}
