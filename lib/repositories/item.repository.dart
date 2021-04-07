import 'package:exercicio_dezani/models/item.model.dart';

class ItemRepository {
  static List<Item> itens = List<Item>();
  static List<Item> nencontrados = List<Item>();

  void create(Item item) {
    itens.add(item);
  }

 void addnencontrados(Item item) {
    nencontrados.add(item);
  }

  List<Item> readnencontrados() {
    return nencontrados;
  }

  List<Item> read() {
    return itens;
  }

  void delete(String texto) {
    final item = itens.singleWhere((t) => t.texto == texto);
    itens.remove(item);
  }

  void update(Item newItem, Item oldItem) {
    final item = itens.singleWhere((t) => t.texto == oldItem.texto);
    item.texto = newItem.texto;
    itens.singleWhere((q) => q.quantidade == oldItem.quantidade);
    item.quantidade = newItem.quantidade;
  }
}
