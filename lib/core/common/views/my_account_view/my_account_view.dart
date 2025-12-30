import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/common/providers/my_account_provider/my_account_provider.dart';
import 'package:weqaa/core/common/widgets/common/app_button.dart';
import 'package:weqaa/core/common/widgets/common/app_outlined_button.dart';
import 'package:weqaa/core/common/widgets/common/lanugages_dropdown.dart';
import 'package:weqaa/r.dart';
import 'package:weqaa/utils/extensions/num.dart';
import 'package:weqaa/utils/helpers/locator.dart';
import 'package:weqaa/utils/helpers/nav_helper.dart';
import 'package:weqaa/utils/helpers/ui_helper.dart';

class MyAccountView extends StatefulWidget {
  const MyAccountView({super.key});

  @override
  State<MyAccountView> createState() => _MyAccountViewState();
}

class _MyAccountViewState extends State<MyAccountView> {
  late MyAccountProvider provider ;
  late GoogleMapController googleMapController;
  String _mapStyle = "";

  @override
  void initState() {
    super.initState();
    provider = Provider.of<MyAccountProvider>(context, listen: false);
    provider.getAccountDetails();
    rootBundle.loadString('assets/map_styles/map_style.json').then((string) {
      _mapStyle = string;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final userDetails = provider.userDetails;

    return Scaffold(
      body: Consumer<MyAccountProvider>(
        builder: (context, provider, child) {
          return SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    buildAppBar(),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            16.vertical(),
                            Center(child: buildIDWidget()),
                            24.vertical(),
                            Text(
                              "FARM DETAILS".tr(),
                              style:
                                  kTiny10PxMedium.copyWith(color: kHintColor),
                            ),
                            6.vertical(),
                            buildGoogleMapContainer(),
                            22.vertical(),
                            Text(
                              "Al Safar Farm",
                              style: kBody16PxMedium.copyWith(
                                  color: kLightBlackText),
                            ),
                            4.vertical(),
                            Text("Makkah",
                                style: kCaption14PxRegular.copyWith(
                                    color: kGrayText)),
                            4.vertical(),
                            Row(
                              children: [
                                Text(
                                  "Facility ID: ",
                                    style: kCaption14PxRegular.copyWith(color: kGrayText)
                                ),
                                Text(
                                    "#22454443_TEMP",
                                    style: kCaption14PxRegular.copyWith(color: kGrayText)
                                ),
                              ],
                            ),
                            22.vertical(),
                            buildDivider(),
                            30.vertical(),
                        Column(
                          children: [
                            buildRow(
                              buildTitle("Settings".tr()),
                              buildIconButton(
                                  Image.asset(
                                    R.assetsImagesCommonRight,
                                    width: 12,
                                  ),
                                      () {}),
                                  () {},
                            ),
                            buildDivider(),
                            buildRow(
                              buildTitle("Language".tr()),
                              buildLanguageDropDown(),
                                  () {},
                            ),
                            buildDivider(),
                            buildRow(
                              buildTitle("Privacy & Security".tr()),
                              buildIconButton(
                                  Image.asset(
                                    R.assetsImagesCommonSend,
                                    width: 20,
                                  ),
                                      () {}),
                                  () {},
                            ),
                            buildDivider(),
                            buildRow(
                              buildTitle("Logout".tr()),
                              buildIconButton(
                                  Image.asset(
                                    R.assetsImagesCommonPower,
                                    width: 20,
                                  ),
                                      () {}
                              ),
                                  () {
                                provider.changeValue(true);
                              },
                            ),
                          ],
                        )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    R.assetsImagesCommonAccountImage,
                    width: double.infinity,
                  ),
                ),
                if (provider.isPopUpOpen)
                  InkWell(
                    onTap: () {
                      provider.changeValue(false);
                    },
                    child: Container(
                      height: height,
                      width: width,
                      color: kLightBlackText.withOpacity(0.85),
                    ),
                  ),
                if(provider.isPopUpOpen)
                  Center(
                    child: Container(
                      width: 300,
                      height: 206,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text("Logout".tr() , style: kH620PxMedium.copyWith(color: kLightBlackText)),
                            8.vertical(),
                            Text("Are you sure you want to log out? You'll need to login again to use the app.".tr() , style: kCaption14PxRegular.copyWith(color: kGrayText),textAlign: TextAlign.center,),
                            20.vertical(),
                            Row(
                              children: [
                                Expanded(
                                  child: AppOutlinedButton(
                                    title: "Cancel".tr(),
                                    onPressed: (){
                                      provider.changeValue(false);
                                    },
                                  ),
                                ),
                                16.horizontal(),
                                Expanded(
                                  child: AppButton(
                                    enabled: true,
                                    title: "Logout".tr(),
                                    onPressed: (){
                                      provider.logout(context);
                                    },
                                    isLoading: provider.isLoading,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildDivider() {
    return Container(
      height: 0.2,
      color: const Color(0xff1F2024).withOpacity(0.5),
    );
  }

  Widget buildRow(Widget child1, Widget child2, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [child1, child2],
        ),
      ),
    );
  }

  Widget buildTitle(String title) {
    return Text(
      title,
      style: kCaption14PxRegular.copyWith(color: kLightBlackText),
    );
  }


  Widget buildLanguageDropDown() {
    return const LanguageDropdown();
  }

  Widget buildIDWidget() {
    return Column(
      children: [
        Text(
          "<data>",
          style: kBody16PxRegular.copyWith(color: Colors.black),
        ),
        4.vertical(),
        Text("<data>",
            style: kCaption14PxRegular.copyWith(color: kGrayText)),
        4.vertical(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                 'ID: '.tr(),
                style: kCaption14PxRegular.copyWith(color: kGrayText)
            ),
            Text(
                 "<data>",
                style: kCaption14PxRegular.copyWith(color: kGrayText)
            ),

          ],
        ),
      ],
    );
  }

  Widget buildIconButton(Widget image, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: image,
    );
  }

  Widget buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              locator<NavHelper>().pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: kDarkPrimary,
            )),
        Text(
          "My Account".tr(),
          style: kBody16PxMedium.copyWith(color: Colors.black),
        ),
        IconButton(
            onPressed: () {
              locator<UiHelper>().showSnackBar("Currently no API available.",isError: true);
            },
            icon: Image.asset(
              R.assetsImagesCommonPen,
              width: 20,
            ))
      ],
    );
  }

  Widget buildGoogleMapContainer(){
    const target = LatLng(22.292931,73.1623746);
    return SizedBox(
      height: 180,
      child: GoogleMap(
        style: _mapStyle,
        zoomControlsEnabled: false,
        initialCameraPosition: const CameraPosition(
          target: target,
              zoom: 10.0
        ),
        markers: {
          Marker(
              markerId: const MarkerId('sourceLocation'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
            position: target
          )
        },
      ),
    );
  }

}
