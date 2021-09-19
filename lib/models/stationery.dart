import 'package:flutter/material.dart';
import 'package:gaba_stationery/models/stationery_blueprint.dart';

class Stationery with ChangeNotifier {
  List<StationeryBlueprint> _items = [
    StationeryBlueprint(
      id: 's1',
      title: 'pen',
      description: 'ball pen',
      imageUrl: "https://awebplan.com/wp-content/uploads/2017/12/pen.jpg",
      price: 20,
    ),
    StationeryBlueprint(
      id: 's2',
      title: 'pen',
      description: 'ball pen',
      imageUrl: "https://awebplan.com/wp-content/uploads/2017/12/pen.jpg",
      price: 20,
    ),
    StationeryBlueprint(
      id: 's3',
      title: 'beg',
      description: 'ball pen',
      imageUrl: "https://awebplan.com/wp-content/uploads/2017/12/pen.jpg",
      price: 20,
    ),
    StationeryBlueprint(
      id: 's4',
      title: 'book',
      description: 'ball pen',
      imageUrl: "https://awebplan.com/wp-content/uploads/2017/12/pen.jpg",
      price: 20,
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
