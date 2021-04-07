
import 'package:exercicio_dezani/models/item.model.dart';
import 'package:exercicio_dezani/repositories/item.repository.dart';
import 'package:flutter/material.dart';

class NovaPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _item = Item();
  final _repository = ItemRepository();

  onSave(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _repository.create(_item);
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adcionar Produto"),
        centerTitle: false,
        actions: [
          FlatButton(
            child: Text("Salvar",
                style: TextStyle(
                  color: Colors.white,
                )),
            onPressed: () => onSave(context),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child:
          Column(children:[ TextFormField(
            
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
            onSaved: (value) => _item.quantidade = int.parse(value),
            validator: (value) => value.isEmpty ? "Campo obrigatório" : null,
          ),]),
        ),
      ),
    );
  }
}
