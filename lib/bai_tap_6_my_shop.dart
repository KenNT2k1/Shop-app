import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: MyShopScreen(),
    );
  }
}

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

class MyShopScreen extends StatelessWidget {
  const MyShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
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
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    onPressed: () {},
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.add_shopping_cart,
                    ),
                    onPressed: () {},
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
