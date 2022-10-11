import 'dart:html';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:google_maps/google_maps.dart';
import 'package:gis_mapping/src/area_poly.dart';
import 'package:gis_mapping/src/current_location_feature.dart';
import 'package:gis_mapping/src/input_search_feature.dart';
import 'package:gis_mapping/src/point_line_data.dart';
import 'package:gis_mapping/src/infowindow_content.dart';

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
    this.polyline1Lat,
    this.polyline1Lng,
    this.polyline2Lat,
    this.polyline2Lng,
    this.polyline3Lat,
    this.polyline3Lng,
    this.polyline4Lat,
    this.polyline4Lng,
    this.polyline5Lat,
    this.polyline5Lng,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String htmlId = "google-maps";
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

      pointLineLayers(map, pointURL!, lineURL!, pointIcon);
      infoWindowContent(map, infoWindow);
      areaPoly(
          polyline1Lat, polyline1Lng,
          polyline2Lat, polyline2Lng,
          polyline3Lat, polyline3Lng,
          polyline4Lat, polyline4Lng,
          polyline5Lat, polyline5Lat,
          map
      );
      currentLocationFeature(map, infoWindow);
      inputSearchFeature(map);
      pointLineLayers(map, pointURL!, lineURL!, pointIcon);



      // final box = document.getElementById('box') as HtmlElement;
      // map.controls![ControlPosition.BOTTOM_CENTER as int]!.push(box);
      //

      // final inputBox = document.getElementById('boxClose') as ButtonElement;
      // inputBox.onClick.listen((event) {
      //   document.getElementById('box')!.style.display = 'none';
      //   // map.controls![ControlPosition.BOTTOM_CENTER as int]!.pop();
      // });

      return elem;
    });

    return HtmlElementView(viewType: htmlId);
  }
}

