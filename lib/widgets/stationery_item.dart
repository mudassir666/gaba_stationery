import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaba_stationery/models/cart.dart';
import 'package:gaba_stationery/models/stationery_blueprint.dart';
import 'package:gaba_stationery/screens/stationery_detail_screen.dart';
import 'package:provider/provider.dart';

class StationeryItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stationery = Provider.of<StationeryBlueprint>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(StationeryDetailScreen.routeName,
                arguments: stationery.id);
          },
          child: Image.network(
            stationery.imageUrl,
            fit: BoxFit.contain,
          ),
        ),
        footer: GridTileBar(
          title: Text(
            stationery.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.black87,
          leading: Consumer<StationeryBlueprint>(
            builder: (ctx, stationery, child) => IconButton(
              icon: Icon(
                stationery.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                //print(stationery.isFavorite);
                stationery.changeFavoriteStatus();
              },
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart_sharp,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              cart.addItem(stationery.id, stationery.title, stationery.price);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added item to cart!'),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        cart.removeSingleItem(stationery.id);
                      }),
                ),
              );
              // print(cart.totalAmount);
            },
          ),
        ),
      ),
    );
  }
}
