import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queen_validators/queen_validators.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/common/widgets/common/app_text_field.dart';
import 'package:weqaa/core/my_animals/providers/animal_form_provider/animal_form_provider.dart';
import 'package:weqaa/r.dart';
import 'package:weqaa/utils/extensions/num.dart';
import 'package:weqaa/utils/helpers/validators.dart';

class AnimalFormVaccinations extends StatefulWidget {
  const AnimalFormVaccinations({super.key});

  @override
  State<AnimalFormVaccinations> createState() => _AnimalFormVaccinationsState();
}

class _AnimalFormVaccinationsState extends State<AnimalFormVaccinations> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AnimalFormProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(provider),
            for (int i = 0; i < provider.vaccinations.length; i++)
              _SingleVaccinationWidget(
                i,
                title: provider.vaccinations[i].title,
                date: provider.vaccinations[i].date,
                key: UniqueKey(),
              )
          ],
        );
      },
    );
  }

  Row buildHeader(AnimalFormProvider provider) {
    return Row(
      children: [
        Text(
          "vaccination".tr(),
          style: kSmall12PxRegular,
        ),
        16.horizontal(),
        GestureDetector(
          onTap: () {
            provider.addVaccination();
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
}

class _SingleVaccinationWidget extends StatefulWidget {
  const _SingleVaccinationWidget(this.index,
      {super.key, this.title, this.date});
  final int index;
  final String? title;
  final DateTime? date;
  @override
  State<_SingleVaccinationWidget> createState() =>
      _SingleVaccinationWidgetState();
}

class _SingleVaccinationWidgetState extends State<_SingleVaccinationWidget> {
  final TextEditingController controller = TextEditingController();
  final dateController = TextEditingController();
  DateTime? selectedDate;
  @override
  void initState() {
    controller.text = widget.title ?? "";
    selectedDate = widget.date;
    if (selectedDate != null) {
      dateController.text = DateFormat('dd-MM-yyyy').format(selectedDate!);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AnimalFormProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            16.vertical(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AppTextField(
                    controller: controller,
                    onChanged: (val) {
                      provider.vaccinations[widget.index].title = val;
                    },
                    validator: qValidator([
                      Validators.isRequired(),
                    ]),
                    hint: "type".tr(),
                  ),
                ),
                8.horizontal(),
                Expanded(
                  child: AppTextField(
                    controller: dateController,
                    validator: qValidator([Validators.isRequired()]),
                    onTap: () => pickDate(provider),
                    hint: "date".tr(),
                    readOnly: true,
                    suffix: SizedBox(
                      width: 20,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            R.assetsImagesCommonCalendar,
                            color: kPrimaryColor,
                            width: 18,
                          ),
                          16.horizontal()
                        ],
                      ),
                    ),
                  ),
                ),
                8.horizontal(),
                GestureDetector(
                  onTap: () => provider.removeVaccination(widget.index),
                  child: Container(
                    width: 45,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: kCancelColor),
                    child: const Icon(
                      Icons.remove,
                      color: kAlertError,
                    ),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    dateController.dispose();
    super.dispose();
  }

  Future pickDate(AnimalFormProvider provider) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      // builder: (BuildContext context, Widget? child) {
      //   return Theme(
      //     data: ThemeData.light().copyWith(
      //       colorScheme: ColorScheme.light(primary: kPrimaryColor),
      //     ),
      //     child: child!,
      //   );
      // }
    );

    if (selectedDate != null) {
      provider.vaccinations[widget.index].date = selectedDate;
      dateController.text = DateFormat('dd-MM-yyyy').format(selectedDate);
      this.selectedDate = selectedDate;
      setState(() {});
    }
  }
}
