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

  changeTheme() {
    setState(() {
      if (switchAlign == dayAlign) {
        switchAlign = nightAlign;
      } else {
        switchAlign = dayAlign;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: nightBgClr,
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
                  color: switchBtnBgClr,
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
                      duration: const Duration(seconds: 1),
                      child: InkWell(
                        onTap: () {
                          changeTheme();
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: switchBtnClr,
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
                      color: white,
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
                    button(nightactionsClmnClr, "C"),
                    button(nightactionsClmnClr, "+/-"),
                    button(nightactionsClmnClr, "%"),
                    button(actionsClmnnClr, "÷"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    button(numbersClr, "7"),
                    button(numbersClr, "8"),
                    button(numbersClr, "9"),
                    button(actionsClmnnClr, "*"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    button(numbersClr, "4"),
                    button(numbersClr, "5"),
                    button(numbersClr, "6"),
                    button(actionsClmnnClr, "-"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    button(numbersClr, "1"),
                    button(numbersClr, "2"),
                    button(numbersClr, "3"),
                    button(actionsClmnnClr, "+"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    button(numbersClr, "."),
                    button(numbersClr, "0"),
                    button(numbersClr, "DEL"),
                    button(actionsClmnnClr, "="),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell button(Color bgclr, String text) {
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
              color: white,
            ),
          ),
        ),
      ),
    );
  }
}
