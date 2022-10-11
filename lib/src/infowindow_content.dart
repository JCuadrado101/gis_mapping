import 'package:google_maps/google_maps.dart';

void infoWindowContent(GMap map, InfoWindow infoWindow) {
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

    infoWindow.content = contentString;

    final marker = Marker(MarkerOptions()
      ..position = latlng
      ..map = map
      ..icon = " "
      ..title = 'Uluru (Ayers Rock)');

    infoWindow.open(map, marker);

  });
}
