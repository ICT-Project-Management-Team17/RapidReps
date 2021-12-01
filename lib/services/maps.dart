import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'export.dart';

class Maps {
  Future<CameraPosition> locatePosition() async {
    Location location = Location();
    await location.determinePosition();

    LatLng latLngPosition = LatLng(location.latitude, location.longitude);

    CameraPosition cameraPosition =
        CameraPosition(target: latLngPosition, zoom: 14);
    return cameraPosition;
  }
}
