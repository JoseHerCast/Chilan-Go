import 'package:app/style/my_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({Key? key}) : super(key: key);

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  final controller = MapController(
    location: LatLng(35.68, 51.41),
  );
  final markers = [
    LatLng(35.674, 51.41),
    LatLng(37.676, 71.41),
    LatLng(35.678, 51.41),
    LatLng(75.68, 21.41),
    LatLng(35.682, 51.41),
    LatLng(35.684, 51.41),
    LatLng(35.686, 51.41),
  ];

  void _gotoDefault() {
    controller.center = LatLng(35.68, 51.41);
    setState(() {});
  }

  void _onDoubleTap() {
    controller.zoom += 0.5;
    setState(() {});
  }

  Offset? _dragStart;
  double _scaleStart = 1.0;
  void _onScaleStart(ScaleStartDetails details) {
    _dragStart = details.focalPoint;
    _scaleStart = 1.0;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    final scaleDiff = details.scale - _scaleStart;
    _scaleStart = details.scale;

    if (scaleDiff > 0) {
      controller.zoom += 0.02;
      setState(() {});
    } else if (scaleDiff < 0) {
      controller.zoom -= 0.02;
      setState(() {});
    } else {
      final now = details.focalPoint;
      final diff = now - _dragStart!;
      _dragStart = now;
      controller.drag(diff.dx, diff.dy);
      setState(() {});
    }
  }

  Widget _buildMarkerWidget(Offset pos, Color color) {
    return Positioned(
      left: pos.dx - 16,
      top: pos.dy - 16,
      width: 24,
      height: 24,
      child: Icon(Icons.location_on, color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MapLayoutBuilder(
      controller: controller,
      builder: (context, transformer) {
        final markerPositions =
            markers.map(transformer.fromLatLngToXYCoords).toList();

        final markerWidgets = markerPositions.map(
          (pos) => _buildMarkerWidget(pos, Colors.red),
        );

        final homeLocation =
            transformer.fromLatLngToXYCoords(LatLng(35.68, 51.412));

        final homeMarkerWidget = _buildMarkerWidget(homeLocation, Colors.black);

        final centerLocation = Offset(transformer.constraints.biggest.width / 2,
            transformer.constraints.biggest.height / 2);

        final centerMarkerWidget =
            _buildMarkerWidget(centerLocation, Colors.purple);

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onDoubleTap: _onDoubleTap,
          onScaleStart: _onScaleStart,
          onScaleUpdate: _onScaleUpdate,
          onTapUp: (details) {
            final location =
                transformer.fromXYCoordsToLatLng(details.localPosition);

            final clicked = transformer.fromLatLngToXYCoords(location);

            print('${location.longitude}, ${location.latitude}');
            print('${clicked.dx}, ${clicked.dy}');
            print('${details.localPosition.dx}, ${details.localPosition.dy}');
          },
          child: Listener(
            behavior: HitTestBehavior.opaque,
            onPointerSignal: (event) {
              if (event is PointerScrollEvent) {
                final delta = event.scrollDelta;

                controller.zoom -= delta.dy / 1000.0;
                setState(() {});
              }
            },
            child: Stack(
              children: [
                Map(
                  controller: controller,
                  builder: (context, x, y, z) {
                    //Legal notice: This url is only used for demo and educational purposes. You need a license key for production use.

                    //Google Maps
                    //final url =
                    //  'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';
                    //Mapbox Streets
                    final url =
                        '"https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/-122.4241,37.78,15.25,0,60/400x400?access_token=pk.eyJ1Ijoiam9zc2hjIiwiYSI6ImNsMHp0bWtqdzJlMjUzY3BuZmNsN2lxeXcifQ.VPwuo0M5X_FO5hFaZ_QG-Q';

                    return CachedNetworkImage(
                      imageUrl: url,
                      fit: BoxFit.cover,
                      repeat: ImageRepeat.noRepeat,
                    );
                  },
                ),
                homeMarkerWidget,
                ...markerWidgets,
                centerMarkerWidget,
              ],
            ),
          ),
        );
      },
    );
  }
}
