import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StationeryBlueprint with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavorite;

  StationeryBlueprint({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.isFavorite = false,
  });

  // to void code duplication
  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> changeFavoriteStatus() async {
    final url =
        'https://gaba-stationery-default-rtdb.firebaseio.com/stationery/$id.json';
    final oldFavorite = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    try {
      final response = await http.patch(
        Uri.parse(url),
        body: json.encode({
          'isFavorite': isFavorite,
        }),
      );

      if (response.statusCode >= 400) {
        // to undo the action
        _setFavValue(oldFavorite);
      }
    } catch (error) {
      _setFavValue(oldFavorite);
    }
  }
}
