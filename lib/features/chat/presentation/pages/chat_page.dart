import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Message {
  final bool isMe;
  final String text;
  final String time;
  final DateTime timestamp;
  final MessageType type;
  final bool isImage;
  final bool isFile;
  final String? imagePath;
  final String? filePath;

  Message({
    required this.isMe,
    required this.text,
    required this.time,
    required this.timestamp,
    this.type = MessageType.text,
    this.isImage = false,
    this.isFile = false,
    this.imagePath,
    this.filePath,
  });
}


enum MessageType { text, voice, image }

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  static route() => MaterialPageRoute(
    builder: (context) => const ChatPage(),
  );

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  final List<Message> _messages = [
    Message(
      text: "You did your job well!",
      isMe: true,
      time: "09:25 AM",
      timestamp: DateTime(2023, 6, 3, 9, 25, 10),
    ),
    Message(
      text: "Khỏe không bạn ơi",
      isMe: false,
      time: "09:25 AM",
      timestamp: DateTime(2023, 6, 3, 9, 25, 30),
    ),
    Message(
      text: "Nhớ bạn lắm",
      isMe: false,
      time: "09:25 AM",
      timestamp: DateTime(2023, 6, 3, 9, 25, 50),
    ),
    Message(
      text: "0:15",
      isMe: true,
      time: "09:25 AM",
      timestamp: DateTime(2023, 6, 3, 9, 26, 5),
      type: MessageType.voice,
    ),
  ];

  void _handleSend() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final now = DateTime.now();
    setState(() {
      _messages.add(
        Message(
          text: text,
          isMe: true,
          time: "${now.hour}:${now.minute}",
          timestamp: now,
        ),
      );
    });
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ChatHeader(),
          const SizedBox(height: 8),
          const DateSeparator(date: "Hôm nay"),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final current = _messages[index];
                final previous = index > 0 ? _messages[index - 1] : null;

                final isSameUser = previous != null && previous.isMe == current.isMe;
                final isCloseInTime = previous != null &&
                    current.timestamp.difference(previous.timestamp).inSeconds < 60;

                final shouldMerge = isSameUser && isCloseInTime;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment:
                    current.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      if (!current.isMe && !shouldMerge)
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 16,
                              backgroundImage:
                              AssetImage('assets/images/image34.png'),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Bạn B',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      const SizedBox(height: 4),
                      _buildMessageBubble(current, isFirstInGroup: !shouldMerge),
                    ],
                  ),
                );
              },
            ),
          ),
          InputArea(
            controller: _messageController,
            onSend: _handleSendMessage,
            onFilePicked: (file) {
              setState(() {
                _messages.add(
                  Message(
                    isMe: true,
                    text: '📎 ${file.name}',
                    time: DateFormat.Hm().format(DateTime.now()),
                    timestamp: DateTime.now(),
                    isFile: true,
                    filePath: file.path!,
                  ),
                );
              });
            },
              onImagePicked: (image) {
                setState(() {
                  _messages.add(
                    Message(
                      isMe: true,
                      text: '', // ✅ để trống hoặc null
                      time: DateFormat.Hm().format(DateTime.now()),
                      timestamp: DateTime.now(),
                      isImage: true,
                      imagePath: image.path, // ✅ đường dẫn ảnh
                    ),
                  );
                });
              },
          ),

        ],
      ),
    );
  }

  void _handleSendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(
        Message(
          isMe: true,
          text: text,
          time: DateFormat.Hm().format(DateTime.now()),
          timestamp: DateTime.now(),
        ),
      );
      _messageController.clear();
    });
  }


  Widget _buildMessageBubble(Message message, {bool isFirstInGroup = true}) {
    if (message.isImage && message.imagePath != null) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            File(message.imagePath!),
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (message.isFile && message.filePath != null) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.attach_file, size: 20),
            const SizedBox(width: 8),
            Flexible(child: Text(message.text)),
          ],
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: message.isMe ? const Color(0xff20a090) : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(message.text),
      );
    }
  }

}

class ChatHeader extends StatelessWidget {
  const ChatHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
            ),
          ],
        ),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context); // hoặc hành động bạn muốn khi bấm nút
              },
            ),
            const SizedBox(width: 16),
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey[300],
              child: Image.asset('assets/images/image34.png'),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Bạn B", style: TextStyle(fontWeight: FontWeight.w500)),
                Text("Trực tuyến",
                    style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: Color(0xff797c7b))),
              ],
            ),
            const SizedBox(width: 4),
            const Icon(Icons.circle, color: Color(0xff2bef83), size: 8),
          ],
        ),

      ),
    );
  }

}

