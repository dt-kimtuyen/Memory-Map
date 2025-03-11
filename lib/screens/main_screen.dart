import 'package:doanthikimtuyenn_sunflower/screens/DatingScreen.dart';
import 'package:doanthikimtuyenn_sunflower/screens/VideoListScreen.dart';
import 'package:doanthikimtuyenn_sunflower/screens/account_screen.dart';
import 'package:doanthikimtuyenn_sunflower/screens/admin_screen.dart';
import 'package:doanthikimtuyenn_sunflower/screens/home_screen.dart';
import 'package:doanthikimtuyenn_sunflower/screens/login_screen.dart';
import 'package:doanthikimtuyenn_sunflower/screens/market_screen.dart';
import 'package:doanthikimtuyenn_sunflower/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

 // Import LoginScreen để điều hướng khi đăng xuất

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Hàm đăng xuất
  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token'); // Xóa token khỏi SharedPreferences

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()), // Điều hướng về màn hình đăng nhập
    );
  }

  // Hàm lấy màn hình hiện tại
  Widget _getCurrentScreen() {
    switch (_currentIndex) {
      case 0:
        return HomeScreen(); // Trang Home
      case 1:
        return const VideoListScreen(); // Danh sách video trực tiếp
      case 2:
        return const AccountScreen(); // Trang Account
      case 3:
        return const MarketScreen(); // Trang Market
      case 4:
        return const SettingsScreen(); // Trang Dating
      case 5:
        return const AdminScreen();
      case 6:
        return const DatingScreen();
      default:
        return HomeScreen(); // Default screen
    }
  }

  // Custom function để thay đổi màu biểu tượng active/inactive
  Color _getIconColor(int index) {
    return _currentIndex == index ? Colors.blue : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout, // Khi nhấn nút logout
          ),
        ],
      ),
      body: _getCurrentScreen(), // Gọi hàm để hiển thị màn hình tương ứng
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Cập nhật chỉ số khi chuyển tab
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: _getIconColor(0)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library, color: _getIconColor(1)),
            label: 'Videos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: _getIconColor(2)),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: _getIconColor(3)),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: _getIconColor(4)),
            label: 'Setting',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: _getIconColor(5)),
            label: 'Dating',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        elevation: 10,
      ),
    );
  }
}
