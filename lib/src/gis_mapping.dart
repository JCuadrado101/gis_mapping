import 'dart:html';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:google_maps/google_maps.dart';
import 'package:google_maps/google_maps_places.dart';


class GISMapping extends StatelessWidget {
  final String? pointURL;
  final String? lineURL;
  final String? pointIcon;
  final double? centerLat;
  final double? centerLong;
  final double? polyline1Lat;
  final double? polyline1Lng;
  final double? polyline2Lat;
  final double? polyline2Lng;
  final double? polyline3Lat;
  final double? polyline3Lng;
  final double? polyline4Lat;
  final double? polyline4Lng;
  final double? polyline5Lat;
  final double? polyline5Lng;
  const GISMapping({
    this.pointIcon,
    this.lineURL,
    this.pointURL,
    this.centerLat,
    this.centerLong,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String htmlId = "google-maps";
    final markers = <Marker>[];
    final infoWindow = InfoWindow();


    ui.platformViewRegistry.registerViewFactory(htmlId, (int viewID) {

      final mapOptions = MapOptions()
        ..zoom = 18
        ..center = LatLng(centerLat, centerLong)
        ..mapTypeControl = true
        ..streetViewControl = true
        ..rotateControl = true
        ..rotateControl = true
      ;

      final elem = DivElement()
        ..id = htmlId
        ..style.width = "100%"
        ..style.height = "100%"
        ..style.border = 'none'
      ;

      final map = GMap(elem, mapOptions);

      map.data!.loadGeoJson(pointURL);

      final featureStyle = DataStyleOptions()
        ..icon = pointIcon
        ..strokeColor = 'blue'
      ;
      map.data!.style = featureStyle;

      map.data!.loadGeoJson(lineURL);

      final triangleCoords = <LatLng>[
        LatLng(polyline1Lat, polyline1Lng),
        LatLng(polyline2Lat, polyline2Lng),
        LatLng(polyline3Lat, polyline3Lng),
        LatLng(polyline4Lat, polyline4Lng),
        LatLng(polyline5Lat, polyline5Lng)
      ];

      Polygon(PolygonOptions()
        ..paths = triangleCoords
        ..strokeColor = '#FF0000'
        ..strokeOpacity = 0.8
        ..strokeWeight = 3
        ..fillColor = '#FF0000'
        ..fillOpacity = 0.35)
          .map = map;

      final infowindow = InfoWindow();


      map.data?.onClick.listen((event) {
        final latlng = LatLng(event.latLng?.lat, event.latLng?.lng);
        final url1 = event.feature!.getProperty('ft_S3Url_1');
        final url2 = event.feature!.getProperty('ft_S3Url_2');
        final url3 = event.feature!.getProperty('ft_S3Url_3');
        final url4 = event.feature!.getProperty('ft_S3Url_4');
        final url5 = event.feature!.getProperty('ft_S3Url_5');
        final url6 = event.feature!.getProperty('ft_S3Url_6');
        final roadName = event.feature!.getProperty('RoadName');
        final layerHexColor =  event.feature!.getProperty('ft_LayerHexColor');
        final cdcShapeFile = event.feature!.getProperty('ft_CdcShapeFile');

        String contentString =
            '<div id="content">'
            '<div id="siteNotice">'
            '</div>'
            '<h1 id="firstHeading" class="firstHeading">Details</h1>'
            '<div id="bodyContent">'
            '<p>${url1 == null ? " " : "URL1: "} <a href="$url1">${url1 == null ? " " : "Click Me"}</a></p>'
            '<p>${url2 == null ? " " : "URL2: "} <a href="$url2">${url2 == null ? " " : "Click Me"}</a></p>'
            '<p>${url3 == null ? " " : "URL3: "} <a href="$url3">${url3 == null ? " " : "Click Me"}</a></p>'
            '<p>${url4 == null ? " " : "URL4: "} <a href="$url4">${url4 == null ? " " : "Click Me"}</a></p>'
            '<p>${url5 == null ? " " : "URL5: "} <a href="$url5">${url5 == null ? " " : "Click Me"}</a></p>'
            '<p>${url6 == null ? " " : "URL6: "} <a href="$url6">${url6 == null ? " " : "Click Me"}</a></p>'
            '<p>Road Name: $roadName</p>'
            '<p>LayerHexColor: $layerHexColor</p>'
            '<p>CdcShapeFile: $cdcShapeFile</p>'
            '<button id="btn" onclick={}>Select</button>'
            '</div>'
            '</div>';

        infowindow.content = contentString;

        final marker = Marker(MarkerOptions()
          ..position = latlng
          ..map = map
          ..icon = " "
          ..title = 'Uluru (Ayers Rock)');

        infowindow.open(map, marker);

      });

      // final box = document.getElementById('box') as HtmlElement;
      // map.controls![ControlPosition.BOTTOM_CENTER as int]!.push(box);
      //

      // final inputBox = document.getElementById('boxClose') as ButtonElement;
      // inputBox.onClick.listen((event) {
      //   document.getElementById('box')!.style.display = 'none';
      //   // map.controls![ControlPosition.BOTTOM_CENTER as int]!.pop();
      // });


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
      });
      return elem;
    });

    return HtmlElementView(viewType: htmlId);
  }
}

void handleLocationError(
    bool browserHasGeolocation, InfoWindow infoWindow, LatLng pos) {
  infoWindow
    ..position = pos
    ..content = browserHasGeolocation
        ? 'Error: The Geolocation service failed.'
        : "Error: Your browser doesn't support geolocation."
    ..open();
}
