import 'package:flutter/material.dart';
import 'package:todo_list/model/task.dart';

class CadastroScreen extends StatefulWidget {
  Task? tarefa;
  CadastroScreen({this.tarefa});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  TextEditingController _textController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.tarefa != null) {
      setState(() {
        _textController.text = widget.tarefa!.texto;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cadastro de Tarefa",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: TextFormField(
                controller: _textController,
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                  labelText: "Tarefa",
                  labelStyle: TextStyle(fontSize: 18),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Preenchimento Obrigatorio!";
                  }
                },
              ),
            ),
            Row(children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 40,
                  child: ElevatedButton(
                    child: Text(
                      "Cadastrar",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState!.validate()) {
                        Task newTask = Task(_textController.text);
                        Navigator.pop(context, newTask);
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 40,
                  child: ElevatedButton(
                    child: Text(
                      "Cancelar",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
