import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/r.dart';
import 'package:weqaa/utils/extensions/num.dart';
import 'package:weqaa/utils/helpers/locator.dart';
import 'package:weqaa/utils/helpers/nav_helper.dart';

class DocumentPickerBottomSheet extends StatefulWidget {
  const DocumentPickerBottomSheet(
      {super.key, required this.onPickedFile, required this.isMedia});

  final Function(List<File> file) onPickedFile;
  final bool isMedia;

  static Future show({
    required Function(List<File> file) onPickedFile,
    bool isMedia = false,
  }) async {
    showModalBottomSheet(
      context: locator<NavHelper>().navigatorKey.currentContext!,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SizedBox(
            child: DocumentPickerBottomSheet(
          onPickedFile: onPickedFile,
          isMedia: isMedia,
        ));
      },
      isScrollControlled: true,
    );
  }

  @override
  State<DocumentPickerBottomSheet> createState() =>
      _DocumentPickerBottomSheetState();
}

class _DocumentPickerBottomSheetState extends State<DocumentPickerBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: Material(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 36,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: widget.isMedia ? mediaList() : documentList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> documentList() => [
        buildItem(R.assetsImagesCommonDocument, "document", pickDocument),
        buildItem(R.assetsImagesCommonGallery, "gallery", pickImages),
        buildItem(R.assetsImagesCommonAudio, "audio", pickAudio),
      ];

  List<Widget> mediaList() => [
        buildItem(R.assetsImagesCommonPhoto, "photo", pickImages),
        buildItem(R.assetsImagesCommonVideo, "video", pickVideo),
        buildItem(R.assetsImagesCommonAudio, "audio", pickAudio),
      ];

  Widget buildItem(String image, String label, VoidCallback onPressed) {
    return Expanded(
        child: GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.translucent,
      child: Column(
        children: [
          Image.asset(
            image,
            width: 48,
            height: 48,
          ),
          12.vertical(),
          Text(
            label.tr(),
            style: kCaption14PxMedium.copyWith(color: kGrayText),
          )
        ],
      ),
    ));
  }

  Future<void> pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
      allowMultiple: true,
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      widget.onPickedFile(files);
    }
  }

  Future<void> pickImages() async {
    List<XFile>? images = await ImagePicker().pickMultiImage();
    if (images.isNotEmpty) {
      List<File> files = images.map((image) => File(image.path)).toList();
      widget.onPickedFile(files);
    }
  }

  Future<void> pickAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: true,
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      widget.onPickedFile(files);
    }
  }

  Future<void> pickVideo() async {
    XFile? video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video != null) {
      widget.onPickedFile([File(video.path)]);
    }
  }
}
