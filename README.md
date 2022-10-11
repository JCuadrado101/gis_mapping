<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

This package is designed for quick implementation of the Google Maps API for flutter applications. This package heavily depends on the google_maps package for Flutter Web. All parameters and settings of the GIS_Mapping is extremely opinionated and has very limited configuration. This is meant to be a plug and play solution for GIS Mapping configurations. 

## Features

The feature of this package includes the following: 

Google Maps API pre-configured:

<li>Terrain & Satellite View</li>
<li>Get and Pan to Current Location Feature</li>
<li>Full Screen Mode</li>
<li>Zooming features</li>
<li>Google Places Auto-Complete Search</li>
<li>GeoJson Driven Circles & Lines</li>
<li>Pre-Config Infowindow based from Geojson data</li>

## Getting started

To get started using this package - you will need to create an account with google and obtain the APIKEY to use the maps api.

## Usage

Copy & Paste this html code and apply it to the Flutter index.html located in your web folder. 
 
** This HTML code simply contains all the basic elements used for the mapping. The package will used Dart to call upon the elements when the map is called to render on the screen.**

```
<!DOCTYPE html>
<html>
<head>
  <base href="$FLUTTER_BASE_HREF">

  <meta charset="UTF-8">
  <meta content="IE=Edge" http-equiv="X-UA-Compatible">
  <meta name="description" content="A new Flutter project.">

  <!-- iOS meta tags & icons -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-title" content="maps_flutter_build">
  <link rel="apple-touch-icon" href="icons/Icon-192.png">

  <!-- Favicon -->
  <link rel="icon" type="image/png" href="favicon.png"/>

  <title>maps_flutter_build</title>
  <link rel="manifest" href="manifest.json">

  <script>
    // The value below is injected by flutter build, do not touch.
    var serviceWorkerVersion = null;
  </script>
  <!-- This script adds the flutter initialization JS code -->
  <script src="flutter.js" defer></script>
  <style>
    html, body, #map-canvas {
      height: 100%;
      margin: 0px;
      padding: 0px
    }
    .controls {
      margin-top: 16px;
      border: 1px solid transparent;
      border-radius: 2px 0 0 2px;
      box-sizing: border-box;
      -moz-box-sizing: border-box;
      height: 32px;
      outline: none;
      box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
    }

    #pac-input {
      background-color: #fff;
      font-family: Roboto;
      font-size: 15px;
      font-weight: 300;
      margin-left: 12px;
      padding: 0 11px 0 13px;
      text-overflow: ellipsis;
      width: 400px;
    }

    #pac-input:focus {
      border-color: #4d90fe;
    }

    .pac-container {
      font-family: Roboto;
    }

    #type-selector {
      color: #fff;
      background-color: #4d90fe;
      padding: 5px 11px 0px 11px;
    }

    #type-selector label {
      font-family: Roboto;
      font-size: 13px;
      font-weight: 300;
    }

    p {
      color: black;
    }
  </style>
</head>
<body>
  <input id="pac-input" class="controls" type="text" placeholder="Search Box">
<!--  <div id="box">-->
<!--    <button id="boxClose" style="margin: auto">X</button>-->
<!--    <form action="/action_page.php">-->
<!--      <label for="img">Select image:</label>-->
<!--      <input type="file" id="img" name="img" accept="image/*">-->
<!--      <input type="submit">-->
<!--    </form>-->
<!--  </div>-->
  <div id="map-canvas"></div>
  <script>
    window.addEventListener('load', function(ev) {
      // Download main.dart.js
      _flutter.loader.loadEntrypoint({
        serviceWorker: {
          serviceWorkerVersion: serviceWorkerVersion,
        }
      }).then(function(engineInitializer) {
        return engineInitializer.initializeEngine();
      }).then(function(appRunner) {
        return appRunner.runApp();
      });
    });
  </script>
  <script src="https://maps.googleapis.com/maps/api/js?key={APIKEY}"></script>
  <script>
  </script>
</body>
</html>


```


Within the same index.html - replace {APIKEY} with the actual APIKEY provided through the google map api: 

```   <script src="https://maps.googleapis.com/maps/api/js?key={APIKEY}"></script> ```







## Additional information

This is a personal package for using google maps for other projects.
