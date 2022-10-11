import 'dart:html';
import 'package:google_maps/google_maps.dart';

void handleLocationError(
    bool browserHasGeolocation, InfoWindow infoWindow, LatLng pos) {
  infoWindow
    ..position = pos
    ..content = browserHasGeolocation
        ? 'Error: The Geolocation service failed.'
        : "Error: Your browser doesn't support geolocation."
    ..open();
}

void currentLocationFeature(GMap map, InfoWindow infoWindow) {
  final locationButton = (document.createElement('button') as ButtonElement)
    ..text = 'Pan to Current Location'
    ..classes.add('custom-map-control-button');
  map.controls![ControlPosition.BOTTOM_LEFT as int]!.push(locationButton);
  locationButton.onClick.listen((_) async {
    // Try HTML5 geolocation.
    // ignore: unnecessary_null_comparison
    if (window.navigator.geolocation != null) {
      try {
        final position =
        await window.navigator.geolocation.getCurrentPosition();
        final pos =
        LatLng(position.coords!.latitude, position.coords!.longitude);
        infoWindow
          ..position = pos
          ..content = 'Location found.'
          ..open(map);
        map.center = pos;
      } catch (e) {
        handleLocationError(true, infoWindow, map.center!);
      }
    } else {
      // Browser doesn't support Geolocation
      handleLocationError(false, infoWindow, map.center!);
    }
  });}
