import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/product_item.dart';
import '../providers/products.dart';

class ProductsGrid extends StatelessWidget {
  final bool showOnlyFavourites;

  const ProductsGrid(this.showOnlyFavourites);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showOnlyFavourites ? productsData.favouriteItems : productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(),
      ),
    );
  }
}
