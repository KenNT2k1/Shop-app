// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: PostList(),
    );
  }
}

class PostList extends StatefulWidget {
  const PostList({super.key});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  late Future<List?> _future;

  @override
  void initState() {
    _future = PostApi.getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: FutureBuilder<List?>(
        future: _future,
        builder: (context, snapshot) {
          if (ConnectionState.done == snapshot.connectionState) {
            final data = (snapshot.data as List);
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text('${data[index]['id']}'),
                  title: Text(data[index]['title']),
                  subtitle: Text(data[index]['body']),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PostDetailScreen(id: '${data[index]['id']}'),
                        ));
                  },
                );
              },
            );
          }
          return const CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final post = {
              'title': 'foo',
              'body': 'bar',
              'userId': 1,
            };

            try {
              final response = await PostApi.createPost(post);
              if (response.statusCode == 201) {
                ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                    const SnackBar(content: Text('Created successfully')));
              } else {
                ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                  const SnackBar(content: Text('Create failed')),
                );
              }
            } catch (e) {
              print(e);
            }
          },
          child: const Icon(Icons.add_circle)),
    );
  }
}

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({super.key, required this.id});
  final String id;

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  late Future<Map?> _future;

  @override
  void initState() {
    _future = PostApi.getPost(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post detail')),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final data = snapshot.data!;
              return Card(
                margin: const EdgeInsets.all(10),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${data['id']}'),
                      Text('${data['title']}'),
                      Text('${data['body']}'),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            final response =
                                await PostApi.deletePost(widget.id);
                            if (response.statusCode == 200) {
                              ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                                  const SnackBar(
                                      content: Text('Delete successfully')));
                            } else {
                              ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                                const SnackBar(content: Text('Delete failed')),
                              );
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: const Text('Delete'),
                      )
                    ],
                  ),
                ),
              );
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
          }
          return const CircularProgressIndicator();
        },
        future: _future,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final post = {
              'title': 'foo',
              'body': 'bar',
              'userId': 1,
            };

            try {
              final response = await PostApi.updatePost(widget.id, post);
              if (response.statusCode == 200) {
                ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                    const SnackBar(content: Text('Update successfully')));
              } else {
                ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                  const SnackBar(content: Text('Update failed')),
                );
              }
            } catch (e) {
              print(e);
            }
          },
          child: const Icon(Icons.save_outlined)),
    );
  }
}

final dio = Dio(
  BaseOptions(
    baseUrl: 'https://jsonplaceholder.typicode.com',
  ),
);

class PostApi {
  static Future<List?> getPosts() async {
    final response = await dio.get('/posts');
    return response.data;
  }

  static Future<Map?> getPost(final String id) async {
    final response = await dio.get('/posts/$id');
    return response.data;
  }

  static Future<Response> createPost(final Map post) async {
    final response = await dio.post('/posts', data: jsonEncode(post));
    return response;
  }

  static Future<Response> updatePost(final String id, final Map post) async {
    final response = await dio.put('/posts/$id', data: jsonEncode(post));
    return response;
  }

  static Future<Response> deletePost(final String id) async {
    final response = await dio.delete('/posts/$id');
    return response;
  }
}
