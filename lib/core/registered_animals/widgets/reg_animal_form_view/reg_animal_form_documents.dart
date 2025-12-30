import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/my_animals/providers/animal_form_provider/animal_form_provider.dart';
import 'package:weqaa/utils/extensions/num.dart';

class RegisteredAnimalFormDocuments extends StatefulWidget {
  const RegisteredAnimalFormDocuments({super.key});

  @override
  State<RegisteredAnimalFormDocuments> createState() => _RegisteredAnimalFormDocumentsState();
}

class _RegisteredAnimalFormDocumentsState extends State<RegisteredAnimalFormDocuments> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AnimalFormProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(provider),
            for (int i = 0; i < provider.documents.length; i++)
              buildDocumentRow(provider, i),
          ],
        );
      },
    );
  }

  Row buildHeader(AnimalFormProvider provider) {
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
            decoration: const ShapeDecoration(
                shape: StadiumBorder(), color: kPrimary100),
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

  Widget buildDocumentRow(AnimalFormProvider provider, int i) {
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
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: kCancelColor),
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
