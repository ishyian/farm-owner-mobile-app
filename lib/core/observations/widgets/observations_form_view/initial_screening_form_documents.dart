import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/utils/extensions/num.dart';

import '../../providers/observation_form_provider/initial_screening_form_provider.dart';

class InitialScreeningFormDocuments extends StatefulWidget {
  const InitialScreeningFormDocuments({super.key});

  @override
  State<InitialScreeningFormDocuments> createState() => _InitialScreeningFormDocumentsState();
}

class _InitialScreeningFormDocumentsState extends State<InitialScreeningFormDocuments> {
  @override
  Widget build(BuildContext context) {
    return Consumer<InitialScreeningFormProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(provider),
            for (int i = 0; i < provider.documents.length; i++) buildDocumentRow(provider, i),
          ],
        );
      },
    );
  }

  Row buildHeader(InitialScreeningFormProvider provider) {
    return Row(
      children: [
        Text(
          "documents".tr(),
          style: kSmall12PxRegular,
        ),
        16.horizontal(),
        GestureDetector(
          onTap: () {
            provider.onAddDocument();
          },
          child: Container(
            width: 64,
            decoration: const ShapeDecoration(shape: StadiumBorder(), color: kPrimary100),
            padding: const EdgeInsets.all(6),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.add,
                    color: kPrimary500,
                    size: 14,
                  ),
                  6.horizontal(),
                  Text(
                    "add".tr(),
                    style: kSmall12PxRegular,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDocumentRow(InitialScreeningFormProvider provider, int i) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              provider.documents[i].path.split("/").last,
              style: kCaption14PxRegular,
            ),
          ),
          16.horizontal(),
          GestureDetector(
            onTap: () => provider.removeDocument(i),
            child: Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: kCancelColor),
              child: const Icon(
                Icons.remove,
                color: kAlertError,
              ),
            ),
          )
        ],
      ),
    );
  }
}
