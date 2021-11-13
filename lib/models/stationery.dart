import 'package:flutter/material.dart';
import 'package:gaba_stationery/models/http_exception.dart';
import 'package:gaba_stationery/models/stationery_blueprint.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Stationery with ChangeNotifier {
  List<StationeryBlueprint> _items = [
    // StationeryBlueprint(
    //   id: 's1',
    //   title: 'Pen',
    //   description: 'ball pen',
    //   imageUrl: "https://awebplan.com/wp-content/uploads/2017/12/pen.jpg",
    //   price: 20,
    // ),
    // StationeryBlueprint(
    //   id: 's2',
    //   title: 'Book',
    //   description: 'ball pen',
    //   imageUrl:
    //       "https://www.ynharari.com/wp-content/uploads/2017/01/sapiens.png",
    //   price: 300,
    // ),
    // StationeryBlueprint(
    //   id: 's3',
    //   title: 'Beg',
    //   description: 'ball pen',
    //   imageUrl:
    //       "https://image.made-in-china.com/2f0j00yahGtFRlhNco/Wholesale-Backpack-Bag-School-for-Boys-and-Girls.jpg",
    //   price: 800,
    // ),
    // StationeryBlueprint(
    //   id: 's4',
    //   title: 'Box',
    //   description: 'ball pen',
    //   imageUrl:
    //       "https://i.pinimg.com/originals/83/68/9f/83689fac2c6724fd9dcb056eb92598b5.jpg",
    //   price: 160,
    // ),
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

  Future<void> fetchData() async {
    const url =
        'https://gaba-stationery-default-rtdb.firebaseio.com/stationery.json';

    try {
      final response = await http.get(Uri.parse(url));

      if (json.decode(response.body) == null.toString()) {
        _items = [];
        return;
      }

      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      final List<StationeryBlueprint> loadedStationery = [];

      extractedData.forEach((stationeryId, stationeryData) {
        loadedStationery.add(StationeryBlueprint(
          id: stationeryId,
          title: stationeryData['title'],
          description: stationeryData['description'],
          imageUrl: stationeryData['imageUrl'],
          price: stationeryData['price'],
          isFavorite: stationeryData['isFavorite'],
        ));
      });

      _items = loadedStationery;

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> addProduct(StationeryBlueprint stationery) async {
    // the product we are getting from argument , it will be pass into new product then it will be added

    const url =
        'https://gaba-stationery-default-rtdb.firebaseio.com/stationery.json';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'title': stationery.title,
          'description': stationery.description,
          'imageUrl': stationery.imageUrl,
          'price': stationery.price,
          'isFavorite': stationery.isFavorite,
        }),
      );

      print(response.body);

      final newStationery = StationeryBlueprint(
        id: json.decode(response.body)['name'],
        title: stationery.title,
        description: stationery.description,
        price: stationery.price,
        imageUrl: stationery.imageUrl,
      );

      _items.add(newStationery);
      // _items.insert(0, newProduct); // at the start of the list

      //it will notify all the listner that some update has been made therefor listner widget will rebuild
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(
      String id, StationeryBlueprint newStationery) async {
    // it will give the index of the product we are going to update
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    //to check if we have  the index or not
    if (prodIndex >= 0) {
      final url =
          'https://gaba-stationery-default-rtdb.firebaseio.com/stationery/$id.json';
      try {
        await http.patch(
          Uri.parse(url),
          body: json.encode({
            'title': newStationery.title,
            'description': newStationery.description,
            'imageUrl': newStationery.imageUrl,
            'price': newStationery.price,
          }),
        );
        // replace the chosen product from index to newProduct
        _items[prodIndex] = newStationery;
        notifyListeners();
      } catch (error) {
        throw error;
      }
    } else {
      print('no index');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://gaba-stationery-default-rtdb.firebaseio.com/stationery/$id.json';

    final existingIndex = _items.indexWhere((prod) => prod.id == id);

    var existingStationery = _items[existingIndex];

    _items.removeAt(existingIndex);

    notifyListeners();

    final response = await http.delete(Uri.parse(url));

    if (response.statusCode >= 400) {
      print(response.statusCode);
      _items.insert(existingIndex, existingStationery);
      notifyListeners();

      // throw cancel the function execution
      throw HttpException('Could not delete product.');
    }

    existingStationery = null as StationeryBlueprint;
  }
}
