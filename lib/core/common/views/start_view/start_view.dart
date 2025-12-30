import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/core/incidients/views/incidents_view/incidents_view.dart';
import 'package:weqaa/core/my_animals/views/my_animals_view/my_animals_view.dart';
import 'package:weqaa/core/registered_animals/views/reg_animals_view/reg_animals_view.dart';
import 'package:weqaa/core/vaccination/views/vaccination_view/vaccination_view.dart';
import 'package:weqaa/r.dart';

import '../../../../share_preference/share_preference_provider.dart';
import '../../../../utils/helpers/locator.dart';
import '../../../observations/views/observations_view/observations_view.dart';
import '../alerts_view/alerts_view.dart';

class StartView extends StatefulWidget {
  StartView({super.key, this.userType});

  String? userType;

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  bool isFarmOwner = true;
  var items = [];
  int index = 0;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
    navigateUserToNextScreens();
    super.initState();
  }

  navigateUserToNextScreens() {
    locator.get<PreferenceService>();
    isFarmOwner = widget.userType?.toLowerCase() == "Farm Owner".toLowerCase();
    isFarmOwner == true
        ? items = [
            {'title': 'my_animals', 'icon': R.assetsImagesCommonHomeIcon, "view": const MyAnimalsView()},
            {"title": "incidents", "icon": R.assetsImagesCommonHomeIcon, "view": const IncidentsView()},
            {"title": "vaccination", "icon": R.assetsImagesCommonVaccination, "view": const VaccinationView()},
          ]
        : isFarmOwner == false
            ? items = [
                {"title": "reg_animals", "icon": R.assetsImagesRegAnimalIcon, "view": const RegisteredAnimalsView()},
                {"title": "observations", "icon": R.assetsImagesObservationIcon, "view": const ObservationsView()},
                {
                  "title": "alerts",
                  "icon": R.assetsImagesAlertsIcon,
                  "view": AlertsView(
                    showBackIcon: false,
                  )
                },
              ]
            : [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Expanded(child: items[index]['view'] as Widget), buildBottomAppBar()],
    );
  }

  Container buildBottomAppBar() {
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 70,
          child: items.isEmpty
              ? Container()
              : BottomNavigationBar(
                  elevation: 0,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  items: items
                      .map((e) => BottomNavigationBarItem(
                          backgroundColor: Colors.white,
                          activeIcon: Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: buildIcon(e, kDarkPrimary),
                          ),
                          icon: Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: buildIcon(e, kDisabledColor),
                          ),
                          label: e['title'].toString().tr()))
                      .toList(),
                  selectedItemColor: Colors.black,
                  unselectedItemColor: kGrayText,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  selectedLabelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                  unselectedLabelStyle: const TextStyle(
                    color: kGrayText,
                  ),
                  currentIndex: index,
                  onTap: (index) => setState(() => this.index = index)),
        ),
      ),
    );
  }

  Widget buildIcon(Map<String, Object> e, Color color) {
    return Stack(
      children: [
        Center(
          child: SvgPicture.asset(
            e['icon'].toString(),
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            width: 24,
          ),
        ),
        if (e['title'] == 'incidents')
          const Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            top: 9,
            child: Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 8,
              ),
            ),
          )
      ],
    );
  }
}
