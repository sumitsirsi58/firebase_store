import 'package:firebase_store/core/shared_preference_service.dart';
import 'package:firebase_store/ui/add_screen.dart';
import 'package:firebase_store/ui/update_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_store/provider/product_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required String id});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final SharedPreferencesService prefsService = SharedPreferencesService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          return ListView.builder(
            itemCount: productProvider.products.length,
            itemBuilder: (context, index) {
              final product = productProvider.products[index];
              return Padding(
                padding: EdgeInsets.all(16),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.productName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateScreen(id: product.productId),
                                    ),
                                  );
                                  await prefsService.addProduct(product);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _deleteProduct(context, product.productId);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(product.description),
                      const SizedBox(height: 8),
                      Text('ID: ${product.productId}'),
                      const SizedBox(height: 8),
                      Text(product.address),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddScreen()),
          );
          await prefsService.saveProducts(
              Provider.of<ProductProvider>(context, listen: false).products);
        },
      ),
    );
  }

  Future<void> _deleteProduct(BuildContext context, String productId) async {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    await productProvider.deleteProduct(productId);
    await prefsService.deleteProduct(productId);
  }
}
