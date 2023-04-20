import 'expense_model.dart';

class DayWiseExpensesModel {
  String date;
  String bal;
  List<ExpenseModel> arrExpenses;

  DayWiseExpensesModel({required this.date, required this.bal, required this.arrExpenses});

  factory DayWiseExpensesModel.fromMap(Map<String, dynamic> map) {
    return DayWiseExpensesModel(
        date: map['date'],
        bal: map['bal'],
        arrExpenses: map['arrExpenses']);
  }

  Map<String, dynamic> toMap() => {
    'date': date,
    'bal': bal,
    'arrExpenses': arrExpenses,
  };
}