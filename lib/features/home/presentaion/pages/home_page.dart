import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/features/chat/presentation/pages/chat_page.dart';

class HomePage extends StatelessWidget {
  static route() => MaterialPageRoute(
    builder: (context) => const HomePage(),
  );
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Logo ở góc phải
            Positioned(
              top: 10,
              right: 16,
              child: Image.asset('assets/images/logo.png', width: 43, height: 42),
            ),

            // Tiêu đề
            Positioned(
              top: 20,
              left: 20,
              child: Text(
                'Bkav Chat',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff146ae0),
                ),
              ),
            ),

            // Ô tìm kiếm
            Positioned(
              top: 80,
              left: 20,
              right: 20,
              child: Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Color(0xfff3f6f6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.black54),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Tìm kiếm',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Icon(Icons.close),
                  ],
                ),
              ),
            ),

            // Tiêu đề danh sách
            Positioned(
              top: 140,
              left: 20,
              child: Text(
                'Danh sách bạn bè',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),

            // Danh sách bạn bè
            Positioned(
              top: 180,
              left: 20,
              right: 20,
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  FriendItem(name: 'Bạn A', imagePath: 'assets/images/image34.png'),
                  SizedBox(height: 10),
                  FriendItem(name: 'Bạn B', imagePath: 'assets/images/image34.png'),
                  SizedBox(height: 10),
                  FriendItem(name: 'Bạn C', imagePath: 'assets/images/image34.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FriendItem extends StatelessWidget {
  final String name;
  final String imagePath;
  final VoidCallback? onTap;

  const FriendItem({
    required this.name,
    required this.imagePath,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, ChatPage.route());
      },
      child: Row(
        children: [
          Image.asset(imagePath, width: 50, height: 50),
          SizedBox(width: 20),
          Expanded(
            child: Text(
              name,
              style: TextStyle(fontSize: 20),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

