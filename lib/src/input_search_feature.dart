import 'dart:html';
import 'package:google_maps/google_maps.dart';
import 'package:google_maps/google_maps_places.dart';

void inputSearchFeature(GMap map) {
  final markers = <Marker>[];

  // Create the search box and link it to the UI element.
  final input = document.getElementById('pac-input') as InputElement;
  map.controls![ControlPosition.TOP_CENTER as int]!.push(input);

  final searchBox = SearchBox(input);

  // Listen for the event fired when the user selects an item from the
  // pick list. Retrieve the matching places for that item.
  searchBox.onPlacesChanged.listen((_) {
    final places = searchBox.places!;

    if (places.isEmpty) {
      return;
    }
    for (final marker in markers) {
      marker.map = null;
    }

    // For each place, get the icon, place name, and location.
    markers.clear();
    final bounds = LatLngBounds();
    for (final place in places) {

      // Create a marker for each place.
      final marker = Marker(MarkerOptions()
        ..map = map
        ..title = place?.name
        ..position = place?.geometry!.location);

      markers.add(marker);

      bounds.extend(place?.geometry!.location);
    }

    map.fitBounds(bounds);
  });

  // Bias the SearchBox results towards places that are within the bounds of the
  // current map's viewport.
  map.onBoundsChanged.listen((_) {
    final bounds = map.bounds;
    searchBox.bounds = bounds;
  });
}
