import 'package:exercicio_dezani/models/item.model.dart';
import 'package:exercicio_dezani/repositories/item.repository.dart';
import 'package:flutter/material.dart';

class EditaPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _item = Item();
  final _repository = ItemRepository();

  onSave(BuildContext context, Item item) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save(); 
      _repository.update(_item, item);
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    Item item = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Produto"),
        centerTitle: false,
        actions: [
          FlatButton(
            child: Text("Salvar",
                style: TextStyle(
                  color: Colors.white,
                )),
            onPressed: () => onSave(context, item),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child:
          Column(children:[ TextFormField(
            initialValue: item.texto,
            decoration: InputDecoration(
              labelText: "Descrição",
              border: OutlineInputBorder(),
            ),
            onSaved: (value) => _item.texto = value,
            validator: (value) => value.isEmpty ? "Campo obrigatório" : null,
            ),
            Padding(padding: EdgeInsets.only(top:15)),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Quantidade",
                border: OutlineInputBorder(),
              ),
              onSaved: (value)=> _item.quantidade = int.parse(value),
              validator: (value)=> value.isEmpty ? "Campo obrigatório":null,
            )
            ]),
        ),
      ),
    );
  }
}
