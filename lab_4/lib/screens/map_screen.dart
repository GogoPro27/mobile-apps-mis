import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  final LatLng initialLocation;
  final bool isReadOnly;

  const MapScreen({
    super.key,
    required this.initialLocation,
    this.isReadOnly = false,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  @override
  void initState() {
    super.initState();
    if (widget.isReadOnly) {
      _pickedLocation = widget.initialLocation;
    }
  }

  void _selectLocation(LatLng position) {
    if (!widget.isReadOnly) {
      setState(() {
        _pickedLocation = position;
      });
    }
  }

  Future<void> _launchGoogleMaps() async {
    final String googleMapsUrl =
        "https://www.google.com/maps/dir/?api=1&destination=${widget.initialLocation.latitude},${widget.initialLocation.longitude}&travelmode=driving";
    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(Uri.parse(googleMapsUrl));
    } else {
      throw 'Could not launch Google Maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        actions: widget.isReadOnly
            ? [
                IconButton(
                  icon: const Icon(Icons.directions),
                  onPressed: _launchGoogleMaps,
                ),
              ]
            : [
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () {
                    Navigator.of(context).pop(_pickedLocation);
                  },
                ),
              ],
      ),
      body: FlutterMap(
        options: MapOptions(
          center: widget.initialLocation,
          zoom: 13.0,
          onTap: widget.isReadOnly
              ? null
              : (tapPosition, point) {
                  _selectLocation(point);
                },
          interactiveFlags: InteractiveFlag.all,
        ),
        children: [
          TileLayer(
            urlTemplate:
                "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: _pickedLocation ?? widget.initialLocation,
                width: 40.0,
                height: 40.0,
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 40.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}