import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:calculator/widgets/scale.dart';

import '../utils/constants.dart';

class CalcApp extends StatefulWidget {
  const CalcApp({Key? key}) : super(key: key);

  @override
  State<CalcApp> createState() => _CalcAppState();
}

class _CalcAppState extends State<CalcApp> {
  Alignment dayAlign = Alignment.centerLeft;
  Alignment nightAlign = Alignment.centerRight;
  Alignment switchAlign = Alignment.centerLeft;

  Color bgClr = nightBgClr;
  Color numClr = numbersClr;
  Color numTxtClr = white;
  Color resultClr = white;
  Color actRowClr = nightactionsClmnClr;
  Color switchClr = switchBtnBgClr;
  Color switchColor = switchBtnClr;

  var lasttxt = TextEditingController();
  var resulttxt = TextEditingController();

  double? firstNum, secondNum, result;
  String? lastOperand;

  List nums = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];
  List operands = ['÷', 'x', '-', '+'];

  changeTheme() {
    setState(() {
      if (switchAlign == dayAlign) {
        switchAlign = nightAlign;
        bgClr = lightBgClr;
        numClr = white;
        numTxtClr = black;
        resultClr = black;
        actRowClr = actionsLightRowClr;
        switchClr = white;
        switchColor = actionsLightRowClr;
      } else {
        switchAlign = dayAlign;
        bgClr = nightBgClr;
        numClr = numbersClr;
        numTxtClr = white;
        resultClr = white;
        actRowClr = nightactionsClmnClr;
        switchClr = switchBtnBgClr;
        switchColor = switchBtnClr;
      }
    });
  }

  status(String text) {
    if (text == "C") {
      resulttxt.text = "";
      lasttxt.text = "";
    }

    if (text == "DEL") {
      resulttxt.text = resulttxt.text.substring(0, resulttxt.text.length - 1);
    }

    if (text == "+/-") {
      resulttxt.text = (double.parse(resulttxt.text) * (-1)).toString();
    }

    if (text == "%") {
      resulttxt.text = (double.parse(resulttxt.text) / (100)).toString();
    }

    if (text == ".") {
      resulttxt.text += ".";
    }

    if (nums.contains(text)) {
      resulttxt.text += text;
    }

    if (operands.contains(text)) {
      lastOperand = text;
      firstNum = double.parse(resulttxt.text);
      lasttxt.text = resulttxt.text + text;
      resulttxt.text = "";
    }

    if (text == "=") {
      secondNum = double.parse(resulttxt.text);
      lasttxt.text = lasttxt.text + resulttxt.text;

      if (lastOperand == "+") {
        resulttxt.text = (firstNum! + secondNum!).toString();
      } else if (lastOperand == "-") {
        resulttxt.text = (firstNum! - secondNum!).toString();
      } else if (lastOperand == "x") {
        resulttxt.text = (firstNum! * secondNum!).toString();
      } else if (lastOperand == "÷") {
        resulttxt.text = (firstNum! / secondNum!).toString();
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: bgClr,
      statusBarBrightness:
          switchAlign == dayAlign ? Brightness.dark : Brightness.light,
    ));
    return Scaffold(
      backgroundColor: bgClr,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                width: size.width * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: switchClr,
                ),
                child: Stack(
                  children: [
                    AnimatedContainer(
                      alignment: dayAlign,
                      duration: const Duration(seconds: 1),
                      child: Icon(
                        Icons.sunny,
                        color: actionsClmnnClr,
                        size: size.height * 0.04,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: nightAlign,
                      duration: const Duration(seconds: 1),
                      child: Icon(
                        Icons.mode_night_outlined,
                        color: actionsClmnnClr,
                        size: size.height * 0.04,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: switchAlign,
                      duration: const Duration(milliseconds: 500),
                      child: InkWell(
                        onTap: () {
                          changeTheme();
                        },
                        child: Container(
                          width: size.height * 0.04,
                          height: size.height * 0.04,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: switchColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.06),
                child: TextFormField(
                  controller: lasttxt,
                  textAlign: TextAlign.right,
                  readOnly: true,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: lastAction,
                    fontSize: size.height * 0.04,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: TextFormField(
                  controller: resulttxt,
                  textAlign: TextAlign.right,
                  readOnly: true,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: resultClr,
                    fontSize: size.height * 0.08,
                  ),
                ),
              ),
              GridView.count(
                padding: const EdgeInsets.symmetric(vertical: 15),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: size.height * 0.0011,
                crossAxisCount: 4,
                primary: false,
                children: [
                  button(actRowClr, "C", numTxtClr),
                  button(actRowClr, "+/-", numTxtClr),
                  button(actRowClr, "%", numTxtClr),
                  button(actionsClmnnClr, "÷", white),
                  button(numClr, "7", numTxtClr),
                  button(numClr, "8", numTxtClr),
                  button(numClr, "9", numTxtClr),
                  button(actionsClmnnClr, "x", white),
                  button(numClr, "4", numTxtClr),
                  button(numClr, "5", numTxtClr),
                  button(numClr, "6", numTxtClr),
                  button(actionsClmnnClr, "-", white),
                  button(numClr, "1", numTxtClr),
                  button(numClr, "2", numTxtClr),
                  button(numClr, "3", numTxtClr),
                  button(actionsClmnnClr, "+", white),
                  button(numClr, ".", numTxtClr),
                  button(numClr, "0", numTxtClr),
                  button(numClr, "DEL", numTxtClr),
                  button(actionsClmnnClr, "=", white),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget button(Color bgclr, String text, Color numTxtClr) {
    return scaleWidget(
      onTap: () {
        status(text);
      },
      scale: 0.7,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgclr,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: numTxtClr,
          ),
        ),
      ),
    );
  }
}
