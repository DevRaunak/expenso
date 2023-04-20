import 'package:expenso_31/bloc/cat_bloc_components/expense_type_bloc.dart';
import 'package:expenso_31/bloc/expense_bloc_componets/expense_bloc.dart';
import 'package:expenso_31/screens/add_expense/add_expense_page.dart';
import 'package:expenso_31/screens/home/home_page.dart';
import 'package:expenso_31/screens/splash/splash_page.dart';
import 'package:expenso_31/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => ExpenseTypeBloc(),),
    BlocProvider(create: (context) => ExpenseBloc())

  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
          primarySwatch: createMaterialColor(MyColor.bgBColor),
          backgroundColor: MyColor.bgBColor,
          canvasColor: MyColor.bgWColor
      ),
      theme: ThemeData(
        brightness: Brightness.light,
       primarySwatch: createMaterialColor(MyColor.bgWColor),
        backgroundColor: MyColor.bgWColor,
        canvasColor: MyColor.bgBColor
      ),
      home: HomePage(),
    );
  }
}
