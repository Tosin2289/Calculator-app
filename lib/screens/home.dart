import 'package:calculator_app/screens/btn.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

var userquestion = '';
var useranswer = '';

class _HomeState extends State<Home> {
  final List<String> buttons = [
    'c',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    '00',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 55,
                  ),
                  Container(
                      padding: const EdgeInsets.all(25),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        userquestion,
                        style:
                            const TextStyle(fontSize: 30, color: Colors.white),
                      )),
                  Container(
                      padding: const EdgeInsets.all(25),
                      alignment: Alignment.centerRight,
                      child: Text(
                        useranswer,
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            userquestion = '';
                            useranswer = '';
                          });
                        },
                        color: Colors.white,
                        btntext: buttons[index],
                        buttoncolor: Colors.green,
                      );
                    } else if (index == buttons.length - 1) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        color: Colors.black,
                        btntext: buttons[index],
                        buttoncolor: Colors.white,
                      );
                    } else if (index == 1) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            userquestion = userquestion.substring(
                                0, userquestion.length - 1);
                          });
                        },
                        color: Colors.white,
                        btntext: buttons[index],
                        buttoncolor: Colors.red,
                      );
                    } else {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            userquestion += buttons[index];
                          });
                        },
                        color: isOperator(buttons[index])
                            ? Colors.black
                            : Colors.white,
                        btntext: buttons[index],
                        buttoncolor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.blue,
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == "%" || x == "/" || x == "x" || x == "-" || x == "+") {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalquestion = userquestion;
    finalquestion = finalquestion.replaceAll('x', '*');
    Parser P = Parser();
    Expression exp = P.parse(finalquestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    useranswer = eval.toString();
  }
}
