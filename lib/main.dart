import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String dados = "Informe seus dados";

  void resetFields() {
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      dados = "Informe seus dados";
      formKey = GlobalKey<FormState>();
    });
  }

  void calcular() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);
      if (imc < 18.6) {
        dados = "Abaixo do peso! (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        dados = "Peso ideal! (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        dados = "Levemente acima do peso! (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        dados = "Obesidade Grau I! (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        dados = "Obesidade Grau II! (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40) {
        dados = "Obesidade Grau III! (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Calculadora IMC",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        actions: [
          IconButton(
            onPressed: resetFields,
            icon: const Icon(Icons.refresh),
            color: Colors.white,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.person_pin_outlined,
                  size: 140.0, color: Colors.lightBlue),
              TextFormField(
                controller: pesoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Peso (KG)",
                  labelStyle: TextStyle(color: Colors.lightBlue),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.lightBlue, fontSize: 25.0),
                validator: (value) {
                  if(value!.isEmpty){
                    return "Insira seu peso!";
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: alturaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Altura (CM)",
                  labelStyle: TextStyle(color: Colors.lightBlue),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.lightBlue, fontSize: 25.0),
                validator: (value) {
                  if(value!.isEmpty){
                    return "Insira sua altura!";
                  } else {
                    return null;
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: (){
                      if(formKey.currentState!.validate()){
                        calcular();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                        foregroundColor: Colors.white),
                    child: const Text("Calcular"),
                  ),
                ),
              ),
              Text(
                dados,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.lightBlue, fontSize: 25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
