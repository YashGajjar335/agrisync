import 'package:agrisync/model/product.dart';
import 'package:agrisync/services/agri_mart_service_user.dart';
import 'package:agrisync/widget/product_card.dart';
import 'package:flutter/material.dart';

class AgriMartSearchDelegate extends SearchDelegate {
  List<Products> agriMartProduct = [];
  bool isLoading = true;

  AgriMartSearchDelegate() {
    _loadProduct();
  }

  void _loadProduct() async {
    agriMartProduct = await AgriMartServiceUser.instance.getAllProductName();
    isLoading = false;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_rounded),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    List<Products> matchProduct = agriMartProduct
        .where((product) =>
            product.productName.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: matchProduct.length,
      itemBuilder: (context, index) {
        String productName = matchProduct[index].productName;
        String limitedName = productName.length > 20
            ? "${productName.substring(0, 20)}..." // Limits name length
            : productName;

        return ListTile(
          title: Text(limitedName, overflow: TextOverflow.ellipsis),
          onTap: () {
            query = productName;
            showResults(context);
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Products> matchProduct = agriMartProduct
        .where((product) =>
            product.productName.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Padding(
      padding: const EdgeInsets.all(8.0 * 2),
      child: GridView.builder(
        itemCount: matchProduct.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.60,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) => ProductCard(
          products: matchProduct[index],
        ),
      ),
    );
  }
}
