import 'package:flutter/material.dart';
import 'package:gaba_stationery/models/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final int quantity;
  final String productId;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
    direction: DismissDirection.endToStart,
     onDismissed: (_){
        Provider.of<Cart>(context,listen: false).removeItem(productId);
     } ,
    background: Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(10),
      color: Theme.of(context).errorColor,
      child: Icon(Icons.delete_rounded,size: 40,color: Colors.white,),
      alignment: Alignment.centerRight,
    ),
      child: Card(
        margin: EdgeInsets.all(10),
        elevation: 6,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColorLight,
            child: FittedBox(
              child: Text(
                price.toString(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          title: Text(
            title,style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              
          ),
          subtitle: Text("Total: \$${price * quantity}"),
          trailing: Text("$quantity x",style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),),
        ),
      ),
    );
  }
}
