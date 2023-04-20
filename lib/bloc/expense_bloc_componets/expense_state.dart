part of 'expense_bloc.dart';

@immutable
abstract class ExpenseState {}

class ExpenseInitialState extends ExpenseState {}

class ExpenseLoadingState extends ExpenseState {}

class ExpenseLoadedState extends ExpenseState {
  List<ExpenseModel> arrExpense;
  ExpenseLoadedState(this.arrExpense);
}

class ExpenseErrorState extends ExpenseState {
  String errMsg;
  ExpenseErrorState(this.errMsg);
}

