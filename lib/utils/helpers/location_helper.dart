import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' hide PermissionStatus;
import 'package:permission_handler/permission_handler.dart';

class LocationHelper {
  final location = Location();

  Future<LocationData?> determinePosition() async {
    final res = await checkPermission();
    if (res) {
      final position = await Geolocator.getCurrentPosition();
      return LocationData.fromMap(position.toJson());
    }
    return null;
  }

  Future<bool> checkPermission() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }

    PermissionStatus permission = await Permission.locationWhenInUse.status;
    if (permission != PermissionStatus.granted) {
      permission = await Permission.locationWhenInUse.request();
      if (permission != PermissionStatus.granted) {
        return false;
      }
    }

    return true;
  }
}
