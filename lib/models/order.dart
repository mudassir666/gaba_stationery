import 'package:flutter/material.dart';
import 'package:gaba_stationery/widgets/order_item.dart';
import 'package:http/http.dart' as http;
import 'cart.dart';
import 'dart:convert';

class OrderBlueprint {
  final String id;
  final double totalAmount;
  final List<CartBlueprint> stationeries;
  final DateTime dateTime;

  OrderBlueprint({
    required this.id,
    required this.totalAmount,
    required this.stationeries,
    required this.dateTime,
  });
}

class Order with ChangeNotifier {
  List<OrderBlueprint> _order = [];

  List<OrderBlueprint> get order {
    return [..._order];
  }

  int get itemCount {
    return _order.length;
  }

  Future<void> addOrder(
      List<CartBlueprint> cartItems, double totalAmount) async {
    const url =
        'https://gaba-stationery-default-rtdb.firebaseio.com/orders.json';

    final timestamp = DateTime.now();

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          "totalAmount": totalAmount,
          "stationeries": cartItems
              .map((ci) => {
                    'id': ci.id,
                    'title': ci.title,
                    'quantity': ci.quantity,
                    'price': ci.price,
                  })
              .toList(),
          "dateTime": timestamp.toIso8601String(),
        }),
      );

      print(response.body);

      _order.insert(
        0,
        OrderBlueprint(
          id: json.decode(response.body)['name'],
          totalAmount: totalAmount,
          stationeries: cartItems,
          dateTime: timestamp,
        ),
      );
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchStationery() async {
    const url =
        'https://gaba-stationery-default-rtdb.firebaseio.com/orders.json';

    try {
      final response = await http.get(Uri.parse(url));
      print(json.decode(response.body));
      if (json.decode(response.body) == null) {
        _order = [];
        return;
      }

      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      final List<OrderBlueprint> loadedOrders = [];

      extractedData.forEach((orderId, orderData) {
        loadedOrders.add(
          OrderBlueprint(
            id: orderId,
            totalAmount: orderData['totalAmount'],
            stationeries: (orderData['stationeries'] as List<dynamic>)
                .map(
                  (item) => CartBlueprint(
                      id: item["id"],
                      title: item['title'],
                      quantity: item['quantity'],
                      price: item['price']),
                )
                .toList(),
            dateTime: DateTime.parse(orderData['dateTime']),
          ),
        );
      });

      _order = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
