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

  StationeryBlueprint findById(String id) {
    return _items.firstWhere((stationery) => stationery.id == id);
  }
}
