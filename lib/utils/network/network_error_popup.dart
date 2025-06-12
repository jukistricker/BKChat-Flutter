import 'package:flutter/material.dart';

class NetworkErrorPopup extends StatelessWidget {
  final VoidCallback? onClose;

  const NetworkErrorPopup({super.key, this.onClose});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 342,
        height: 177,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Close
            Positioned(
              top: 11,
              right: 14,
              child: GestureDetector(
                onTap: onClose ?? () => Navigator.of(context).pop(),
                child: Text(
                  'x',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
            // Message
            Positioned(
              top: 53,
              left: 34,
              right: 18,
              child: Text(
                'Kết nối mạng không ổn định, bạn vui lòng thử lại sau',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            // OK button
            Positioned(
              top: 118,
              left: 114,
              child: GestureDetector(
                onTap: onClose,
                child: Container(
                  width: 113,
                  height: 37,
                  decoration: BoxDecoration(
                    color: Color(0xff1c7fd9),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Ok',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
