import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../screens/cart_screen.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';

enum PopupMenuActions {
  ShowFavourites,
  ShowAll,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavourites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
            ),
            onSelected: (value) {
              setState(() {
                if (value == PopupMenuActions.ShowFavourites) {
                  _showOnlyFavourites = true;
                } else {
                  _showOnlyFavourites = false;
                }
              });
            },
            itemBuilder: (_) =>
            [
              PopupMenuItem(
                child: Text('Only Favourites'),
                value: PopupMenuActions.ShowFavourites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: PopupMenuActions.ShowAll,
              ),
            ],
          ),
          Badge(
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              },
            ),
            value: Provider
                .of<Cart>(context)
                .itemCount
                .toString(),
            color: Colors.redAccent,
          ),
        ],
      ),
      body: ProductsGrid(_showOnlyFavourites),
    );
  }
}
