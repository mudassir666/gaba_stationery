import 'package:flutter/material.dart';

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

  void changeFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
