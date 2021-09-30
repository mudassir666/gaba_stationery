import 'package:flutter/material.dart';
import 'package:gaba_stationery/models/stationery.dart';
import 'package:gaba_stationery/screens/edit_product_screen.dart';
import 'package:gaba_stationery/widgets/drawer_widget.dart';
import 'package:gaba_stationery/widgets/user_stationery_item.dart';
import 'package:provider/provider.dart';

class UserStationeryScreen extends StatelessWidget {
  static const routeName = '/user-stationery';

  @override
  Widget build(BuildContext context) {
    final stationery = Provider.of<Stationery>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Stationies'),
        actions: [
          IconButton(
            onPressed: () {Navigator.of(context).pushNamed(EditProductScreen.routeName);},
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: DrawerWidget(),
      body: ListView.builder(
        itemCount: stationery.items.length,
        itemBuilder: (ctx, i) => Column(
          children: [
            UserStationeryItem(
              id: stationery.items[i].id,
              title: stationery.items[i].title,
              imgUrl: stationery.items[i].imageUrl,
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
