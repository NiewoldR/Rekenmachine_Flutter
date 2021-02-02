import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Rekenmachine extends StatefulWidget {
  @override
  State createState() => new RekenmachineState();
}

class RekenmachineState extends State<Rekenmachine> {
  String som = "0";
  String resultaat = "0";
  String berekenen = "";
  bool resultaatBerekend = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Rekenmachine"),
        ),

        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              Container(
                constraints: BoxConstraints.expand(
                  height: 40,
                ),
                alignment: Alignment.bottomRight,
                color: Colors.black,
                child: new Text(
                  "$som",
                  style: TextStyle(fontSize: 30.0, color: Colors.green),
                  textAlign: TextAlign.right,
                ),
              ),

              Container(
                constraints: BoxConstraints.expand(
                  height: 60
                ),
                alignment: Alignment.bottomRight,
                color: Colors.black,
                child: new Text(
                  "$resultaat",
                  style: TextStyle(fontSize: 45.0, color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
              ),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _knop("C", Colors.redAccent),
                  _knop("(", Colors.white),
                  _knop(")", Colors.white),
                  _knop("⌫", Colors.blueAccent)
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _knop("7", Colors.white),
                  _knop("8", Colors.white),
                  _knop("9", Colors.white),
                  _knop("+", Colors.white)
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _knop("4", Colors.white),
                  _knop("5", Colors.white),
                  _knop("6", Colors.white),
                  _knop("-", Colors.white)
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _knop("1", Colors.white),
                  _knop("2", Colors.white),
                  _knop("3", Colors.white),
                  _knop("*", Colors.white)
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _knop("=", Colors.greenAccent),
                  _knop("0", Colors.white),
                  _knop(".", Colors.white),
                  _knop("/", Colors.white)
                ],
              )
            ],
          ),
        ));
  }

  Widget _knop(String number, Color knopKleur) {
    return MaterialButton(
        height: 75.0,
        child: Text(number,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0)),
        textColor: Colors.black,
        color: knopKleur,
        onPressed: () => invoerVerwerken(number));
  }

  invoerVerwerken(String invoer) {
    setState(() {
      if (resultaatBerekend) {
        som = resultaat;
        resultaatBerekend = false;
      }

      if (invoer == "C") {
        som = "0";
        resultaat = "0";
      }

      else if (invoer == "⌫") {
        som = som.substring(0, som.length - 1);
        if (som == "") {
          som = "0";
        }
      }

      else if (invoer == "=") {
        berekenen = som;
        resultaatBerekend = true;
        try {
          Parser p = Parser();
          Expression exp = p.parse(berekenen);

          ContextModel cm = ContextModel();
          resultaat = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          resultaat = "Error";
        }
      }

      else {
        if (som == "0") {
          som = invoer;
        } else {
          som += invoer;
        }
      }
    });
  }
}
