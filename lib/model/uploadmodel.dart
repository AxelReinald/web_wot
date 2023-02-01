// import 'dart:ffi';
import 'dart:typed_data';

// import 'dart:typed_data';

class File_Data_Model {
  final String name;
  final String mime;
  final Uint8List bytes;
  final int sizes;
  final String url;
  File_Data_Model({
    required this.name,
    required this.mime,
    required this.bytes,
    required this.url,
    required this.sizes,
  });
  String get size {
    final kb = sizes / 1024;
    final mb = kb / 1024;
    return mb > 1
        ? '${mb.toStringAsFixed(2)} MB'
        : '${kb.toStringAsFixed(2)} KB';
  }
}
