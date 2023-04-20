import 'package:expenso_31/custom_widgets/custom_logo_widget.dart';
import 'package:expenso_31/custom_widgets/custom_rounded_btn.dart';
import 'package:expenso_31/custom_widgets/custom_text_field.dart';
import 'package:expenso_31/screens/home/home_page.dart';
import 'package:expenso_31/ui_helper.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passController = TextEditingController();

  var isLight;

  var height;

  var width;

  @override
  Widget build(BuildContext context) {
    isLight = Theme.of(context).brightness == Brightness.light;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    print(width);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: MediaQuery.of(context).orientation == Orientation.portrait
          ? portraitUI()
          : landscapeUI(),
    );
  }

  Widget mainUI() {
    return LayoutBuilder(
      builder: (context, constraints) {
        print(constraints.maxWidth);
        print(constraints.maxHeight);
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(21.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomLogoWidget(
                  mSize: constraints.maxWidth > 620 ? 50 : 34,
                  bgColor: Theme.of(context).canvasColor,
                  iconColor: Theme.of(context).backgroundColor,
                ),
                SizedBox(
                  height: 21,
                ),
                Text(
                  'Hello Again',
                  style: constraints.maxWidth > 620
                      ? mTextStyle52(
                          fontWeight: FontWeight.w900,
                          mColor:
                              isLight ? MyColor.textBColor : MyColor.textWColor)
                      : mTextStyle34(
                          fontWeight: FontWeight.w900,
                          mColor: isLight
                              ? MyColor.textBColor
                              : MyColor.textWColor),
                ),
                SizedBox(
                  height: 11,
                ),
                Text(
                  'Welcome Back, you\'ve been missed',
                  style: constraints.maxWidth > 620
                      ? mTextStyle25(
                          mColor: isLight
                              ? MyColor.secondaryBColor
                              : MyColor.secondaryWColor)
                      : mTextStyle16(
                          mColor: isLight
                              ? MyColor.secondaryBColor
                              : MyColor.secondaryWColor),
                ),

                /////////////////////////////////Input Fields///////////////////
                SizedBox(
                  height: 21,
                ),

                CustomTextField(
                    mIcon: Icons.email_outlined,
                    fillColor: isLight
                        ? MyColor.secondaryWColor
                        : MyColor.secondaryBColor,
                    controller: emailController,
                    borderColor: isLight ? MyColor.bgBColor : MyColor.bgWColor),
                SizedBox(
                  height: 11,
                ),
                CustomTextField(
                    mIcon: Icons.lock_outline,
                    fillColor: isLight
                        ? MyColor.secondaryWColor
                        : MyColor.secondaryBColor,
                    controller: passController,
                    borderColor: isLight ? MyColor.bgBColor : MyColor.bgWColor),

                ///////////////////////////Footer///////////////////////

                SizedBox(
                  height: 21,
                ),
                CustomRoundedBtn(
                  title: 'Login',
                  action: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ));
                  },
                  mWidth: double.infinity,
                  mColor: isLight ? MyColor.bgBColor : MyColor.bgWColor,
                  textColor: isLight ? MyColor.bgWColor : MyColor.bgBColor,
                ),

                SizedBox(
                  height: 11,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Create a new Account?',
                      style: constraints.maxWidth > 620
                          ? mTextStyle16(
                              mColor: isLight
                                  ? MyColor.secondaryBColor
                                  : MyColor.secondaryWColor)
                          : mTextStyle12(
                              mColor: isLight
                                  ? MyColor.secondaryBColor
                                  : MyColor.secondaryWColor),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text('Sign-up now ',
                            style: constraints.maxWidth > 620
                                ? mTextStyle16(
                                    fontWeight: FontWeight.w900,
                                    mColor: isLight
                                        ? MyColor.bgBColor
                                        : MyColor.bgWColor)
                                : mTextStyle12(
                                    fontWeight: FontWeight.w900,
                                    mColor: isLight
                                        ? MyColor.bgBColor
                                        : MyColor.bgWColor)))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget landscapeUI() {
    return Row(
      children: [
        Expanded(
            child: Container(
          color: isLight ? MyColor.secondaryBColor : MyColor.secondaryWColor,
          child: Center(
            child: CustomLogoWidget(
              mSize: 70,
              bgColor: Theme.of(context).backgroundColor,
              iconColor: Theme.of(context).canvasColor,
            ),
          ),
        )),
        Expanded(
            child: height > 600
                ? mainUI()
                : SingleChildScrollView(
                    child: mainUI(),
                  ))
      ],
    );
  }

  Widget portraitUI() {
    return height > 600
        ? mainUI()
        : SingleChildScrollView(
            child: mainUI(),
          );
  }
}
