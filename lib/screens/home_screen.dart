import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Model fbPost
class fbPost {
  final int id;
  final String username;
  final String timeAgo;
  String content;
  final String? imageUrl;
  int likes;
  final int comments;
  final int shares;
  final bool isVerified;
  final String avatarUrl;
  final String? audience;
  bool isLiked;

  fbPost({
    required this.id,
    required this.username,
    required this.timeAgo,
    required this.content,
    this.imageUrl,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.isVerified,
    required this.avatarUrl,
    this.audience,
    this.isLiked = false,
  });

  factory fbPost.fromJson(Map<String, dynamic> json) {
    return fbPost(
      id: json['id'],
      username: json['username'],
      timeAgo: json['timeAgo'],
      content: json['content'],
      imageUrl: json['imageUrl'],
      likes: json['likes'],
      comments: json['comments'],
      shares: json['shares'],
      isVerified: json['isVerified'],
      avatarUrl: json['avatarUrl'],
      audience: json['audience'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'timeAgo': timeAgo,
      'content': content,
      'imageUrl': imageUrl,
      'likes': likes,
      'comments': comments,
      'shares': shares,
      'isVerified': isVerified,
      'avatarUrl': avatarUrl,
      'audience': audience,
    };
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<fbPost> posts = [];
  final String baseUrl = 'https://othertealapple6.conveyor.cloud/api/Post';

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  // Fetch posts
  Future<void> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          posts = data.map((post) => fbPost.fromJson(post)).toList();
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Add post
  Future<void> addPost(fbPost newPost) async {
    try {
      await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(newPost.toJson()),
      );
      fetchPosts();
    } catch (e) {
      print('Error: $e');
    }
  }

  // Delete post
  Future<void> deletePost(int id) async {
    try {
      await http.delete(Uri.parse('$baseUrl/$id'));
      fetchPosts();
    } catch (e) {
      print('Error: $e');
    }
  }

  // Update post
  Future<void> updatePost(int id, fbPost updatedPost) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updatedPost.toJson()),
      );

      if (response.statusCode == 200) {
        // Gọi hàm fetchPosts để tải lại dữ liệu
        await fetchPosts();
        setState(() {
          print("Bài viết đã được cập nhật và reload thành công!");
        });
      } else {
        print('Failed to update post: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating post: $e');
    }
  }



  // Show dialog for add/edit
  void _showPostDialog({fbPost? post}) {
    final usernameController = TextEditingController(text: post?.username ?? '');
    final timeAgoController = TextEditingController(text: post?.timeAgo ?? '');
    final contentController = TextEditingController(text: post?.content ?? '');
    final imageUrlController = TextEditingController(text: post?.imageUrl ?? '');
    final avatarUrlController = TextEditingController(text: post?.avatarUrl ?? '');
    bool isVerified = post?.isVerified ?? false;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    post == null ? 'Thêm bài viết mới' : 'Chỉnh sửa bài viết',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInputField(
                    controller: usernameController,
                    label: 'Tên người dùng',
                    icon: Icons.person,
                  ),
                  _buildInputField(
                    controller: timeAgoController,
                    label: 'Thời gian',
                    icon: Icons.access_time,
                  ),
                  _buildInputField(
                    controller: contentController,
                    label: 'Nội dung bài viết',
                    icon: Icons.article,
                    maxLines: 3,
                  ),
                  _buildInputField(
                    controller: imageUrlController,
                    label: 'URL hình ảnh',
                    icon: Icons.image,
                  ),
                  _buildInputField(
                    controller: avatarUrlController,
                    label: 'Avatar URL',
                    icon: Icons.person_pin,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tick xanh (Verified):',
                        style: TextStyle(fontSize: 16),
                      ),
                      Switch(
                        value: isVerified,
                        onChanged: (value) {
                          isVerified = value;
                          // SetState để cập nhật switch (nếu cần)
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Hủy'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () async  {
                          if (usernameController.text.isNotEmpty &&
                              contentController.text.isNotEmpty) {
                            if (post == null) {
                              // Thêm bài viết mới
                              final newPost = fbPost(
                                id: 0,
                                username: usernameController.text,
                                timeAgo: timeAgoController.text,
                                content: contentController.text,
                                imageUrl: imageUrlController.text.isNotEmpty
                                    ? imageUrlController.text
                                    : null,
                                likes: 0,
                                comments: 0,
                                shares: 0,
                                isVerified: isVerified, // Gán trạng thái tick xanh
                                avatarUrl: avatarUrlController.text.isNotEmpty
                                    ? avatarUrlController.text
                                    : '',
                              );
                              addPost(newPost);
                            } else {
                              // Chỉnh sửa bài viết
                              final updatedPost = fbPost(
                                id: post.id,
                                username: usernameController.text,
                                timeAgo: timeAgoController.text,
                                content: contentController.text,
                                imageUrl: imageUrlController.text.isNotEmpty
                                    ? imageUrlController.text
                                    : null,
                                likes: post.likes,
                                comments: post.comments,
                                shares: post.shares,
                                isVerified: isVerified,
                                avatarUrl: avatarUrlController.text.isNotEmpty
                                    ? avatarUrlController.text
                                    : '',
                              );
                              updatePost(post.id, updatedPost);
                            }
                            await fetchPosts();
                            setState(() {});
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Vui lòng điền đầy đủ thông tin'),
                              ),
                            );
                          }
                        },
                        child: const Text('Lưu'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: SafeArea( // Đảm bảo AppBar không bị sát viền trên
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 12, right: 8),
            child: Row(
              children: [
                // Chữ "facebook" sát lề trái
                const Text(
                  'facebook',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                // Icon Search
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.black54),
                  onPressed: () {},
                ),
                // Icon Tin nhắn với thông báo
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.message, color: Colors.black54),
                      onPressed: () {},
                    ),
                    Positioned(
                      right: 4,
                      top: 4,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Text(
                          '3',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Ô trạng thái
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                      'https://randomuser.me/api/portraits/men/1.jpg'),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                    ),
                    child: const Text(
                      "Bạn đang nghĩ gì?",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Thanh tính năng (Live, Ảnh, Check-in)
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFeatureButton(Icons.live_tv, "Live", Colors.red),
                const VerticalDivider(width: 1),
                _buildFeatureButton(Icons.photo_library, "Ảnh", Colors.green),
                const VerticalDivider(width: 1),
                _buildFeatureButton(Icons.location_on, "Check in", Colors.pink),
              ],
            ),
          ),
          const Divider(height: 1),

          // Danh sách bài viết
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return _buildPostCard(post);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showPostDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

// Nút tính năng (Live, Ảnh, Check-in)
  Widget _buildFeatureButton(IconData icon, String label, Color color) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: color),
      label: Text(label, style: const TextStyle(color: Colors.black54)),
    );
  }

// Xây dựng từng bài viết
  Widget _buildPostCard(fbPost post) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(post.avatarUrl),
            ),
            title: Row(
              children: [
                Text(post.username),
                if (post.isVerified)
                  const Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Icon(Icons.verified, size: 16, color: Colors.blue),
                  ),
              ],
            ),
            subtitle: Text(post.timeAgo),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') {
                  _showPostDialog(post: post);
                } else if (value == 'delete') {
                  deletePost(post.id);
                }
              },
              itemBuilder: (context) =>
              [
                const PopupMenuItem(value: 'edit', child: Text('Chỉnh sửa')),
                const PopupMenuItem(value: 'delete', child: Text('Xóa')),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(post.content),
          ),
          if (post.imageUrl != null)
            Image.network(
              post.imageUrl!,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ButtonBar(
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.thumb_up),
                label: Text('${post.likes} Thích'),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.comment),
                label: const Text('Bình luận'),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.share),
                label: const Text('Chia sẻ'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}