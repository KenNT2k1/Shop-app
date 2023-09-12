import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      /// Providers are above [MyApp] instead of inside it, so that tests
      /// can use [MyApp] while mocking the providers
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProductProvider()),
          ChangeNotifierProvider(create: (_) => CartProvider()),
        ],
        child: const MyApp(),
      ),
    );

class ProductProvider extends ChangeNotifier {
  final products = [
    {
      'id': 'VuLm2UGhzBCSr2',
      'title': 'Product 1',
      'price': 3,
      'description': 'product 1 description',
      'imageUrl': 'https://picsum.photos/id/237/200/300',
      'quantity': 1,
    },
    {
      'id': 'cvHAzDTPfaIJ',
      'title': 'Product 2',
      'price': 4,
      'description': 'product 2 description',
      'imageUrl': 'https://picsum.photos/id/2/200/300',
      'quantity': 1,
    },
    {
      'id': 'OlXtnvXbOsvMM1MPGJ',
      'title': 'Product 3',
      'price': 5,
      'description': 'product 3 description',
      'imageUrl': 'https://picsum.photos/id/3/200/300',
      'quantity': 1,
    }
  ];

  void toggleFavorite(Map<String, Object> product) {
    product['favorite'] = !((product['favorite'] ?? false) as bool);
    notifyListeners();
  }
}

class CartProvider extends ChangeNotifier {
  final products = List<Map<String, Object>>.empty(growable: true);

  void addToCart(Map<String, Object> product) {
    products.add(product);
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: MyShopScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyShopScreen extends StatelessWidget {
  const MyShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    final products = productProvider.products;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
        actions: [
          Stack(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_cart_outlined)),
              Consumer<CartProvider>(
                builder: (context, value, child) {
                  return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.red,
                      ),
                      padding: const EdgeInsets.all(2),
                      child: Text('${value.products.length}'));
                },
              )
            ],
          )
        ],
      ),
      body: GridView.builder(
        itemCount: products.length,
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          final product = products[index];
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailProduct(product: product),
              ));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GridTile(
                footer: GridTileBar(
                  backgroundColor: Colors.black87,
                  title: Text(product['title'] as String),
                  subtitle: Text(product['description'] as String),
                  leading: IconButton(
                    icon: Icon(
                      ((product['favorite'] ?? false) as bool)
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      productProvider.toggleFavorite(product);
                    },
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.add_shopping_cart,
                    ),
                    onPressed: () {
                      context.read<CartProvider>().addToCart(product);
                    },
                  ),
                ),
                child: Image.network(product['imageUrl'] as String,
                    fit: BoxFit.cover),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailProduct extends StatelessWidget {
  const DetailProduct({super.key, required this.product});

  final Map<String, Object> product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                product['imageUrl'] as String,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 10,
                left: 50,
                right: 0,
                child: Text(
                  product['title'] as String,
                  style: const TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
        Text(
          '\$${product['price']}',
          style: const TextStyle(color: Colors.grey),
        ),
        Text(
          '${product['description']}',
          style: const TextStyle(color: Colors.black),
        ),
      ]),
    );
  }
}
