import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ماشین حساب',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {

  String equation = "0";
  String result = "0";
  String expression = "0";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String ButtonText) {
    setState(() {
      if(ButtonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      }
      else if(ButtonText == "⌫") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0,equation.length - 1);
        if(equation == "0"){
          equation = "0";
        }
      }
      else if(ButtonText == "="){
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';

        }catch(e){
          result = "خطا امکان محاسبه نیست";
        }
      }
      else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if(equation == "0"){
          equation = ButtonText;
        }else {
          equation = equation + ButtonText;
        }
      }
    });
  }

  Widget BuildButton(String ButtonText, double ButtonHeight, Color ButtonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * ButtonHeight,
      color: ButtonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white,
                  width: 1,
                  style: BorderStyle.solid
              )
          ),
          padding: EdgeInsets.all(16.0),
          onPressed: () => buttonPressed(ButtonText),
          child: Text(ButtonText, style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.white
          ),
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ماشین حساب من')),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation , style: TextStyle(fontSize: equationFontSize),),
          ),

          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result, style: TextStyle(fontSize: resultFontSize),),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        BuildButton('C', 1, Colors.redAccent),
                        BuildButton('⌫', 1, Colors.redAccent),
                        BuildButton('÷', 1, Colors.redAccent),
                      ]
                    ),
                    TableRow(
                        children: [
                          BuildButton('7', 1, Colors.black54),
                          BuildButton('8', 1, Colors.black54),
                          BuildButton('9', 1, Colors.black54),
                        ]
                    ),
                    TableRow(
                        children: [
                          BuildButton('4', 1, Colors.black54),
                          BuildButton('5', 1, Colors.black54),
                          BuildButton('6', 1, Colors.black54),
                        ]
                    ),
                    TableRow(
                        children: [
                          BuildButton('1', 1, Colors.black54),
                          BuildButton('2', 1, Colors.black54),
                          BuildButton('3', 1, Colors.black54),
                        ]
                    ),
                    TableRow(
                        children: [
                          BuildButton('.', 1, Colors.black54),
                          BuildButton('0', 1, Colors.black54),
                          BuildButton('00', 1, Colors.black54),
                        ]
                    ),
                  ],
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        BuildButton('×', 1, Colors.blue),
                      ]
                    ),
                    TableRow(
                        children: [
                          BuildButton('-', 1, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children: [
                          BuildButton('+', 1, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children: [
                          BuildButton('=', 2, Colors.redAccent),
                        ]
                    ),
                  ],
                ),
              )

            ],
          ),
        ],
      ),
    );
  }
}


