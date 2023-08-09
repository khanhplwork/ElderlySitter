import 'dart:async';

import 'package:flutter/Material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<void> showMapsDialog(BuildContext context) async {
  var size = MediaQuery.of(context).size;
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: StatefulBuilder(
          builder: (context, setState) {
            final Completer<GoogleMapController> _controller =
                Completer<GoogleMapController>();
            const CameraPosition kGooglePlex = CameraPosition(
              target: LatLng(10.841338325681118, 106.8099151882562),
              zoom: 14.4746,
            );

            return SingleChildScrollView(
              child: Container(
                width: size.width,
                height: size.height * 0.5,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: GoogleMap(
                  mapType: MapType.normal,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: false,
                  zoomGesturesEnabled: true,
                  padding: const EdgeInsets.all(0),
                  buildingsEnabled: true,
                  cameraTargetBounds: CameraTargetBounds.unbounded,
                  compassEnabled: true,
                  indoorViewEnabled: false,
                  mapToolbarEnabled: true,
                  minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                  rotateGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  tiltGesturesEnabled: true,
                  trafficEnabled: false,
                  initialCameraPosition: kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            );
          },
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Xác nhận'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
