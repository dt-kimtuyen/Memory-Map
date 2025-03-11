import 'package:flutter/material.dart';

class User {
  final String name;
  final String age;
  final String image;
  final String description;
  final String location;
  final List<String> interests;
  final String job;
  final String education;

  User({
    required this.name,
    required this.age,
    required this.image,
    required this.description,
    required this.location,
    required this.interests,
    required this.job,
    required this.education,
  });
}

class DatingScreen extends StatefulWidget {
  const DatingScreen({super.key});

  @override
  _DatingScreenState createState() => _DatingScreenState();
}

class _DatingScreenState extends State<DatingScreen> {
  final List<User> _users = [
    User(
      name: 'Ngọc Trinh',
      age: '23',
      image: 'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e',
      description: 'Yêu động vật và thích nấu ăn 🐱🍳\nTìm một người có cùng sở thích để chia sẻ.',
      location: 'Đà Nẵng',
      interests: ['Nấu ăn', 'Du lịch', 'Yoga', 'Nhiếp ảnh'],
      job: 'Marketing Manager tại ABC Corp',
      education: 'Đại học Ngoại thương',
    ),
    User(
      name: 'Thu Hương',
      age: '25',
      image: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb',
      description: 'Coffee lover ☕\nThích khám phá những quán cafe mới\nYêu thiên nhiên và âm nhạc 🎵',
      location: 'Hà Nội',
      interests: ['Coffee', 'Âm nhạc', 'Du lịch', 'Đọc sách'],
      job: 'Giáo viên tiếng Anh',
      education: 'Đại học Sư phạm Hà Nội',
    ),
    User(
      name: 'Minh Anh',
      age: '24',
      image: 'https://images.unsplash.com/photo-1560535733-540e0b0068b9',
      description: 'Thích đi phượt và khám phá những địa điểm mới 🏔️\nMong muốn tìm người bạn đồng hành',
      location: 'Sài Gòn',
      interests: ['Phượt', 'Nhiếp ảnh', 'Thể thao', 'Ẩm thực'],
      job: 'Travel Blogger',
      education: 'Đại học RMIT',
    ),
    User(
      name: 'Thanh Thảo',
      age: '22',
      image: 'https://images.unsplash.com/photo-1524638431109-93d95c968f03',
      description: '🎨 Họa sĩ tự do\nYêu nghệ thuật và màu sắc\nThích vẽ tranh và chụp ảnh',
      location: 'Hà Nội',
      interests: ['Nghệ thuật', 'Nhiếp ảnh', 'Thời trang', 'Âm nhạc'],
      job: 'Freelance Artist',
      education: 'Đại học Mỹ thuật Việt Nam',
    ),
    User(
      name: 'Mai Linh',
      age: '26',
      image: 'https://images.unsplash.com/photo-1464863979621-258859e62245',
      description: '👩‍💻 Tech enthusiast\nThích công nghệ và sáng tạo\nMong muốn tìm người có cùng đam mê',
      location: 'Sài Gòn',
      interests: ['Công nghệ', 'Startup', 'Đọc sách', 'Gym'],
      job: 'Product Manager tại Tech Corp',
      education: 'Thạc sĩ CNTT - ĐH Bách Khoa',
    ),
  ];

  int _currentIndex = 0;

  void _nextUser() {
    setState(() {
      if (_currentIndex < _users.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
    });
  }

  void _removeUser() {
    setState(() {
      _users.removeAt(_currentIndex);
      if (_currentIndex >= _users.length) {
        _currentIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Dating',
          style: TextStyle(
            color: Colors.pink[400],
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.pink[400]),
            onPressed: () {},
          ),
        ],
      ),
      body: _users.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sentiment_dissatisfied,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Không còn người dùng nào.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      )
          : Container(
        alignment: Alignment.center,
        child: Stack(
          children: _users.map((user) {
            var index = _users.indexOf(user);
            return index == _currentIndex
                ? Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.7,
              margin: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(user.image),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.transparent,
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${user.name}, ${user.age}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.verified,
                              color: Colors.blue[400],
                              size: 20,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.pink[100],
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              user.location,
                              style: TextStyle(
                                color: Colors.pink[100],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          user.description,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: user.interests.map((interest) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                interest,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildActionButton(
                              Icons.close,
                              Colors.red,
                                  () {
                                _removeUser();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Bạn đã bỏ qua ${user.name}!',
                                    ),
                                  ),
                                );
                              },
                            ),
                            _buildActionButton(
                              Icons.star,
                              Colors.blue,
                                  () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Bạn đã super like ${user.name}!',
                                    ),
                                  ),
                                );
                                _nextUser();
                              },
                            ),
                            _buildActionButton(
                              Icons.favorite,
                              Colors.green,
                                  () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Bạn đã thích ${user.name}!',
                                    ),
                                  ),
                                );
                                _nextUser();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
                : Container();
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildActionButton(
      IconData icon,
      Color color,
      VoidCallback onPressed,
      ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: color, size: 30),
        onPressed: onPressed,
      ),
    );
  }
}