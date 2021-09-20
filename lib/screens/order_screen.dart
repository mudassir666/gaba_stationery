import 'package:flutter/material.dart';
import 'package:gaba_stationery/models/order.dart';
import 'package:gaba_stationery/widgets/drawer_widget.dart';
import 'package:gaba_stationery/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/order';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Order"),
        centerTitle: true,
      ),
      drawer: DrawerWidget(),
      body: ListView.builder(
        itemCount: orderData.itemCount,
        itemBuilder: (ctx, i) => OrderItem(
          orderData.order[i],
        ),
      ),
    );
  }
}
