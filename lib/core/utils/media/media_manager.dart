import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

enum MediaType { image, video, audio, document }

class MediaManager {
  static const _baseDir = 'app_data';

  /// Lưu file media vào thư mục riêng theo loại
  static Future<String> saveMedia(File file, MediaType type) async {
    final appDir = await getApplicationDocumentsDirectory();
    final mediaDir = Directory(p.join(appDir.path, _baseDir, _subDirFor(type)));

    if (!await mediaDir.exists()) {
      await mediaDir.create(recursive: true);
    }

    final fileName = '${DateTime.now().millisecondsSinceEpoch}${p.extension(file.path)}';
    final savedPath = p.join(mediaDir.path, fileName);

    final savedFile = await file.copy(savedPath);
    return savedFile.path;
  }

  /// Tạo tên thư mục con theo loại media
  static String _subDirFor(MediaType type) {
    switch (type) {
      case MediaType.image:
        return 'images';
      case MediaType.video:
        return 'videos';
      case MediaType.audio:
        return 'audios';
      case MediaType.document:
        return 'documents';
    }
  }
}
