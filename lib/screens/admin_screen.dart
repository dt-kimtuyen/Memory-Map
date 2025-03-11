import 'package:doanthikimtuyenn_sunflower/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  Future<void> _handleLogout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        backgroundColor: Colors.deepPurple,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _handleLogout(context),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Hình Avatar của Admin
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/avataaa.jpg'), // Đường dẫn đến ảnh của bạn
            ),
            const SizedBox(height: 20),
            Text(
              'Welcome, Admin!',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Chào mừng bạn đã đến với trang chủ Admin!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Chúc bạn làm việc hiệu quả và thành công!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green.shade600,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 30),

            // GridView tạo 4 hình vuông với các mục và biểu tượng khác nhau
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Số lượng cột là 2
                crossAxisSpacing: 20.0, // Khoảng cách giữa các hình vuông
                mainAxisSpacing: 20.0, // Khoảng cách dọc giữa các hình vuông
                childAspectRatio: 1.2, // Giảm tỷ lệ để các hình vuông nhỏ hơn
              ),
              itemCount: 4, // Số lượng hình vuông
              itemBuilder: (context, index) {
                // Các mục cài đặt với tên và biểu tượng khác nhau
                List<Map<String, dynamic>> settings = [
                  {
                    'icon': Icons.settings,
                    'title': 'Cài đặt tài khoản',
                    'color': Colors.blue.shade50,
                  },
                  {
                    'icon': Icons.notifications,
                    'title': 'Thông báo',
                    'color': Colors.orange.shade50,
                  },
                  {
                    'icon': Icons.lock,
                    'title': 'Bảo mật',
                    'color': Colors.green.shade50,
                  },
                  {
                    'icon': Icons.help,
                    'title': 'Hỗ trợ',
                    'color': Colors.purple.shade50,
                  },
                ];

                var setting = settings[index];

                return Container(
                  decoration: BoxDecoration(
                    color: setting['color'], // Màu sắc riêng cho từng mục
                    borderRadius: BorderRadius.circular(12), // Bo tròn các góc
                    boxShadow: [
                      BoxShadow(
                        color: setting['color']!.withOpacity(0.3),
                        blurRadius: 6,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        setting['icon'], // Biểu tượng cho mục
                        size: 30, // Kích thước biểu tượng
                        color: Colors.deepPurple.shade700,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        setting['title'], // Tên mục cài đặt
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14, // Kích thước chữ
                          fontWeight: FontWeight.w600,
                          color: Colors.deepPurple.shade700,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 30),

            // Nút Logout
            ElevatedButton(
              onPressed: () => _handleLogout(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple.shade200, // Màu tím nhạt
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
