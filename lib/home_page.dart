import 'package:rmgmapp/data.dart';
import 'package:rmgmapp/data_provider.dart';
import 'package:rmgmapp/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dataProvider = context.watch<DataProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('tabla de recordatorios'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: dataProvider.dataList.length,
                  itemBuilder: (context, index) {
                    final Data data = dataProvider.dataList[index];
                    return Item(
                      data: data,
                      onEditPressed: () => _editContact(data, context, dataProvider),
                      onDeletePressed: () => dataProvider.delete(data.id!),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addContact(context, dataProvider);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addContact(BuildContext context, DataProvider dataProvider) {
    showDialog(
        context: context,
        builder: (context) {
          String name = "";
          String email = "";
          return AlertDialog(
            title: const Text('Nuevo recordatorio'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: const InputDecoration(labelText: "Titulo"),
                ),
                TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: const InputDecoration(labelText: "Descripcion"),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar')),
              TextButton(
                  onPressed: () {
                    dataProvider.add(Data(name: name, email: email));
                    Navigator.of(context).pop();
                  },
                  child: const Text('Agregar')),
            ],
          );
        });
  }

  void _editContact(Data data, BuildContext context, DataProvider dataProvider) {
    final TextEditingController nameController = TextEditingController(text: data.name);
    final TextEditingController emailController = TextEditingController(text: data.email);
    showDialog(
        context: context,
        builder: (context) {
          String name = data.name;
          String email = data.email;
          return AlertDialog(
            title: const Text('Modificar recordatorio'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: const InputDecoration(labelText: "Titulo"),
                ),
                TextField(
                  controller: emailController,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: const InputDecoration(labelText: "Descripcion"),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar')),
              TextButton(
                  onPressed: () {
                    dataProvider.edit(Data(id: data.id, name: name, email: email));
                    Navigator.of(context).pop();
                  },
                  child: const Text('Guardar')),
            ],
          );
        });
  }
}
