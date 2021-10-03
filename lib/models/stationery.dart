import 'package:flutter/material.dart';
import 'package:gaba_stationery/models/stationery_blueprint.dart';

class Stationery with ChangeNotifier {
  List<StationeryBlueprint> _items = [
    StationeryBlueprint(
      id: 's1',
      title: 'Pen',
      description: 'ball pen',
      imageUrl: "https://awebplan.com/wp-content/uploads/2017/12/pen.jpg",
      price: 20,
    ),
    StationeryBlueprint(
      id: 's2',
      title: 'Book',
      description: 'ball pen',
      imageUrl: "https://www.ynharari.com/wp-content/uploads/2017/01/sapiens.png",
      price: 300,
    ),
    StationeryBlueprint(
      id: 's3',
      title: 'Beg',
      description: 'ball pen',
      imageUrl: "https://image.made-in-china.com/2f0j00yahGtFRlhNco/Wholesale-Backpack-Bag-School-for-Boys-and-Girls.jpg",
      price: 800,
    ),
    StationeryBlueprint(
      id: 's4',
      title: 'Box',
      description: 'ball pen',
      imageUrl: "https://i.pinimg.com/originals/83/68/9f/83689fac2c6724fd9dcb056eb92598b5.jpg",
      price: 160,
    ),
  ];


  List<StationeryBlueprint> get items {
    return [..._items];
  }

  List<StationeryBlueprint> get favoriteItem {
    return _items.where((stationery) => stationery.isFavorite == true).toList();
  }

  StationeryBlueprint findById(var id) {
    return _items.firstWhere((stationery) => stationery.id == id);
  }

  void addProduct(StationeryBlueprint stationery) {
    // the product we are getting from argument , it will be pass into new product then it will be added
    final newStationery = StationeryBlueprint(
      id: DateTime.now().toString(),
      title: stationery.title,
      description: stationery.description,
      price: stationery.price,
      imageUrl: stationery.imageUrl,
    );

    _items.add(newStationery);
    // _items.insert(0, newProduct); // at the start of the list

    //it will notify all the listner that some update has been made therefor listner widget will rebuild
    notifyListeners();
  }

  void updateProduct(String id, StationeryBlueprint newStationery) {
    // it will give the index of the product we are going to update
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    //to check if we have  the index or not
    if (prodIndex >= 0) {
      // replace the chosen product from index to newProduct
      _items[prodIndex] = newStationery;
      notifyListeners();
    } else {
      print('no index');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((stat) => stat.id == id);
    notifyListeners();
  }


}
