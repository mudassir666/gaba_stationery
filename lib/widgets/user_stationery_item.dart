import 'package:flutter/material.dart';
import 'package:gaba_stationery/models/stationery.dart';
import 'package:gaba_stationery/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

class UserStationeryItem extends StatelessWidget {
  //const UserStationeryItem({ Key? key }) : super(key: key);
  final String id;
  final String title;
  final String imgUrl;

  UserStationeryItem({
    required this.id,
    required this.title,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    // storing ScaffoldMessenger because it could not have the access of context down below
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imgUrl),
      ),
      title: Text(title),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            IconButton(
              onPressed: () async {
             try{ await  Provider.of<Stationery>(context, listen: false)
                    .deleteProduct(id);
             }catch(error){
                scaffold.showSnackBar(
                    SnackBar(
                      content: Text("Deleting failed!",textAlign: TextAlign.center,),
                      
                    ),
                  );
             }
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
