class ExpenseModel {
  String id;
  String title;
  String amount;
  DateTime createdDate;
  ExpenseModel(
      {required this.amount,
      required this.createdDate,
      required this.title,
      required this.id});
}
