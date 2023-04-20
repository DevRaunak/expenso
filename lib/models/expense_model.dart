import 'package:expenso_31/database/db_helper.dart';

class ExpenseModel {
  int? eid;
  String? title;
  String? desc;
  double? amt;
  double? bal;
  int? cat_id;
  int? type;
  String? time;

  ExpenseModel(
      {this.eid,
      this.title,
      this.desc,
      this.amt,
      this.bal,
      this.cat_id,
      this.type,
      this.time});

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
        eid: map[DBHelper.EXPENSE_COLUMN_ID],
        title: map[DBHelper.EXPENSE_COLUMN_TITLE],
        desc: map[DBHelper.EXPENSE_COLUMN_DESC],
        amt: map[DBHelper.EXPENSE_COLUMN_AMT],
        bal: map[DBHelper.EXPENSE_COLUMN_BAL],
        cat_id: map[DBHelper.EXPENSE_COLUMN_CAT_ID],
        type: map[DBHelper.EXPENSE_COLUMN_TYPE],
        time: map[DBHelper.EXPENSE_COLUMN_TIME]);
  }

  Map<String, dynamic> toMap() => {
        DBHelper.EXPENSE_COLUMN_TITLE: title,
        DBHelper.EXPENSE_COLUMN_DESC: desc,
        DBHelper.EXPENSE_COLUMN_AMT: amt,
        DBHelper.EXPENSE_COLUMN_CAT_ID: cat_id,
        DBHelper.EXPENSE_COLUMN_TYPE: type,
        DBHelper.EXPENSE_COLUMN_TIME: time,
        DBHelper.EXPENSE_COLUMN_BAL: bal
      };
}
