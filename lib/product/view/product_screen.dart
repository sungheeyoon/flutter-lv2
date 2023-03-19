import 'package:flutter/material.dart';
import 'package:flutter_lv2/common/component/pagination_list_view.dart';
import 'package:flutter_lv2/product/component/product_card.dart';
import 'package:flutter_lv2/product/model/product_model.dart';
import 'package:flutter_lv2/product/provider/product_provider.dart';
import 'package:flutter_lv2/restaurant/view/restaurant_detail_screen.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView<ProductModel>(
      provider: productProvider,
      itemBuilder: <ProductModel>(context, index, model) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  RestaurantDetailScreen(id: model.restaurant.id),
            ));
          },
          child: ProductCard.fromProductModel(
            model: model,
          ),
        );
      },
    );
  }
}
