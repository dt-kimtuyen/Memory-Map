import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    // Màu sắc cho light/dark mode
    final bgColor = isDarkMode ? Colors.grey[900] : Colors.white;
    final appBarColor = isDarkMode ? Colors.black : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final subTextColor = isDarkMode ? Colors.grey[400] : Colors.grey[700];
    final sectionBg = isDarkMode ? Colors.grey[850] : Colors.grey[200];
    final bannerColor = isDarkMode ? Colors.grey[800] : Colors.grey[300];
    final avatarBg = isDarkMode ? Colors.grey[700] : Colors.grey[400];

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0,
        title: Text(
          "Bi Bon",
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.color_lens,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode;
              });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.add_a_photo,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: () {
              // Handle "Add photo" action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Banner + Avatar
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Banner
                Container(
                  height: 300,
                  color: bannerColor,
                  child: Image.network(
                    "https://imagizer.imageshack.com/img921/9628/VIaL8H.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                // Nút chỉnh sửa ảnh bìa
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      // Chỉnh sửa ảnh bìa
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode ? Colors.grey[700] : Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                        side: BorderSide(
                          color: isDarkMode ? Colors.grey[500]! : Colors.grey[400]!,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.camera_alt, size: 16, color: isDarkMode ? Colors.white : Colors.black),
                        const SizedBox(width: 4),
                        Text("Chỉnh sửa ảnh bìa", style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
                      ],
                    ),
                  ),
                ),
                // Avatar ở giữa, chồng lên banner
                Positioned(
                  bottom: -60, // Để avatar tràn xuống dưới banner 1 phần
                  left: 0,
                  right: 0,
                  child: Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 56,
                        backgroundColor: avatarBg,
                        backgroundImage: const NetworkImage(
                          "https://imagizer.imageshack.com/img921/3072/rqkhIb.jpg",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Khoảng trống để nội dung không đè lên avatar
            const SizedBox(height: 80),

            // Tên và nút
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "KIM TUYEN",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "247 người bạn",
                    style: TextStyle(
                      color: subTextColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Handle "Thêm vào tin"
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text("Thêm vào tin"),
                      ),
                      const SizedBox(width: 10),
                      OutlinedButton(
                        onPressed: () {
                          // Handle "Chỉnh sửa trang cá nhân"
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: isDarkMode ? Colors.grey[500]! : Colors.grey[400]!),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          "Chỉnh sửa trang cá nhân",
                          style: TextStyle(color: textColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Giới thiệu
            Container(
              color: sectionBg,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Giới thiệu",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildInfoRow(Icons.home, "Sống tại Thành phố Hồ Chí Minh", textColor, subTextColor),
                  const SizedBox(height: 10),
                  _buildInfoRow(Icons.favorite, "Độc thân", textColor, subTextColor),
                  const SizedBox(height: 10),
                  _buildInfoRow(Icons.work, "Làm việc tại Công ty ABC", textColor, subTextColor),
                  const SizedBox(height: 10),
                  _buildInfoRow(Icons.school, "Học tại Đại học XYZ", textColor, subTextColor),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      // Chỉnh sửa chi tiết
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: isDarkMode ? Colors.grey[500]! : Colors.grey[400]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text("Chỉnh sửa chi tiết", style: TextStyle(color: textColor)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Bạn bè
            Container(
              color: sectionBg,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Bạn bè",
                        style: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          // Xem tất cả bạn bè
                        },
                        child: const Text("Xem tất cả bạn bè", style: TextStyle(color: Colors.blue)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "247 người bạn",
                    style: TextStyle(color: subTextColor, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  // Lưới bạn bè
                  _buildFriendGrid(isDarkMode),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Ảnh
            Container(
              color: sectionBg,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Ảnh",
                        style: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          // Xem tất cả ảnh
                        },
                        child: const Text("Xem tất cả ảnh", style: TextStyle(color: Colors.blue)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Lưới ảnh
                  _buildPhotoGrid(),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Bài viết
            Container(
              color: sectionBg,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bài viết",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      hintText: "Bạn đang nghĩ gì?",
                      hintStyle: TextStyle(color: isDarkMode ? Colors.grey : Colors.black54),
                      filled: true,
                      fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(
                        Icons.edit,
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Handle "Post" action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text("Đăng bài"),
                  ),
                  const SizedBox(height: 20),

                  // Danh sách bài viết (Ví dụ 2 bài)
                  _buildPostItem(
                    isDarkMode,
                    avatarUrl: "https://imagizer.imageshack.com/img923/2452/zifFKH.jpg",
                    name: "Ngọc Lan",
                    time: "2 giờ trước",
                    content: "Hôm nay trời thật đẹp!",
                    imageUrl: "https://imagizer.imageshack.com/img923/8568/6LwtUa.jpg",
                  ),
                  const SizedBox(height: 20),
                  _buildPostItem(
                    isDarkMode,
                    avatarUrl: "https://imagizer.imageshack.com/img921/3072/rqkhIb.jpg",
                    name: "Bi Bon",
                    time: "Hôm qua",
                    content: "Cuộc sống thật tuyệt!",
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Color textColor, Color? subTextColor) {
    return Row(
      children: [
        Icon(icon, color: subTextColor),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(color: textColor),
        ),
      ],
    );
  }

  Widget _buildFriendGrid(bool isDarkMode) {
    final friendList = [
      {"name": "Ngọc Lan", "img": "https://imagizer.imageshack.com/img924/4231/JnFicn.jpg"},
      {"name": "Trung Hiếu", "img": "https://imagizer.imageshack.com/img923/332/1abR4H.png"},
      {"name": "Minh Thư", "img": "https://imagizer.imageshack.com/img921/3021/8uZZY2.jpg"},
      {"name": "Hải Nam", "img": "https://imagizer.imageshack.com/img921/6488/i2Hb4U.jpg"},
      {"name": "Lan Hương", "img": "https://imagizer.imageshack.com/img921/8417/svxO7y.jpg"},
      {"name": "Phương Anh", "img": "https://imagizer.imageshack.com/img923/3992/22mL29.jpg"},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: friendList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        final friend = friendList[index];
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: SizedBox(
                width: double.infinity,
                height: 100,
                child: Image.network(
                  friend["img"]!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              friend["name"]!,
              style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }

  Widget _buildPhotoGrid() {
    final photos = [
      "https://imagizer.imageshack.com/img922/8637/NN4aPj.jpg",
      "https://imagizer.imageshack.com/img923/528/iJy0X5.jpg",
      "https://imagizer.imageshack.com/img923/9781/26phSy.jpg",
      "https://imagizer.imageshack.com/img921/8417/svxO7y.jpg",
      "https://imagizer.imageshack.com/img921/6488/i2Hb4U.jpg",
      "https://imagizer.imageshack.com/img921/2453/J7PICR.jpg",
      "https://imagizer.imageshack.com/img921/3021/8uZZY2.jpg",
      "https://imagizer.imageshack.com/img923/3992/22mL29.jpg",
      "https://imagizer.imageshack.com/img921/2711/JXSt41.jpg",
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: photos.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.network(photos[index], fit: BoxFit.cover),
        );
      },
    );
  }

  Widget _buildPostItem(
      bool isDarkMode, {
        required String avatarUrl,
        required String name,
        required String time,
        required String content,
        String? imageUrl,
      }) {
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final subTextColor = isDarkMode ? Colors.grey[400] : Colors.grey[600];
    final bgColor = isDarkMode ? Colors.grey[800] : Colors.white;

    return Container(
      color: bgColor,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(avatarUrl),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 14, color: subTextColor),
                        const SizedBox(width: 4),
                        Text(time, style: TextStyle(color: subTextColor, fontSize: 12)),
                      ],
                    )
                  ],
                ),
              ),
              Icon(Icons.more_horiz, color: subTextColor),
            ],
          ),
          const SizedBox(height: 10),
          Text(content, style: TextStyle(color: textColor, fontSize: 16)),
          if (imageUrl != null) ...[
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.thumb_up_alt_outlined, color: subTextColor, size: 20),
              const SizedBox(width: 8),
              Text("Thích", style: TextStyle(color: subTextColor)),
              const SizedBox(width: 20),
              Icon(Icons.comment_outlined, color: subTextColor, size: 20),
              const SizedBox(width: 8),
              Text("Bình luận", style: TextStyle(color: subTextColor)),
              const SizedBox(width: 20),
              Icon(Icons.reply_outlined, color: subTextColor, size: 20),
              const SizedBox(width: 8),
              Text("Chia sẻ", style: TextStyle(color: subTextColor)),
            ],
          ),
        ],
      ),
    );
  }
}