import 'package:flutter/material.dart';
import 'package:gaba_stationery/models/cart.dart';
import 'package:gaba_stationery/models/order.dart';
import 'package:gaba_stationery/widgets/cart_item.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final order =  Provider.of<Order>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(10),
            elevation: 6,
            child: ListTile(
              title: Text(
                "Total ${cart.totalAmount.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Icon(
                Icons.monetization_on_rounded,
                color: Theme.of(context).primaryColorDark,
              ),
              trailing: ElevatedButton(
                onPressed: cart.items.isEmpty ? null : () {
                  order.addOrder(
                    cart.items.values.toList(),
                    cart.totalAmount,
                  );
                  cart.clear();
                },
                child: Text('Order Now',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).primaryColorLight,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
                itemCount: cart.itemCount,
                itemBuilder: (ctx, i) => CartItem(
                      id: cart.items.values.toList()[i].id,
                      title: cart.items.values.toList()[i].title,
                      price: cart.items.values.toList()[i].price,
                      quantity: cart.items.values.toList()[i].quantity,
                      productId: cart.items.keys.toList()[i],
                    )),
          )
        ],
      ),
    );
  }
}
