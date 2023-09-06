import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _gasController = TextEditingController();
  final TextEditingController _alcoolController = TextEditingController();
  String _resultado = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Calculadora Álcool vs Gasolina",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _gasController.clear();
                _alcoolController.clear();
                _resultado = "";
              });
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(children: [
        Container(
          child: Image.asset(
            'images/gas.png',
            height: 100,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: TextField(
            controller: _gasController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                label: Text(
                  "Valor da Gasolina",
                  style: TextStyle(fontSize: 18),
                ),
                prefixText: "R\$ "),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: TextField(
            controller: _alcoolController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                label: Text(
                  "Valor do Alcool",
                  style: TextStyle(fontSize: 18),
                ),
                prefixText: "R\$ "),
          ),
        ),
        Container(
          width: 250,
          height: 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {
              FocusScope.of(context).unfocus();
              double gasPrice = double.parse(_gasController.text);
              double alcoolPrice = double.parse(_alcoolController.text);

              double resultado = alcoolPrice / gasPrice;
              setState(() {
                if (resultado < 0.7) {
                  _resultado = "Vai de Alcool";
                } else {
                  _resultado = "Vai de Gasolina";
                }
              });
            },
            child: const Text(
              "Calcular",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          child: Text(
            _resultado,
            style: TextStyle(fontSize: 30),
          ),
        ),
      ]),
    );
  }
}
