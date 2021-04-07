import 'package:exercicio_dezani/models/item.model.dart';
import 'package:exercicio_dezani/repositories/item.repository.dart';
import 'package:flutter/material.dart';

class ListaPage extends StatefulWidget {
  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  final repository = ItemRepository();

  List<Item> itens;

  @override
  initState() {
    super.initState();
    this.itens = repository.read();
  }

  Future adicionarItem(BuildContext context) async {
    var result = await Navigator.of(context).pushNamed('/nova');
    if (result == true) {
      setState(() {
        this.itens = repository.read();
      });
    }
  }

  Future<bool> confirmarExclusao(BuildContext context) async{
    return showDialog(
      context: context, 
      barrierDismissible: true,
      builder: (_){
        return AlertDialog(
          title: Text("Confirma a exclusão?"),
          actions: [
            FlatButton(
              child: Text("Sim"),
              onPressed: () => Navigator.of(context).pop(true),
            ),
            FlatButton(
              child: Text("Não"),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          ],
        );
      }
    );
  }

  Future<bool> moverProduto(BuildContext context) async{
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_){
        return AlertDialog(title: Text("Produto não foi encontrado ?"),
        actions: [
          FlatButton(
            child: Text("Sim"),
            onPressed: () => Navigator.of(context).pop(true),
          ),
          FlatButton(
              child: Text("Não"),
              onPressed: () => Navigator.of(context).pop(false),
            ),
        ],
        );
      }
    );
  }

  bool canEdit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Compras"),
        centerTitle: true,
        actions: [Row(children: [IconButton(icon: Icon(Icons.edit),
          onPressed: () => setState(() => canEdit = !canEdit),
          ), IconButton(icon: Icon(Icons.sentiment_dissatisfied_rounded),
          onPressed: () {Navigator.of(context).pushNamed(
                      '/nencontrado',
                    );},
          ),],)
          
        ],
      ),
      body: ListView.builder(
        itemCount: itens.length,
        itemBuilder: (_, indice) {
          var item = itens[indice];
          return Dismissible(
            key: Key(item.texto),
            background: Container(
              color: Colors.red,
            child:Row(children: [ Text("Excluir"), Icon(Icons.delete_forever_rounded)]), 
            ),
            secondaryBackground: Container(color :Colors.green[100],
                alignment: Alignment.centerRight,
                child:Row(mainAxisAlignment:MainAxisAlignment.end,  children:[ Text("Produto não encontrado"), Icon(Icons.sentiment_dissatisfied_rounded)]),
            ),
            onDismissed: (direction) {
              if(direction == DismissDirection.startToEnd){
                repository.delete(item.texto);
                setState(() => this.itens.remove(item));
              }
              else if (direction == DismissDirection.endToStart){
                Navigator.of(context).pushNamed(
                      '/nencontrado',
                    );
              }

              repository.delete(item.texto);
              setState(() {
                this.itens.remove(item);
              });
            }, 
            confirmDismiss: (_) => confirmarExclusao(context),
            child: CheckboxListTile(
              subtitle: Text(item.quantidade.toString()),
              title: Row(
                children: [
                  canEdit 
                  ? IconButton(icon: Icon(Icons.edit), onPressed: () async { var result = await Navigator.of(context).pushNamed(
                    '/edita',
                    arguments: item,
                    );
                    if (result) {
                      setState(() => this.itens = repository.read());
                    }
                  })
                  
                  : Container(),
                  IconButton(icon: Icon(Icons.sentiment_dissatisfied_outlined), onPressed: () {
                    repository.addnencontrados(item);
                    repository.delete(item.texto);
                     setState(() => this.itens = repository.read());
                  }
                  ),
                  Text(
                    item.texto,
                    style: TextStyle(
                      decoration: item.finalizada
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ],
              ),
              value: item.finalizada,
              onChanged: (value) {
                setState(() => item.finalizada = value);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => adicionarItem(context),
      ),
      floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked,
    );
  }
}
