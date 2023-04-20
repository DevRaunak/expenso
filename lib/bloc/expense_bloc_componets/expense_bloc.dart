import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:expenso_31/database/db_helper.dart';
import 'package:meta/meta.dart';

import '../../models/expense_model.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc() : super(ExpenseInitialState()) {
    on<AddExpenseEvent>((event, emit) async{
      emit(ExpenseLoadingState());
      var check = await DBHelper().addExpense(event.model);

      if(check>0){
        var arrExpense = await DBHelper().fetchData();
        emit(ExpenseLoadedState(arrExpense));
      } else {
        emit(ExpenseErrorState("Expense Not Added!!"));
      }

    });

    on<FetchAllExpensesEvent>((event, emit) async{
      emit(ExpenseLoadingState());
      var arrExpense = await DBHelper().fetchData();
      emit(ExpenseLoadedState(arrExpense));
    });
  }
}
