import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/core/common/views/alerts_view/alerts_view.dart';
import 'package:weqaa/core/common/views/my_account_view/my_account_view.dart';
import 'package:weqaa/core/common/widgets/common/app_app_bar.dart';
import 'package:weqaa/core/incidients/views/incident_form_view/incident_form_view.dart';
import 'package:weqaa/core/incidients/widgets/incidents_view/empty_incidents_view.dart';
import 'package:weqaa/core/incidients/widgets/incidents_view/incident_item.dart';
import 'package:weqaa/r.dart';
import 'package:weqaa/utils/helpers/locator.dart';
import 'package:weqaa/utils/helpers/nav_helper.dart';

class IncidentsView extends StatefulWidget {
  const IncidentsView({super.key});

  @override
  State<IncidentsView> createState() => _IncidentsViewState();
}

class _IncidentsViewState extends State<IncidentsView> {
  bool isEmpty = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          locator<NavHelper>().push(const IncidentFormView());
        },
        backgroundColor: kDarkPrimary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppAppBar(
        showBackIcon: false,
        title: "incidents".tr(),
        actions: [
          IconButton(
              onPressed: () {
                locator<NavHelper>().push(AlertsView());
              },
              icon: Image.asset(R.assetsImagesCommonNotifications, width: 18)),
          IconButton(
            onPressed: () {
              locator<NavHelper>().push(const MyAccountView());
            },
            icon: Image.asset(
              R.assetsImagesCommonProfileIcon,
              width: 20,
            ),
          )
        ],
      ),
      body: isEmpty
          ? const EmptyIncidentsView()
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              itemBuilder: (context, index) {
                return IncidentItem(index: index);
              },
            ),
    );
  }
}
