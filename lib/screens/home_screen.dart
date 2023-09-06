import 'package:flutter/material.dart';
import 'package:todo_list/model/task.dart';
import 'package:todo_list/screens/cadastro_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> _lista = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ToDO List",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.separated(
        itemCount: _lista.length,
        itemBuilder: (context, index) {
          Task item = _lista[index];
          return Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.red,
              child: const Align(
                  alignment: Alignment(-0.95, 0),
                  child: Icon(Icons.delete, color: Colors.white)),
            ),
            secondaryBackground: Container(
              color: Colors.orange,
              child: const Align(
                  alignment: Alignment(0.95, 0),
                  child: Icon(Icons.edit, color: Colors.white)),
            ),
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                setState(() {
                  _lista.removeAt(index);
                });
              }
            },
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                Task editedTask = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CadastroScreen(tarefa: item),
                    ));
                if (editedTask != null) {
                  setState(() {
                    _lista.removeAt(index);
                    _lista.insert(index, editedTask);
                  });
                }
                return false;
              } else if (direction == DismissDirection.startToEnd) {
                return true;
              }
            },
            child: ListTile(
              title: Text(
                item.texto,
                style: TextStyle(
                  color: item.done ? Colors.grey : Colors.black,
                  decoration: item.done
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              onTap: () {
                setState(
                  () {
                    item.done = !item.done;
                  },
                );
              },
              onLongPress: () async {
                Task editedTask = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CadastroScreen(tarefa: item),
                    ));
                if (editedTask != null) {
                  setState(() {
                    _lista.removeAt(index);
                    _lista.insert(index, editedTask);
                  });
                }
              },
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
        onPressed: () async {
          try {
            Task tasks = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => CadastroScreen()));
            setState(() {
              _lista.add(tasks);
            });
          } catch (error) {
            print("Error: ${error.toString()}");
          }
        },
      ),
    );
  }
}
