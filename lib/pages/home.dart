import 'package:flutter/material.dart';

import 'package:calculator/utils/constants.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgClr,
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                width: 120,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: switchClr,
                ),
                child: Stack(
                  children: [
                    AnimatedContainer(
                      padding: const EdgeInsets.only(left: 10),
                      alignment: dayAlign,
                      duration: const Duration(seconds: 1),
                      child: Icon(
                        Icons.sunny,
                        color: actionsClmnnClr,
                        size: 30,
                      ),
                    ),
                    AnimatedContainer(
                      padding: const EdgeInsets.only(right: 10),
                      alignment: nightAlign,
                      duration: const Duration(seconds: 1),
                      child: Icon(
                        Icons.mode_night_outlined,
                        color: actionsClmnnClr,
                        size: 30,
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
                          width: 50,
                          height: 50,
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
                padding: const EdgeInsets.only(top: 60),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "6,291/5",
                    style: TextStyle(
                      color: lastAction,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "1,258.2",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: resultClr,
                      fontSize: 70,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    button(actRowClr, "C", numTxtClr),
                    button(actRowClr, "+/-", numTxtClr),
                    button(actRowClr, "%", numTxtClr),
                    button(actionsClmnnClr, "÷", white),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    button(numClr, "7", numTxtClr),
                    button(numClr, "8", numTxtClr),
                    button(numClr, "9", numTxtClr),
                    button(actionsClmnnClr, "x", white),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    button(numClr, "4", numTxtClr),
                    button(numClr, "5", numTxtClr),
                    button(numClr, "6", numTxtClr),
                    button(actionsClmnnClr, "-", white),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    button(numClr, "1", numTxtClr),
                    button(numClr, "2", numTxtClr),
                    button(numClr, "3", numTxtClr),
                    button(actionsClmnnClr, "+", white),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    button(numClr, ".", numTxtClr),
                    button(numClr, "0", numTxtClr),
                    button(numClr, "DEL", numTxtClr),
                    button(actionsClmnnClr, "=", white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell button(Color bgclr, String text, Color numTxtClr) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 75,
        height: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: bgclr,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: numTxtClr,
            ),
          ),
        ),
      ),
    );
  }
}
