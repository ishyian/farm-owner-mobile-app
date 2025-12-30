import 'dart:io';

extension FileExtention on File {
  bool isImage() {
    final ext = path.split(".").last.toLowerCase();
    return ['jpg', 'jpeg', 'png', 'gif'].contains(ext);
  }

  bool isVideo() {
    final ext = path.split(".").last.toLowerCase();
    return ['mp4', 'mov', 'avi'].contains(ext);
  }

  bool isAudio() {
    final ext = path.split(".").last.toLowerCase();
    return ['mp3', 'wav', 'aac'].contains(ext);
  }

  bool isPdf() {
    final ext = path.split(".").last.toLowerCase();
    return ext == 'pdf';
  }

  bool isDocument() {
    final ext = path.split(".").last.toLowerCase();
    return ['txt', 'doc', 'docx', 'odt', 'pdf'].contains(ext);
  }

  String getFileName() {
    return path.split("/").last;
  }
}
