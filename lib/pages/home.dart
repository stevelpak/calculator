import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:calculator/widgets/scale.dart';
import 'package:eval_ex/expression.dart';

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

  String lTxt = "";
  String rTxt = "";

  double? lastSize, resultSize;

  List nums = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];
  List operands = ['÷', 'x', '-', '+'];

  bool isPressed = false;
  bool isEqualPressed = false;

  Brightness brightness = Brightness.light;

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
        brightness = Brightness.dark;
      } else {
        switchAlign = dayAlign;
        bgClr = nightBgClr;
        numClr = numbersClr;
        numTxtClr = white;
        resultClr = white;
        actRowClr = nightactionsClmnClr;
        switchClr = switchBtnBgClr;
        switchColor = switchBtnClr;
        brightness = Brightness.light;
      }
    });
  }

  calculate(String text) {
    rTxt = resulttxt.text;
    lTxt = lasttxt.text;

    if (text == "C") {
      rTxt = "";
      lTxt = "";
      isPressed = false;
    }

    if (text == "DEL") {
      rTxt = rTxt.substring(0, rTxt.length - 1);
      isPressed = false;
    }

    if (text == "+/-") {
      if (rTxt.contains(".")) {
        rTxt = (double.parse(rTxt) * (-1)).toString();
      } else {
        rTxt = (double.parse(rTxt) * (-1)).toInt().toString();
      }
      isPressed = false;
    }

    if (text == "%") {
      rTxt = (double.parse(rTxt) / (100)).toString();
      isPressed = false;
    }

    if (text == "." && !rTxt.contains(".")) {
      rTxt += ".";
      isPressed = false;
    }

    if (nums.contains(text)) {
      if (rTxt.length < 18) {
        rTxt += text;
        isPressed = false;
      }
    }

    if (operands.contains(text)) {
      if (isPressed) {
        if (text == 'x') {
          lTxt = lTxt.replaceRange(lTxt.length - 1, null, '*');
        } else if (text == '÷') {
          lTxt = lTxt.replaceRange(lTxt.length - 1, null, '/');
        } else {
          lTxt = lTxt.replaceRange(lTxt.length - 1, null, text);
        }
        rTxt = "";
        isPressed = true;
      }

      if (!isPressed && !isEqualPressed) {
        if (text == 'x') {
          lTxt += "$rTxt*";
        } else if (text == '÷') {
          lTxt += "$rTxt/";
        } else {
          lTxt += rTxt + text;
        }
        rTxt = "";
        isPressed = true;
      } else if (!isPressed && isEqualPressed) {
        if (text == 'x') {
          lTxt = "$rTxt*";
        } else if (text == '÷') {
          lTxt = "$rTxt/";
        } else {
          lTxt = rTxt + text;
        }
        rTxt = "";
        isPressed = true;
        isEqualPressed = false;
      }
    }

    if (text == "=") {
      lTxt = lTxt + rTxt;
      String natija = Expression(lTxt).eval().toString();

      if (natija.contains('.')) {
        rTxt = double.parse(natija).toStringAsFixed(3);
      } else {
        rTxt = natija;
      }

      isPressed = false;
      isEqualPressed = !isEqualPressed;
    }

    resulttxt.text = rTxt;
    lasttxt.text = lTxt;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (resulttxt.text.length > 9 || lasttxt.text.length > 16) {
      lastSize = size.height * 0.02;
      resultSize = size.height * 0.04;
    } else {
      lastSize = size.height * 0.04;
      resultSize = size.height * 0.08;
    }

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: bgClr,
      statusBarBrightness: brightness,
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
                      duration: const Duration(milliseconds: 300),
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
              const Spacer(),
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
                    fontSize: lastSize,
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
                    fontSize: resultSize,
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
        calculate(text);
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
