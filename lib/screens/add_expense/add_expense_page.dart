import 'package:expenso_31/bloc/cat_bloc_components/expense_type_bloc.dart';
import 'package:expenso_31/bloc/expense_bloc_componets/expense_bloc.dart';
import 'package:expenso_31/constants.dart';
import 'package:expenso_31/models/category_model.dart';
import 'package:expenso_31/models/expense_model.dart';
import 'package:expenso_31/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../custom_widgets/custom_rounded_btn.dart';

class AddExpensePage extends StatefulWidget {
  var balanceTillNow;
  AddExpensePage({required this.balanceTillNow});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  var amtController = TextEditingController();
  var titleController = TextEditingController();
  var descController = TextEditingController();

  var _selectedIndex = -1;

  var _selectedDate = DateTime.now();

  List<CategoryModel> arrExpenseType = [];

  String defaultDropDownValue = 'Debit';

  List<String> arrTransactionType = ['Debit', 'Credit'];

  bool isAddingExpense = false;

  @override
  void initState() {
    super.initState();
    print(widget.balanceTillNow);

    BlocProvider.of<ExpenseTypeBloc>(context).add(FetchExpenseTypeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: Stack(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: mTextStyle16(mColor: Colors.black),
                      )),
                  Center(
                      child: Text(
                    'Expense',
                    style: mTextStyle16(mColor: Colors.black),
                  ))
                ],
              ),
            ),
            Expanded(
                child: Container(
              child: Column(
                children: [
                  SizedBox(
                    width: 200,
                    child: TextField(
                      style: mTextStyle52(mColor: MyColor.textBColor),
                      controller: amtController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.currency_rupee_outlined,
                            size: 25,
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1))),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextField(
                    style: mTextStyle16(mColor: MyColor.textBColor),
                    controller: titleController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'Add Title',
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1))),
                  ),
                  SizedBox(
                    height: 21,
                  ),
                  TextField(
                    style: mTextStyle16(mColor: MyColor.textBColor),
                    controller: descController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'Add Desc',
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1))),
                  ),
                  SizedBox(
                    height: 21,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: BlocBuilder<ExpenseTypeBloc, ExpenseTypeState>(
                        builder: (context, state) {
                          if (state is ExpenseTypeLoadingState) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is ExpenseTypeLoadedState) {
                            arrExpenseType = state.arrExpenseType;
                            return OutlinedButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(21),
                                              topRight: Radius.circular(21))),
                                      builder: (context) {
                                        return Container(
                                          padding: EdgeInsets.all(21),
                                          child: GridView.builder(
                                              shrinkWrap: true,
                                              gridDelegate:
                                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                                      maxCrossAxisExtent: 50,
                                                      mainAxisSpacing: 11,
                                                      crossAxisSpacing: 11),
                                              itemCount:
                                                  state.arrExpenseType.length,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    _selectedIndex = index;
                                                    setState(() {});
                                                  },
                                                  child: _selectedIndex == index
                                                      ? Container(
                                                          padding:
                                                              EdgeInsets.all(4),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          11),
                                                              border:
                                                                  Border.all(
                                                                      width:
                                                                          1)),
                                                          child: Image.asset(state
                                                              .arrExpenseType[
                                                                  index]
                                                              .img_path),
                                                        )
                                                      : Image.asset(state
                                                          .arrExpenseType[index]
                                                          .img_path),
                                                );
                                              }),
                                        );
                                      });
                                },
                                child: _selectedIndex == -1
                                    ? Text(
                                        'Select Expense Type',
                                        style:
                                            mTextStyle16(mColor: Colors.grey),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('Selected - '),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(state
                                                .arrExpenseType[_selectedIndex]
                                                .img_path),
                                          )
                                        ],
                                      ));
                          }
                          return Container();
                        },
                      )),
                  SizedBox(
                    height: 21,
                  ),
                  InkWell(
                    onTap: () async {
                      var dateTime = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );

                      _selectedDate = dateTime ?? DateTime.now();
                      setState(() {});
                    },
                    child: Text(
                      _selectedDate.toString(),
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                  ),
                  SizedBox(
                    height: 21,
                  ),
                  DropdownButton(
                      icon: Icon(
                        Icons.arrow_drop_down_circle_outlined,
                        color: Colors.black,
                      ),
                      value: defaultDropDownValue,
                      items: arrTransactionType
                          .map((transactionType) => DropdownMenuItem(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    transactionType,
                                    style: mTextStyle16(mColor: Colors.black),
                                  ),
                                ),
                                value: transactionType,
                              ))
                          .toList(),
                      onChanged: (dynamic selectedValue) {
                        defaultDropDownValue = selectedValue;
                        setState(() {});
                      }),
                  SizedBox(
                    height: 21,
                  ),
                  BlocListener<ExpenseBloc, ExpenseState>(
                    listener: (context, state) {
                      if(state is ExpenseLoadingState){
                        print('ExpenseLoadingState');
                        isAddingExpense = true;
                        setState((){});
                      } else if(state is ExpenseLoadedState){
                        print('ExpenseLoadedState');
                        isAddingExpense = false;
                        setState((){});
                        Navigator.pop(context);
                      }
                    },
                    child: CustomRoundedBtn(
                      title: 'Add Expense',
                      textColor: Colors.white,
                      mColor: Colors.black,
                      isLoading: isAddingExpense,
                      mWidth: 300.0,
                      action: () {

                        var newBalance = 0.0;
                        if(defaultDropDownValue == 'Debit'){
                          newBalance =
                              widget.balanceTillNow
                                  - double.parse(amtController.text.toString());
                        } else {
                          newBalance =
                              widget.balanceTillNow
                                  + double.parse(amtController.text.toString());
                        }

                        BlocProvider.of<ExpenseBloc>(context)
                            .add(AddExpenseEvent(ExpenseModel(
                          title: titleController.text.toString(),
                          desc: descController.text.toString(),
                          amt: double.parse(amtController.text.toString()),
                          bal: newBalance,
                          cat_id: arrExpenseType[_selectedIndex].cat_id,
                          type: defaultDropDownValue == 'Debit' ? 1 : 2,
                          time: DateTime.now().toString(),
                        )));
                      },
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
