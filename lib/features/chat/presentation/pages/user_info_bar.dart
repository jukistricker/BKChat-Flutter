import 'package:flutter/material.dart';

class UserInfoBar extends StatelessWidget {
  const UserInfoBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 59,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(Icons.arrow_back),
            ),
          ),
          const SizedBox(width: 4),
          Stack(
            children: [
              Container(
                width: 50,
                height: 50,
                margin: const EdgeInsets.only(left: 8),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/image34.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Positioned(
                bottom: 6,
                right: 4,
                child: CircleAvatar(
                  backgroundColor: Color(0xFF2BEF83),
                  radius: 4,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Bạn B',
                style: TextStyle(
                  color: Color(0xFF000E08),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Trực tuyến',
                style: TextStyle(
                  color: Color(0xFF797C7B),
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
