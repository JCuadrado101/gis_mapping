import 'package:google_maps/google_maps.dart';

void pointLineLayers(GMap map, String pointURL, String lineURL, String? pointIcon) {
  map.data!.loadGeoJson(pointURL);
  map.data!.loadGeoJson(lineURL);


  final featureStyle = DataStyleOptions()
    ..icon = pointIcon
    ..strokeColor = 'blue'
  ;
  map.data!.style = featureStyle;
}
