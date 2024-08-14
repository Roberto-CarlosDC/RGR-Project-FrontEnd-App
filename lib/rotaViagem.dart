import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:testergr/APIGoogle.dart';

class ViagemDetailsMap extends StatefulWidget {
  final LatLng origem;
  final LatLng destino;

  ViagemDetailsMap({required this.origem, required this.destino});

  @override
  _ViagemDetailsMapState createState() => _ViagemDetailsMapState();
}

class _ViagemDetailsMapState extends State<ViagemDetailsMap> {
  GoogleMapController? mapController;
  List<LatLng> polylineCoordinates = [];
  Set<Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    _loadRoute();
  }

  void _loadRoute() async {
    polylineCoordinates = await fetchRoute(widget.origem, widget.destino);
    setState(() {
      polylines.add(Polyline(
        polylineId: PolylineId('route'),
        visible: true,
        points: polylineCoordinates,
        width: 6,
        color: Colors.blue,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        mapController = controller;
      },
      initialCameraPosition: CameraPosition(
        target: widget.origem,
        zoom: 12.0,
      ),
      polylines: polylines,
      markers: {
        Marker(markerId: MarkerId('origem'), position: widget.origem),
        Marker(markerId: MarkerId('destino'), position: widget.destino),
      },
    );
  }
}
