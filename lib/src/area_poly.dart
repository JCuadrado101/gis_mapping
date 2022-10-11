import 'package:google_maps/google_maps.dart';

void areaPoly(
    polyline1Lat,
    polyline1Lng,
    polyline2Lat,
    polyline2Lng,
    polyline3Lat,
    polyline3Lng,
    polyline4Lat,
    polyline4Lng,
    polyline5Lat,
    polyline5Lng,
    GMap map,
    ) {
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
}
