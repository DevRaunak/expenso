import 'package:expenso_31/models/category_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/expense_model.dart';

class DBHelper {
  static const String EXPENSE_TABLE = 'expense';
  static const String EXPENSE_COLUMN_ID = 'eid';
  static const String EXPENSE_COLUMN_TITLE = 'title';
  static const String EXPENSE_COLUMN_DESC = 'desc';
  static const String EXPENSE_COLUMN_AMT = 'amt';
  static const String EXPENSE_COLUMN_BAL = 'balance';
  static const String EXPENSE_COLUMN_CAT_ID = 'cat_id';
  static const String EXPENSE_COLUMN_TYPE = 'type';
  static const String EXPENSE_COLUMN_TIME = 'time';

  static const String CAT_TABLE = 'category';
  static const String CAT_COLUMN_ID = 'cat_id';
  static const String CAT_COLUMN_TITLE = 'title';
  static const String CAT_COLUMN_PATH = 'img_path';


  Future<Database> openDB() async {
    var directory = await getApplicationDocumentsDirectory();

    directory.create(recursive: true);

    var path = directory.path + "expense_db.db";

    return await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute(
          'create table $EXPENSE_TABLE ( '
              '$EXPENSE_COLUMN_ID integer primary key autoincrement, '
              '$EXPENSE_COLUMN_TITLE text, '
              '$EXPENSE_COLUMN_DESC text,'
              '$EXPENSE_COLUMN_AMT real,'
              '$EXPENSE_COLUMN_BAL real,'
              '$EXPENSE_COLUMN_CAT_ID integer,'
              '$EXPENSE_COLUMN_TYPE integer,'
              '$EXPENSE_COLUMN_TIME text)');

      db.execute(
          'create table $CAT_TABLE ( '
              '$CAT_COLUMN_ID integer primary key autoincrement, '
              '$CAT_COLUMN_TITLE text, '
              '$CAT_COLUMN_PATH text)');

      db.insert(CAT_TABLE, CategoryModel(title: "Fast-Food", img_path: "assets/images/expense_type/fast-food.png").toMap());
      db.insert(CAT_TABLE, {CAT_COLUMN_TITLE : "Movie", CAT_COLUMN_PATH:"assets/images/expense_type/popcorn.png"});
      db.insert(CAT_TABLE, {CAT_COLUMN_TITLE : "Snacks", CAT_COLUMN_PATH:"assets/images/expense_type/snack.png"});
      db.insert(CAT_TABLE, {CAT_COLUMN_TITLE : "Travel", CAT_COLUMN_PATH:"assets/images/expense_type/travel.png"});
      db.insert(CAT_TABLE, {CAT_COLUMN_TITLE : "Coffee", CAT_COLUMN_PATH:"assets/images/expense_type/coffee.png"});


    });
  }

  Future<int> addExpense(ExpenseModel expense) async{

    var myDB = await openDB();

    return myDB.insert(EXPENSE_TABLE, expense.toMap());

  }

  Future<List<ExpenseModel>> fetchData() async{

    var myDB = await openDB();

    List<Map<String, dynamic>> data;

    data = await myDB.query(EXPENSE_TABLE);

    List<ExpenseModel> arrExpense = [];

    for(Map<String, dynamic> expense in data){
      ExpenseModel model = ExpenseModel.fromMap(expense);
      arrExpense.add(model);
    }

    return arrExpense;
  }

  Future<List<CategoryModel>> fetchAllExpenseType()async{

    var myDB = await openDB();

    List<Map<String, dynamic>> dataExpenseType;

    dataExpenseType = await myDB.query(CAT_TABLE);

    List<CategoryModel> arrExpenseType = [];

    for(Map<String, dynamic> expenseType in dataExpenseType){
      CategoryModel model = CategoryModel.fromMap(expenseType);
      arrExpenseType.add(model);
    }

    return arrExpenseType;

  }


}
