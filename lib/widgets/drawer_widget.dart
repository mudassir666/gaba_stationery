import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gaba_stationery/screens/order_screen.dart';
import 'package:gaba_stationery/screens/user_stationery_screen.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello Friend'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_bag_outlined),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
            },
          ),
           Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Stationies'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(UserStationeryScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
