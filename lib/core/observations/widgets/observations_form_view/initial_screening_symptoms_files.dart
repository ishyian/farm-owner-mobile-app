import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/observations/providers/observation_form_provider/initial_screening_form_provider.dart';
import 'package:weqaa/r.dart';
import 'package:weqaa/utils/extensions/context.dart';
import 'package:weqaa/utils/extensions/file.dart';
import 'package:weqaa/utils/extensions/num.dart';

class InitialScreeningSymptomsFiles extends StatefulWidget {
  const InitialScreeningSymptomsFiles({super.key});

  @override
  State<InitialScreeningSymptomsFiles> createState() => _InitialScreeningSymptomsFilesState();
}

class _InitialScreeningSymptomsFilesState extends State<InitialScreeningSymptomsFiles> {
  @override
  Widget build(BuildContext context) {
    return Consumer<InitialScreeningFormProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            for (int i = 0; i < provider.selectedSymptoms.length; i++) buildSingleSymptom(provider, i),
          ],
        );
      },
    );
  }

  Widget buildSingleSymptom(InitialScreeningFormProvider provider, int i) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  provider.selectedSymptoms[i].name ?? "",
                  style: kBody16PxRegular,
                ),
              ),
              GestureDetector(
                onTap: () => provider.onAddSymptomFilePressed(i),
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: kDarkPrimary),
                  child: Center(
                    child: Image.asset(
                      R.assetsImagesCommonGallery,
                      color: Colors.white,
                      width: 10,
                      height: 10,
                    ),
                  ),
                ),
              )
            ],
          ),
          if (provider.symptomsFiles[i] != null && provider.symptomsFiles[i]!.isNotEmpty) ...[
            16.vertical(),
            SizedBox(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: (provider.symptomsFiles[i] ?? []).map((f) {
                  final fileIndex = provider.symptomsFiles[i]!.indexOf(f);
                  return Row(
                    children: [
                      SizedBox(
                        width: 60,
                        child: Column(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                getThumbnail(f),
                                Positioned(
                                  right: context.isRTL() ? null : -7,
                                  left: context.isRTL() ? -7 : null,
                                  top: -5,
                                  child: GestureDetector(
                                    onTap: () {
                                      provider.removeSymptomFile(i, fileIndex);
                                    },
                                    child: Container(
                                      width: 15,
                                      height: 15,
                                      decoration: const BoxDecoration(color: kAlertError, shape: BoxShape.circle),
                                      child: const Center(
                                          child: Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                        size: 14,
                                      )),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            8.vertical(),
                            Text(
                              f.getFileName(),
                              maxLines: 1,
                              style: kSmall12PxRegular,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                      16.horizontal(),
                    ],
                  );
                }).toList(),
              ),
            )
          ]
        ],
      ),
    );
  }

  String getIcon(File f) {
    if (f.isAudio()) return R.assetsImagesCommonAudio;
    if (f.isImage()) return R.assetsImagesCommonGallery;
    if (f.isVideo()) return R.assetsImagesCommonVideo;
    return R.assetsImagesCommonDocument;
  }

  Widget getThumbnail(File f) {
    if (f.isImage()) {
      return Image.file(
        f,
        width: 38,
        height: 38,
        fit: BoxFit.cover,
      );
    } else if (f.isVideo()) {
      return FutureBuilder(
        future: VideoThumbnail.thumbnailData(video: f.path),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Image.memory(
              snapshot.data!,
              fit: BoxFit.cover,
              width: 38,
              height: 38,
            );
          }
          return getIconContainer(f);
        },
      );
    } else if (f.isPdf()) {
      return getIconContainer(f, image: R.assetsImagesCommonDocument);
    } else if (f.isDocument()) {
      return getIconContainer(f, image: R.assetsImagesCommonDocument);
    } else {
      return getIconContainer(f);
    }
  }

  Widget getIconContainer(File f, {String? image}) {
    return Container(
      height: 38,
      width: 38,
      decoration: const BoxDecoration(color: kPrimary300),
      child: Center(
          child: Image.asset(
        image ?? getIcon(f),
        width: 15,
        height: 15,
        color: Colors.white,
      )),
    );
  }
}