class DateSeparator extends StatelessWidget {
  final String date;
  const DateSeparator({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xfff8f8fb),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(date,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final Message message;
  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isVoice = message.type == MessageType.voice;

    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
        message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (!message.isMe)
            const Padding(
              padding: EdgeInsets.only(left: 8, bottom: 4),
              child: Text("Bạn B",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
            ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: isVoice
                ? const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
                : const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: message.isMe
                  ? const Color(0xff20a090)
                  : const Color(0xfff3f6f6),
              borderRadius: BorderRadius.circular(18),
            ),
            child: isVoice
                ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.play_arrow, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Container(
                  width: 100,
                  height: 2,
                  color: Colors.white.withOpacity(0.5),
                ),
                const SizedBox(width: 8),
                Text(message.text,
                    style: const TextStyle(color: Colors.white)),
              ],
            )
                : Text(
              message.text,
              style: TextStyle(
                fontSize: 12,
                color: message.isMe ? Colors.white : Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4, right: 4, left: 4),
            child: Text(
              message.time,
              style: const TextStyle(
                fontSize: 10,
                fontStyle: FontStyle.italic,
                color: Color(0xff797c7b),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InputArea extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final void Function(PlatformFile file)? onFilePicked;
  final void Function(XFile image)? onImagePicked;

  const InputArea({
    super.key,
    required this.controller,
    required this.onSend,
    this.onFilePicked,
    this.onImagePicked,
  });


  @override
  State<InputArea> createState() => _InputAreaState();
}

class _InputAreaState extends State<InputArea> {
  bool _showEmojiPicker = false;
  final ImagePicker _picker = ImagePicker();
  PlatformFile? _selectedFile;
  XFile? _selectedImage;
  // late FocusNode _focusNode;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _focusNode = FocusNode();
  //
  //   _focusNode.addListener(() {
  //     if (_focusNode.hasFocus && _showEmojiPicker) {
  //       setState(() {
  //         _showEmojiPicker = false;
  //       });
  //     }
  //   });
  // }
  //
  // @override
  // void dispose() {
  //   _focusNode.dispose();
  //   super.dispose();
  // }

  void _toggleEmojiPicker() {
    setState(() {
      _showEmojiPicker = !_showEmojiPicker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.emoji_emotions_outlined, size: 24),
                onPressed: _toggleEmojiPicker,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xfff3f6f6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: 40,
                  child: TextField(
                    // focusNode: _focusNode,
                    controller: widget.controller,
                    onTap: () {
                      if (_showEmojiPicker) {
                        setState(() {
                          _showEmojiPicker = false;
                        });
                      }
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Nhập tin nhắn",
                      hintStyle: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: Color(0xff797c7b),
                      ),
                    ),
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Color(0xff20a090), size: 24),
                onPressed: () {
                  if (_selectedImage != null) {
                    widget.onImagePicked?.call(_selectedImage!);
                    setState(() {
                      _selectedImage = null;
                    });
                  } else if (_selectedFile != null) {
                    widget.onFilePicked?.call(_selectedFile!);
                    setState(() {
                      _selectedFile = null;
                    });
                  } else if (widget.controller.text.trim().isNotEmpty) {
                    widget.onSend();
                  }
                },
              ),

              IconButton(
                icon: const Icon(Icons.attach_file, size: 20),
                onPressed: () async {
                  if (_showEmojiPicker) {
                    setState(() {
                      _showEmojiPicker = false;
                    });
                  }
                  final result = await FilePicker.platform.pickFiles();
                  if (result != null && result.files.isNotEmpty) {
                    setState(() {
                      _selectedFile = result.files.first;
                      _selectedImage = null; // reset ảnh nếu có
                    });
                    // KHÔNG gửi ở đây
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.image_outlined, size: 20),
                onPressed: () async {
                  if (_showEmojiPicker) {
                    setState(() {
                      _showEmojiPicker = false;
                    });
                  }
                  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      _selectedImage = image;
                      _selectedFile = null; // reset file nếu có
                    });
                    // KHÔNG gửi ở đây
                  }
                },
              ),
            ],
          ),
        ),
        // TODO: Show emoji picker here if _showEmojiPicker is true
        if (_showEmojiPicker)
          SizedBox(
            height: 250,
            child: EmojiPicker(
              onEmojiSelected: (category, emoji) {
                setState(() {
                  widget.controller.text += emoji.emoji;
                });
              },
              config: const Config(
                emojiViewConfig: EmojiViewConfig(
                  columns: 7,
                  emojiSizeMax: 32,
                  // emojiPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                ),
              ),
            ),
          ),


        if (_selectedFile != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                const Icon(Icons.attach_file, size: 16),
                const SizedBox(width: 4),
                Expanded(child: Text(_selectedFile!.name, overflow: TextOverflow.ellipsis)),
                IconButton(
                  icon: const Icon(Icons.close, size: 16),
                  onPressed: () {
                    setState(() {
                      _selectedFile = null;
                    });
                  },
                ),
              ],
            ),
          ),

        if (_selectedImage != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(_selectedImage!.path),
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 16, color: Colors.black54),
                  onPressed: () {
                    setState(() {
                      _selectedImage = null;
                    });
                  },
                ),
              ],
            ),
          ),

      ],
    );
  }



}


