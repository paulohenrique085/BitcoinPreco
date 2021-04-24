import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _valor = "0";
  _valueBitcoin() async {
    String url = "https://blockchain.info/ticker";
    http.Response retornoBitcoin;
    retornoBitcoin = await http.get(url);
    Map<String, dynamic> retornoValues = json.decode(retornoBitcoin.body);
    dynamic br = retornoValues["BRL"];
    dynamic precoCompra = br["buy"];

    setState(() {
      //cachorrada, transformando retorno em string
      _valor = precoCompra.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Preço do Bitcoin"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: Container(
                  width: 110,
                  height: 110,
                  child: Image.asset("assets/bitcoin.png")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: Text(
                " R\$ ${_valor}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 80),
            child: Container(
                height: 60,
                width: 200,
                child: RaisedButton(
                    color: Colors.yellow[800],
                    child: Text(
                      "Atualizar",
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: _valueBitcoin)),
          )
        ],
      ),
    );
  }
}
