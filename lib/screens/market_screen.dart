import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/productPost.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  _MarketScreenState createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  final String baseUrl = 'https://othertealapple6.conveyor.cloud/api/ProductApi';
  late Future<List<productPost>> _products; // Quản lý danh sách sản phẩm

  @override
  void initState() {
    super.initState();
    _products = fetchPosts(); // Gọi API để lấy danh sách sản phẩm
  }

  Future<List<productPost>> fetchPosts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => productPost.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<void> addProduct(productPost product) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'name': product.name,
        'price': product.price,
        'image': product.image,
        'description': product.description,
      }),
    );
    if (response.statusCode == 201) {
      setState(() {
        _products = fetchPosts(); // Làm mới danh sách sản phẩm
      });
    } else {
      throw Exception('Failed to add product');
    }
  }

  Future<void> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 204) {
      setState(() {
        _products = fetchPosts(); // Làm mới danh sách sản phẩm
      });
    } else {
      throw Exception('Failed to delete product');
    }
  }

  Future<void> updateProduct(productPost product) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${product.id}'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'id': product.id,
        'name': product.name,
        'price': product.price,
        'image': product.image,
        'description': product.description,
      }),
    );
    if (response.statusCode == 204) {
      setState(() {
        _products = fetchPosts(); // Làm mới danh sách sản phẩm
      });
    } else {
      throw Exception('Failed to update product');
    }
  }

  Future<void> searchProduct(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/search/$id'));
    if (response.statusCode == 200) {
      List<dynamic> data = [json.decode(response.body)];
      setState(() {
        _products = Future.value(data.map((item) => productPost.fromJson(item)).toList());
      });
    } else {
      throw Exception('Failed to search product');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddProductDialog(), // Hiển thị dialog thêm sản phẩm
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(), // Hiển thị dialog tìm kiếm
          ),
        ],
      ),
      body: FutureBuilder<List<productPost>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products available.'));
          } else {
            List<productPost> posts = snapshot.data!;

            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                productPost post = posts[index];
                return ListTile(
                  leading: Image.network(post.image ?? ''),
                  title: Text(post.name ?? 'No name'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Giá: ${post.price?.toStringAsFixed(2) ?? '0'} đ', // Hiển thị giá
                          style: const TextStyle(color: Colors.green)),
                      Text(post.description ?? 'No description', maxLines: 2, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _showEditProductDialog(post), // Sửa sản phẩm
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteProduct(post.id!), // Xóa sản phẩm
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _showAddProductDialog() {
    final _nameController = TextEditingController();
    final _priceController = TextEditingController();
    final _imageController = TextEditingController();
    final _descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Name')),
              TextField(controller: _priceController, decoration: const InputDecoration(labelText: 'Price')),
              TextField(controller: _imageController, decoration: const InputDecoration(labelText: 'Image URL')),
              TextField(controller: _descriptionController, decoration: const InputDecoration(labelText: 'Description')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                addProduct(productPost(
                  name: _nameController.text,
                  price: double.parse(_priceController.text),
                  image: _imageController.text,
                  description: _descriptionController.text, id: null,
                ));
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditProductDialog(productPost product) {
    final _nameController = TextEditingController(text: product.name);
    final _priceController = TextEditingController(text: product.price.toString());
    final _imageController = TextEditingController(text: product.image);
    final _descriptionController = TextEditingController(text: product.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Name')),
              TextField(controller: _priceController, decoration: const InputDecoration(labelText: 'Price')),
              TextField(controller: _imageController, decoration: const InputDecoration(labelText: 'Image URL')),
              TextField(controller: _descriptionController, decoration: const InputDecoration(labelText: 'Description')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                updateProduct(productPost(
                  id: product.id,
                  name: _nameController.text,
                  price: double.parse(_priceController.text),
                  image: _imageController.text,
                  description: _descriptionController.text,
                ));
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showSearchDialog() {
    final _idController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Search Product'),
          content: TextField(controller: _idController, decoration: const InputDecoration(labelText: 'Product ID')),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                searchProduct(int.parse(_idController.text));
                Navigator.pop(context);
              },
              child: const Text('Search'),
            ),
          ],
        );
      },
    );
  }
}
