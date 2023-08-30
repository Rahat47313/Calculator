import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


class Calculator extends StatefulWidget {
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = "";
  String result = "0";

  List<String> buttonList = [
    'AC',
    'C',
    'x',
    '/',
    '(',
    ')',
    '%',
    '*',
    '1',
    '2',
    '3',
    '-',
    '4',
    '5',
    '6',
    '+',
    '7',
    '8',
    '9',
    '=',
    '0',
    '00',
    '.',
    '~',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
        backgroundColor: const Color(0xff0e2433),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xff0e2433),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  // User Input
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.topRight,
                  child: Text(
                    userInput,
                    style: const TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  // Result
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style: const TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),

          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              child: GridView.builder(
                // shrinkWrap: true,
                itemCount: buttonList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.5,
                  // childAspectRatio: 4/3.4,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return customButton(buttonList[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customButton(String text) {
    return InkWell(
      splashColor: const Color(0xFF0b344f),
      onTap: () {
        setState(() {
          handleButtons(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          color: getBgColor(text),
          // borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: getColor(text),
              fontSize: 20,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  getColor(String text) {
    if (text == "/" ||
        text == "*" ||
        text == "+" ||
        text == "-" ||
        text == "C" ||
        text == "x" ||
        text == "%" ||
        text == "(" ||
        text == ")") {
      return const Color.fromARGB(255, 252, 100, 100);
    }
    if(text == "~"){
      return const Color.fromARGB(255, 104, 204, 159);
    }
    return Colors.white;
  }

  getBgColor(String text) {
    if (text == "AC") {
      return const Color.fromARGB(255, 252, 100, 100);
    }
    if (text == "=" || text == "~") {
      return const Color.fromARGB(255, 104, 204, 159);
    }
    return const Color(0xFF0b344f);
  }

  handleButtons(String text) {
    if (text == "AC") {
      userInput = "";
      result = "0";
      return;
    }
    if (text == "C") {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
        return;
      } else {
        return null;
      }
    }
    if(text == '%') {
      double userInputAsDouble = double.tryParse(userInput) ?? 0;
      result = (userInputAsDouble / 100).toString();
      return;
    }

    // if(buttonList[23] == "="){
    //   Color.fromARGB(255, 104, 204, 159);
    // }

    if(text == "=" || text == "~"){
      result = calculate();
      userInput = result;
      if(userInput.endsWith(".0")) {
        userInput = userInput.replaceAll(".0", "");
      }

      if(result.endsWith(".0")){
        result = result.replaceAll(".0", "");
        return;
      }
    }

    userInput = userInput + text.replaceAll("=", "");
  }

  String calculate(){
    try{
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    }
    catch(e){
      return "Error";
    }
  }
}
