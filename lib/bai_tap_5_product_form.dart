import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: const ProductListScreen(),
      onGenerateRoute: (settings) {
        if (settings.name == EditProduct.routerName) {
          return MaterialPageRoute(
            builder: (context) {
              return EditProduct(
                product: settings.arguments as Map<String, Object>?,
              );
            },
          );
        }
        return null;
      },
      debugShowCheckedModeBanner: false,
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

const songs = [{
  'id': 1,
  'title': 'Song 1',
  'description': 'Song 1 description',
  'duration': 30000,
  'coverUrl':'https://picsum.photos/id/3/200/300',
  'soundUrl': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3'
}];

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Product List'),
        actions: [
          IconButton(
            onPressed: () async {
              final result =
                  await Navigator.of(context).pushNamed(EditProduct.routerName);
              if (result is Map) {
                products.add(result as Map<String, Object>);
                setState(() {});
              }
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: ListView.separated(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          final product = products[index];
          return ListTile(
            leading: CircleAvatar(
                backgroundImage: NetworkImage(product['imageUrl'] as String)),
            title: Text(
              product['title'] as String,
            ),
            trailing: Wrap(
              children: [
                IconButton(
                  iconSize: 24,
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: () async {
                    final result = await Navigator.of(context)
                        .pushNamed(EditProduct.routerName, arguments: product);
                    if (result is Map) {
                      final index = products.indexWhere(
                          (element) => element['id'] == result['id']);
                      products[index] = result as Map<String, Object>;
                      setState(() {});
                    }
                  },
                ),
                IconButton(
                  iconSize: 24,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    final result = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Confirm delete'),
                        content: Text(
                            'Are you sure you want to delete - ${product['title']}'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('No')),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: const Text('Yes')),
                        ],
                      ),
                    );
                    if (result == true) {
                      final index = products.indexWhere(
                          (element) => element['id'] == product['id']);
                      products.removeAt(index);
                      setState(() {});
                    }
                  },
                )
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    );
  }
}

String generateRandomString(int len) {
  var r = Random();
  String randomString =
      String.fromCharCodes(List.generate(len, (index) => r.nextInt(33) + 89));
  return randomString;
}

class EditProduct extends StatefulWidget {
  static const routerName = "edit_product";
  const EditProduct({super.key, this.product});
  final Map<String, Object>? product;

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  String? _requiredValidation(String? value) {
    if (value?.isEmpty == true) {
      return 'This field is required';
    }
    return null;
  }

  final Map<String, Object> _product = {};
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.product != null) {
      _product.addAll(widget.product!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Product detail'),
          actions: [
            IconButton(
              onPressed: () {
                if (_formKey.currentState?.validate() == true) {
                  _formKey.currentState?.save();
                  if (_product['id'] == null) {
                    _product['id'] = generateRandomString(10);
                  }
                  Navigator.pop(context, _product);
                }
              },
              icon: const Icon(Icons.save),
            )
          ],
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(children: [
                TextFormField(
                  initialValue: _product['title']?.toString(),
                  decoration: const InputDecoration(
                    hintText: 'Title',
                  ),
                  validator: _requiredValidation,
                  onSaved: (newValue) {
                    _product['title'] = newValue ?? '';
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: _product['price']?.toString(),
                  decoration: const InputDecoration(
                    hintText: 'Price',
                  ),
                  validator: (value) {
                    if (double.tryParse(value ?? '') == null) {
                      return 'Price must be a number';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _product['price'] = newValue ?? '';
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: _product['description']?.toString(),
                  decoration: const InputDecoration(
                    hintText: 'Description',
                  ),
                  validator: _requiredValidation,
                  onSaved: (newValue) {
                    _product['description'] = newValue ?? '';
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color(0xff7c94b6),
                        image: _product['imageUrl'] != null
                            ? DecorationImage(
                                image: NetworkImage(
                                    _product['imageUrl']!.toString()),
                                fit: BoxFit.cover,
                              )
                            : null,
                        border: Border.all(
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: TextFormField(
                        initialValue: _product['imageUrl']?.toString(),
                        decoration: const InputDecoration(
                          hintText: 'Image URL',
                        ),
                        validator: _requiredValidation,
                        onSaved: (newValue) {
                          _product['imageUrl'] = newValue ?? '';
                        },
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ));
  }
}
