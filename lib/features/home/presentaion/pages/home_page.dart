import 'package:flutter/material.dart';
import 'package:untitled/features/chat/presentation/pages/chat_page.dart';


import '../../../../core/services/friend_service.dart';

class HomePage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (_) => const HomePage());

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Map<String, dynamic>>> _friendsFuture;

  @override
  void initState() {
    super.initState();
    _friendsFuture = FriendService.fetchFriends();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _friendsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Không có bạn bè nào.'));
            }

            final friends = snapshot.data!;

            return Stack(
              children: [
                Positioned(
                  top: 10,
                  right: 16,
                  child: Image.asset('assets/images/logo.png', width: 43, height: 42),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: const Text(
                    'Bkav Chat',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xff146ae0)),
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 20,
                  right: 20,
                  child: Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xfff3f6f6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.search, color: Colors.black54),
                        SizedBox(width: 8),
                        Expanded(child: Text('Tìm kiếm', style: TextStyle(fontSize: 14))),
                        Icon(Icons.close),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 140,
                  left: 20,
                  child: const Text(
                    'Danh sách bạn bè',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                Positioned(
                  top: 180,
                  left: 20,
                  right: 20,
                  bottom: 0,
                  child: ListView.separated(
                    itemCount: friends.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final friend = friends[index];
                      return FriendItem(
                        name: friend['FullName'] ?? '',
                        imageUrl: friend['Avatar'] != null
                            ? "${friend['Avatar']}"
                            : null,
                        isOnline: friend['isOnline'] == true,
                        onTap: () {
                          Navigator.push(context, ChatPage.route());
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class FriendItem extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final bool isOnline;
  final VoidCallback? onTap;

  const FriendItem({
    required this.name,
    this.imageUrl,
    this.isOnline = false,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
            child: imageUrl == null ? const Icon(Icons.person) : null,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(fontSize: 18),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Icon(
            Icons.circle,
            color: isOnline ? Colors.green : Colors.grey,
            size: 10,
          ),
        ],
      ),
    );
  }
}
