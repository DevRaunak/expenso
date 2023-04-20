import 'package:expenso_31/bloc/cat_bloc_components/expense_type_bloc.dart';
import 'package:expenso_31/bloc/expense_bloc_componets/expense_bloc.dart';
import 'package:expenso_31/constants.dart';
import 'package:expenso_31/models/category_model.dart';
import 'package:expenso_31/screens/add_expense/add_expense_page.dart';
import 'package:expenso_31/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../models/day_wise_expenses_model.dart';
import '../../../models/expense_model.dart';

class FragTransactionPage extends StatefulWidget {
  @override
  State<FragTransactionPage> createState() => _FragTransactionPageState();
}

class _FragTransactionPageState extends State<FragTransactionPage> {
  double? width;

  List<ExpenseModel> arrExpenses = [];

  List<CategoryModel> arrExpenseType = [];

  List<DayWiseExpensesModel> arrDayWiseExpense = [];

  @override
  void initState() {
    super.initState();

    BlocProvider.of<ExpenseBloc>(context).add(FetchAllExpensesEvent());

    BlocProvider.of<ExpenseTypeBloc>(context).add(FetchExpenseTypeEvent());
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(flex: 1, child: addTransactionUI(context, widget)),
            Expanded(
              flex: 19,
              child: BlocBuilder<ExpenseBloc, ExpenseState>(
                builder: (_, state) {
                  if (state is ExpenseLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ExpenseLoadedState) {
                    arrExpenses = state.arrExpense.reversed.toList();
                    return state.arrExpense.isNotEmpty
                        ? MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? portraitUI(context, widget)
                            : landscapeUI(context, widget)
                        : Center(
                            child: Text(
                              'No Expense Yet!',
                              style: mTextStyle25(),
                            ),
                          );
                  }
                  return Container();
                },
              ),
            )
          ],
        ));
  }

  Widget landscapeUI(BuildContext context, widget) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(flex: 1, child: addTransactionUI(context, widget)),
              Expanded(flex: 7, child: totalBalanceUI()),
            ],
          ),
        ),
        Expanded(child: BlocBuilder<ExpenseTypeBloc, ExpenseTypeState>(
          builder: (context, state) {
            if (state is ExpenseTypeLoadingState) {
              return CircularProgressIndicator();
            } else if (state is ExpenseTypeLoadedState) {
              arrExpenseType = state.arrExpenseType;
              return transactionListUI();
            }
            return Container();
          },
        ))
      ],
    );
  }

  Widget portraitUI(BuildContext context, widget) {
    return Column(
      children: [
        // Expanded(flex: 1, child: addTransactionUI(context, widget)),
        Expanded(flex: 7, child: totalBalanceUI()),
        BlocBuilder<ExpenseTypeBloc, ExpenseTypeState>(
          builder: (context, state) {
            if (state is ExpenseTypeLoadingState) {
              return CircularProgressIndicator();
            } else if (state is ExpenseTypeLoadedState) {
              arrExpenseType = state.arrExpenseType;
              return Expanded(flex: 12, child: transactionListUI());
            }
            return Container();
          },
        )
      ],
    );
  }

  Widget addTransactionUI(BuildContext context, widget) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, top: 8.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddExpensePage(
                      balanceTillNow: arrExpenses.isEmpty
                          ? 0.0
                          : arrExpenses[arrExpenses.length - 1].bal),
                ));
          },
          child: CircleAvatar(
            radius: 14,
            backgroundColor: Colors.black,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget totalBalanceUI() {

    var totalBalance = arrExpenses[0].bal!.toDouble().toString();


    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Spent Till Now',
            style: mTextStyle16(mColor: Colors.grey),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('\$', style: mTextStyle25(mColor: Colors.grey)),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: '${totalBalance.split(".")[0]}',
                    style: mTextStyle52(
                        mColor: Colors.black, fontWeight: FontWeight.w700)),
                WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child:
                        Text('.${totalBalance.split(".")[1].length==1 ? '${totalBalance.split(".")[1]}0' : totalBalance.split(".")[1]}', style: mTextStyle25(mColor: Colors.black))),
              ]))
            ],
          )
        ],
      ),
    );
  }

  Widget transactionListUI() {
    List<String> arrUniqueDates = [];

    for (ExpenseModel expense in arrExpenses) {
      var eachTime = DateTime.parse(expense.time!);

      var month = eachTime.month.toString().length == 1
          ? '0${eachTime.month}'
          : eachTime.month;
      var eachDate = '${eachTime.year}-$month-${eachTime.day}';

      if (!arrUniqueDates.contains(eachDate)) {
        arrUniqueDates.add(eachDate);
      }
    }
    print(arrUniqueDates);

    updateDayWiseTransactions(arrUniqueDates);

    return ListView.builder(
      itemBuilder: (context, index) {
        return mainListItem(index, width!, arrDayWiseExpense[index].toMap());
      },
      itemCount: arrDayWiseExpense.length,
      shrinkWrap: true,
    );
  }

  void updateDayWiseTransactions(List<String> arrUniqueDates) {
    arrDayWiseExpense.clear();

    /*var month = DateTime.now().month.toString().length == 1
        ? '0${DateTime.now().month}'
        : DateTime.now().month;
    var currentDate = '${DateTime.now().year}-$month-${DateTime.now().day}';*/

    for (String eachDate in arrUniqueDates) {
      List<ExpenseModel> eachDayExpenses = [];
      for (ExpenseModel expense in arrExpenses) {
        print(expense.time.toString());
        print(eachDate);
        if (expense.time!.contains(eachDate)) {
          print(expense.time!.toString());
          eachDayExpenses.add(expense);
        }
      }

      var dayWiseBalance = 0.0;

      for (ExpenseModel expense in eachDayExpenses) {
        if (expense.type == 1) {
          dayWiseBalance -= expense.amt!;
        } else {
          dayWiseBalance += expense.amt!;
        }
      }

      //List<ExpenseModel> arrOtherExpense = [];
      //arrOtherExpense.addAll(arrExpenses);
      //arrOtherExpense.removeWhere((expense) => expense.time!.contains(currentDate));

      var month = DateTime.now().month.toString().length == 1
          ? '0${DateTime.now().month}'
          : DateTime.now().month;
      var currentDate = '${DateTime.now().year}-$month-${DateTime.now().day}';
      var yesterdayDate =
          '${DateTime.now().year}-$month-${DateTime.now().day - 1}';

      if (eachDate == currentDate) {
        eachDate = 'Today';
      } else if (eachDate == yesterdayDate) {
        eachDate = 'Yesterday';
      }

      var todayExpense = DayWiseExpensesModel(
          date: eachDate,
          bal: dayWiseBalance.toString(),
          arrExpenses: eachDayExpenses);
      /* var otherDateExpenses = DayWiseExpensesModel(
        date: 'Other', bal: '0.0', arrExpenses: arrOtherExpense);*/

      arrDayWiseExpense.add(todayExpense);
      //arrDayWiseExpense.add(otherDateExpenses);
    }
  }
  void updateMonthWiseTransactions(List<String> arrUniqueMonths) {
    //To be done by You!!

    }
  }

  Widget mainListItem(int index, double width, Map dayWiseTransaction) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 11.0, right: 11.0, bottom: 21.0, top: 11.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: width * 0.15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dayWiseTransaction['date'],
                  style: mTextStyle12(mColor: Colors.grey),
                ),
                Text(
                  '\$ ${dayWiseTransaction['bal']}',
                  style: mTextStyle12(mColor: Colors.grey),
                )
              ],
            ),
          ),
          ListView.builder(
            itemBuilder: (context, childIndex) {
              return mainChildTransactionItem(
                  (dayWiseTransaction['arrExpenses'][childIndex]
                          as ExpenseModel)
                      .toMap(),
                  context);
            },
            itemCount: dayWiseTransaction['arrExpenses'].length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
          )
          /**/
        ],
      ),
    );
  }

  Widget mainChildTransactionItem(Map detailTransaction, BuildContext context) {
    var imgPath;

    for (CategoryModel type in arrExpenseType) {
      if (type.cat_id == detailTransaction['cat_id']) {
        imgPath = type.img_path;
        break;
      }
    }

    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: Image.asset(imgPath ?? "",
          width: MediaQuery.of(context).size.width * 0.08,
          height: MediaQuery.of(context).size.width * 0.08),
      title: Text(
        detailTransaction['title'],
        style: mTextStyle16(mColor: Colors.black, fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        detailTransaction['desc'],
        style: mTextStyle16(mColor: Colors.black),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '\$ ${detailTransaction['amt']}',
            style:
                mTextStyle16(mColor: Colors.black, fontWeight: FontWeight.w700),
          ),
          Text(
            '\$ ${detailTransaction['balance']}',
            style: mTextStyle12(mColor: Colors.black),
          )
        ],
      ),
    );
  }
}
