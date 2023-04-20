part of 'expense_bloc.dart';

@immutable
abstract class ExpenseEvent {}

class AddExpenseEvent extends ExpenseEvent{
  ExpenseModel model;
  AddExpenseEvent(this.model);
}

class FetchAllExpensesEvent extends ExpenseEvent{}
