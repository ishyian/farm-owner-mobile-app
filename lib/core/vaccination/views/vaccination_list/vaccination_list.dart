import 'package:flutter/material.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/vaccination/widgets/vaccination_view/vaccination_item.dart';
import 'package:weqaa/utils/extensions/num.dart';

class VaccinationList extends StatefulWidget {
  const VaccinationList({super.key});

  @override
  State<VaccinationList> createState() => _VaccinationListState();
}

class _VaccinationListState extends State<VaccinationList> {
  final List<String> vaccinations = [
    'BCG',
    'DPT',
    'Hepatitis B',
    'Hepatitis C',
    'Meningococcal',
    'Polio',
    'Typhoid',
    'Tetanus',
    'Pneumococcal',
    'Measles',
    'Rubella',
    'Varicella',
    'Hepatitis A',
    'Shingles',
    'MMR',
    'Flu',
    'Influenza',
    'Hepatitis D',
    'Parainfluenza',
    'Chickenpox',
    'Rabies',
    'Hepatitis E',
    'Mumps',
    'Poliovirus',
    'Grippe',
    'Measles-Mumps-Rubella',
    'Foot and Mouth Disease',
    'Hepatitis G',
    'Meningococcal Meningitis'
  ];
  final List<String> selectedVaccinations = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: vaccinations.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final bool isSelected =
                  selectedVaccinations.contains(vaccinations[index]);
              return Row(
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      if (!isSelected) {
                        selectedVaccinations.add(vaccinations[index]);
                      } else {
                        selectedVaccinations.remove(vaccinations[index]);
                      }
                      setState(() {});
                    },
                    child: Chip(
                        backgroundColor:
                            isSelected ? kPrimaryColor : Colors.transparent,
                        shape: const StadiumBorder(
                          side: BorderSide(color: kPrimaryColor),
                        ),
                        label: Text(
                          vaccinations[index],
                          style: kSmall12PxRegular.copyWith(
                              color: isSelected ? Colors.white : kPrimary500),
                        )),
                  ),
                  10.horizontal()
                ],
              );
            },
          ),
        ),
        16.vertical(),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            itemBuilder: (context, index) {
              return const VaccinationItem();
            },
          ),
        )
      ],
    );
  }
}
