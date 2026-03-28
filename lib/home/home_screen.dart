// home_screen.dart
// ignore_for_file: unused_local_variable, unused_element_parameter, unused_import, curly_braces_in_flow_control_structures, deprecated_member_use

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:Riden/bookings/bookingride_loading.dart';
import 'package:Riden/bookings/bookride.dart';
import 'package:Riden/call_and_chat/chat_screen.dart';
import 'package:Riden/home/add_place_screen.dart';
import 'package:Riden/home/your_locations_screen.dart';
import 'package:Riden/my_profile/profilesheet.dart';
import 'package:Riden/notifications/notification.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:http/http.dart' as http;

import '../theme/app_colors.dart';

// ─── Dark blue map style (unchanged) ────────────────────────────────────────
const String _kDarkMapStyle = '''
[
  { "elementType": "geometry", "stylers": [{ "color": "#1d2c4d" }] },
  { "elementType": "labels.text.fill", "stylers": [{ "color": "#8ec3b9" }] },
  { "elementType": "labels.text.stroke", "stylers": [{ "color": "#1a3646" }] },
  { "featureType": "administrative", "elementType": "geometry", "stylers": [{ "color": "#334e87" }] },
  { "featureType": "administrative", "elementType": "labels.text.fill", "stylers": [{ "color": "#c7e0ff" }] },
  { "featureType": "administrative.country", "elementType": "labels.text.fill", "stylers": [{ "color": "#ffffff" }] },
  { "featureType": "administrative.locality", "elementType": "labels.text.fill", "stylers": [{ "color": "#c7e0ff" }] },
  { "featureType": "administrative.province", "elementType": "labels.text.fill", "stylers": [{ "color": "#a0c4ff" }] },
  { "featureType": "landscape", "elementType": "geometry", "stylers": [{ "color": "#1d2c4d" }] },
  { "featureType": "landscape.man_made", "elementType": "geometry.fill", "stylers": [{ "color": "#263551" }] },
  { "featureType": "landscape.natural", "elementType": "geometry", "stylers": [{ "color": "#1a3646" }] },
  { "featureType": "poi", "elementType": "geometry", "stylers": [{ "color": "#283d6a" }] },
  { "featureType": "poi", "elementType": "labels.text.fill", "stylers": [{ "color": "#6f9ba5" }] },
  { "featureType": "poi", "elementType": "labels.icon", "stylers": [{ "visibility": "on" }] },
  { "featureType": "poi.park", "elementType": "geometry.fill", "stylers": [{ "color": "#1f3d2e" }] },
  { "featureType": "poi.park", "elementType": "labels.text.fill", "stylers": [{ "color": "#3C7680" }] },
  { "featureType": "poi.business", "elementType": "labels", "stylers": [{ "visibility": "on" }] },
  { "featureType": "road", "elementType": "geometry", "stylers": [{ "color": "#304a7d" }] },
  { "featureType": "road", "elementType": "labels.text.fill", "stylers": [{ "color": "#98a5be" }] },
  { "featureType": "road", "elementType": "labels.text.stroke", "stylers": [{ "color": "#1d2c4d" }] },
  { "featureType": "road.arterial", "elementType": "geometry", "stylers": [{ "color": "#3a5491" }] },
  { "featureType": "road.highway", "elementType": "geometry", "stylers": [{ "color": "#3c67a5" }] },
  { "featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [{ "color": "#255763" }] },
  { "featureType": "road.highway.controlled_access", "elementType": "geometry", "stylers": [{ "color": "#2a5ea6" }] },
  { "featureType": "road.local", "elementType": "labels.text.fill", "stylers": [{ "color": "#7a8ea9" }] },
  { "featureType": "transit", "elementType": "labels.text.fill", "stylers": [{ "color": "#98a5be" }] },
  { "featureType": "transit", "elementType": "labels.icon", "stylers": [{ "visibility": "on" }] },
  { "featureType": "transit.line", "elementType": "geometry.fill", "stylers": [{ "color": "#283d6a" }] },
  { "featureType": "transit.station", "elementType": "geometry", "stylers": [{ "color": "#3a4762" }] },
  { "featureType": "water", "elementType": "geometry", "stylers": [{ "color": "#0e1626" }] },
  { "featureType": "water", "elementType": "labels.text.fill", "stylers": [{ "color": "#4e6d70" }] }
]
''';

// ─── Custom red teardrop marker with white inner dot (unchanged) ────────────
Future<BitmapDescriptor> _buildCustomMarker({int size = 120}) async {
  final ui.PictureRecorder recorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(recorder);

  final double w = size.toDouble();
  final double pinW = w * 0.54;
  final double radius = pinW / 2;
  final double cx = w / 2;
  final double topY = w * 0.05;
  final double tipY = w * 0.88;
  final double circleCY = topY + radius;

  canvas.drawOval(
    Rect.fromCenter(
      center: Offset(cx, tipY + 6),
      width: pinW * 0.65,
      height: 9,
    ),
    Paint()
      ..color = Colors.black.withOpacity(0.30)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
  );

  final Path path = Path()
    ..addOval(Rect.fromLTWH(cx - radius, topY, pinW, pinW))
    ..moveTo(cx - radius * 0.42, circleCY + radius * 0.52)
    ..quadraticBezierTo(cx, tipY, cx, tipY)
    ..quadraticBezierTo(cx, tipY, cx + radius * 0.42, circleCY + radius * 0.52)
    ..close();

  canvas.drawPath(
    path,
    Paint()
      ..color = const Color(0xFFE53935)
      ..style = PaintingStyle.fill,
  );
  canvas.drawPath(
    path,
    Paint()
      ..color = Colors.black.withOpacity(0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5,
  );

  canvas.drawCircle(
    Offset(cx, circleCY),
    radius * 0.36,
    Paint()..color = Colors.white,
  );

  final ui.Image img = await recorder.endRecording().toImage(size, size);
  final ByteData? bytes = await img.toByteData(format: ui.ImageByteFormat.png);
  return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
}

// ─────────────────────────────────────────────────────────────────────────────
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNavIndex = -1;
  bool _bookingsSheetOpen = false;

  // Map
  GoogleMapController? _mapController;
  bool _mapLoading = true;
  static const CameraPosition _initialCamera = CameraPosition(
    target: LatLng(20.0, 0.0),
    zoom: 2.0,
  );
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  BitmapDescriptor? _customMarkerIcon;

  LatLng? _userLatLng;
  bool _locating = false;
  StreamSubscription<Position>? _locationStream;

  bool _fetchingRoute = false;
  static const LatLng _demoDestination = LatLng(33.1480, 72.7850);

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _buildCustomMarker().then((icon) {
      if (mounted) setState(() => _customMarkerIcon = icon);
    });
  }

  @override
  void dispose() {
    _locationStream?.cancel();
    _mapController?.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
    try {
      await controller.setMapStyle(_kDarkMapStyle);
    } catch (e) {
      debugPrint('Map style error: $e');
    }
    if (mounted) setState(() => _mapLoading = false);
    await _startLiveTracking();
  }

  Future<void> _startLiveTracking() async {
    if (_locating) return;
    if (mounted) setState(() => _locating = true);
    try {
      bool ok = await Geolocator.isLocationServiceEnabled();
      if (!ok) {
        _showSnack('Location services disabled.');
        if (mounted) setState(() => _locating = false);
        return;
      }
      LocationPermission perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied)
        perm = await Geolocator.requestPermission();
      if (perm == LocationPermission.denied ||
          perm == LocationPermission.deniedForever) {
        _showSnack('Location permission denied.');
        if (mounted) setState(() => _locating = false);
        return;
      }
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      _updateUserMarker(LatLng(pos.latitude, pos.longitude), flyCamera: true);
      if (mounted) setState(() => _locating = false);

      _locationStream =
          Geolocator.getPositionStream(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.high,
              distanceFilter: 5,
            ),
          ).listen(
            (p) => _updateUserMarker(LatLng(p.latitude, p.longitude)),
            onError: (e) => debugPrint('GPS stream: $e'),
          );
    } catch (e) {
      _showSnack('Could not get location: $e');
      if (mounted) setState(() => _locating = false);
    }
  }

  void _updateUserMarker(LatLng pos, {bool flyCamera = false}) {
    if (!mounted) return;
    _userLatLng = pos;
    final icon =
        _customMarkerIcon ??
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    setState(() {
      _markers.removeWhere((m) => m.markerId.value == 'current_location');
      _markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: pos,
          icon: icon,
          anchor: const Offset(0.5, 1.0),
          infoWindow: const InfoWindow(title: 'You are here'),
          zIndex: 2,
        ),
      );
    });
    if (flyCamera && _mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(target: pos, zoom: 15.5)),
      );
    }
  }

  Future<void> _centerOnUser() async {
    if (_userLatLng != null) {
      await _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _userLatLng!, zoom: 15.5),
        ),
      );
    } else {
      await _startLiveTracking();
    }
  }

  void _addDestinationMarker(LatLng dest) {
    setState(() {
      _markers.removeWhere((m) => m.markerId.value == 'destination');
      _markers.add(
        Marker(
          markerId: const MarkerId('destination'),
          position: dest,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueOrange,
          ),
          infoWindow: const InfoWindow(title: 'Destination'),
          zIndex: 1,
        ),
      );
    });
  }

  Future<void> fetchAndDrawRoute(LatLng origin, LatLng dest) async {
    if (_fetchingRoute) return;
    setState(() => _fetchingRoute = true);
    _addDestinationMarker(dest);
    try {
      const key = 'AIzaSyD3Tw1rkB9PWTx_7vRUrGvgQfxIrBbNYkg';
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json'
        '?origin=${origin.latitude},${origin.longitude}'
        '&destination=${dest.latitude},${dest.longitude}'
        '&mode=driving&key=$key',
      );
      final resp = await http.get(url);
      if (resp.statusCode != 200) throw Exception('HTTP ${resp.statusCode}');
      final data = jsonDecode(resp.body) as Map<String, dynamic>;
      if (data['status'] != 'OK') throw Exception('${data['status']}');

      final points = (decodePolyline(
        data['routes'][0]['overview_polyline']['points'] as String,
      )).map((p) => LatLng(p[0].toDouble(), p[1].toDouble())).toList();

      setState(() {
        _polylines
          ..clear()
          ..add(
            Polyline(
              polylineId: const PolylineId('route'),
              points: points,
              color: const Color(0xFF4FC3F7),
              width: 5,
              patterns: [PatternItem.dash(20), PatternItem.gap(8)],
              startCap: Cap.roundCap,
              endCap: Cap.roundCap,
              jointType: JointType.round,
            ),
          );
      });
      await _mapController?.animateCamera(
        CameraUpdate.newLatLngBounds(_boundsFrom([origin, dest]), 80),
      );
    } catch (e) {
      _showSnack('Could not fetch route: $e');
    } finally {
      if (mounted) setState(() => _fetchingRoute = false);
    }
  }

  void _clearRoute() {
    setState(() {
      _polylines.clear();
      _markers.removeWhere((m) => m.markerId.value == 'destination');
    });
    if (_userLatLng != null)
      _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _userLatLng!, zoom: 15.5),
        ),
      );
  }

  LatLngBounds _boundsFrom(List<LatLng> pts) {
    double n = pts.first.latitude, s = n, e = pts.first.longitude, w = e;
    for (final p in pts) {
      if (p.latitude > n) n = p.latitude;
      if (p.latitude < s) s = p.latitude;
      if (p.longitude > e) e = p.longitude;
      if (p.longitude < w) w = p.longitude;
    }
    return LatLngBounds(southwest: LatLng(s, w), northeast: LatLng(n, e));
  }

  void _showSnack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.black87,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 100),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _handleNavigate() {
    if (_userLatLng != null) {
      fetchAndDrawRoute(_userLatLng!, _demoDestination);
    } else {
      _showSnack('Getting your location…');
      _startLiveTracking().then((_) {
        if (_userLatLng != null)
          fetchAndDrawRoute(_userLatLng!, _demoDestination);
      });
    }
  }

  void _openSheet(int index) {
    // ✅ RIDE BOTTOM SHEET - Shows RideBottomSheet
    if (index == 0) {
      setState(() => _bookingsSheetOpen = true);
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => DraggableScrollableSheet(
          initialChildSize: 0.50,
          minChildSize: 0.36,
          maxChildSize: 0.92,
          snap: true,
          snapSizes: const [0.36, 0.50, 0.92],
          builder: (ctx, sc) => RideBottomSheet(scrollController: sc),
        ),
      ).then((_) {
        if (mounted)
          setState(() {
            _selectedNavIndex = -1;
            _bookingsSheetOpen = false;
          });
      });
      return;
    }

    Widget Function(ScrollController) builder;
    switch (index) {
      case 1:
        builder = (sc) => ChatBottomSheet(scrollController: sc);
        break;
      case 2:
        builder = (sc) => BookingLoadingBottomSheet(scrollController: sc);
        break;
      default:
        builder = (sc) => ProfileBottomSheet(scrollController: sc);
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        snap: true,
        snapSizes: const [0.5, 0.85, 0.95],
        builder: (ctx, sc) => builder(sc),
      ),
    ).then((_) {
      if (mounted) setState(() => _selectedNavIndex = -1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarH = MediaQuery.of(context).padding.top;
    final double navBarH = 80.0;
    final double pillBottomClosed = navBarH + 16;
    final double pillRightClosed = 16;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: _initialCamera,
              markers: _markers,
              polylines: _polylines,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              zoomGesturesEnabled: true,
              scrollGesturesEnabled: true,
              rotateGesturesEnabled: true,
              tiltGesturesEnabled: true,
              compassEnabled: false,
              mapToolbarEnabled: false,
              trafficEnabled: false,
              buildingsEnabled: true,
              indoorViewEnabled: true,
              mapType: MapType.normal,
              padding: EdgeInsets.only(bottom: navBarH),
              onTap: (LatLng tapped) {
                if (_userLatLng != null)
                  fetchAndDrawRoute(_userLatLng!, tapped);
              },
            ),
          ),
          if (_mapLoading)
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  color: const Color(0xFF1d2c4d),
                  child: const Center(
                    child: CircularProgressIndicator(color: Color(0xFF4FC3F7)),
                  ),
                ),
              ),
            ),
          // ── Search bar at top ─────────────────────────────────────────
          Positioned(
            top: statusBarH + 12,
            left: 16,
            right: 16,
            child: _SearchBar(),
          ),
          // Route badges (unchanged)
          if (_fetchingRoute)
            Positioned(
              top: statusBarH + 76,
              left: 0,
              right: 0,
              child: Center(
                child: _GlassBadge(label: 'Finding route…', loading: true),
              ),
            ),
          if (_polylines.isNotEmpty && !_fetchingRoute)
            Positioned(
              top: statusBarH + 76,
              left: 16,
              child: _GlassBadge(
                label: 'Clear route',
                icon: Icons.close,
                onTap: _clearRoute,
              ),
            ),
          // ── Combined pill at bottom‑right (3 icons) ─────────────────────
          Positioned(
            bottom: pillBottomClosed,
            right: pillRightClosed,
            child: _CombinedPill(
              locating: _locating,
              onGpsTap: _centerOnUser,
              onNavigateTap: _handleNavigate,
              onNotificationsTap: () => _openSheet(2), // notifications sheet
            ),
          ),
        ],
      ),
      bottomNavigationBar: _HomeBottomNav(
        selectedIndex: _selectedNavIndex,
        onChanged: (v) {
          setState(() => _selectedNavIndex = v);
          _openSheet(v);
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SEARCH BAR – glassy, with hint and MAP button
// ─────────────────────────────────────────────────────────────────────────────
class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.10),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white.withOpacity(0.25), width: 1),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: Colors.white70, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Where to go...',
                    hintStyle: const TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 11,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.directions_car_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// COMBINED PILL – three icons: notifications, GPS, navigate
// ─────────────────────────────────────────────────────────────────────────────
class _CombinedPill extends StatelessWidget {
  final bool locating;
  final VoidCallback onGpsTap;
  final VoidCallback onNavigateTap;
  final VoidCallback onNotificationsTap;

  const _CombinedPill({
    required this.locating,
    required this.onGpsTap,
    required this.onNavigateTap,
    required this.onNotificationsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white.withOpacity(0.20),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.30),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Notifications
                Container(
                  width: 26,
                  height: 1,
                  color: Colors.white.withOpacity(0.20),
                ),
                // GPS
                GestureDetector(
                  onTap: onGpsTap,
                  child: SizedBox(
                    width: 48,
                    height: 48,
                    child: Center(
                      child: locating
                          ? const SizedBox(
                              width: 19,
                              height: 19,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(
                              Icons.gps_fixed,
                              color: Colors.white,
                              size: 22,
                            ),
                    ),
                  ),
                ),
                Container(
                  width: 26,
                  height: 1,
                  color: Colors.white.withOpacity(0.20),
                ),
                // Navigate
                GestureDetector(
                  onTap: onNavigateTap,
                  child: const SizedBox(
                    width: 48,
                    height: 48,
                    child: Center(
                      child: Icon(
                        Icons.near_me_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// BOTTOM NAVIGATION BAR – dark icons/text, centered, no overflow
// ─────────────────────────────────────────────────────────────────────────────
class _HomeBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const _HomeBottomNav({required this.selectedIndex, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 17),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(
                0.58,
              ), // bright white for dark text
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: Colors.white.withOpacity(0.7),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    _NItem(
                      0,
                      Icons.directions_car_rounded,
                      'Ride',
                      selectedIndex,
                      onChanged,
                    ),
                    _NItem(
                      1,
                      Icons.support_agent_rounded,
                      'Support',
                      selectedIndex,
                      onChanged,
                    ),
                    _NItem(
                      2,
                      Icons.receipt_long_rounded,
                      'Bookings',
                      selectedIndex,
                      onChanged,
                    ),
                    _NItem(
                      3,
                      Icons.person_outline_rounded,
                      'Account',
                      selectedIndex,
                      onChanged,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final String label;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const _NItem(
    this.index,
    this.icon,
    this.label,
    this.selectedIndex,
    this.onChanged,
  );

  @override
  Widget build(BuildContext context) {
    final bool active = selectedIndex == index;
    final Color iconColor = active
        ? const Color(0xFFE53935) // red when active
        : const ui.Color.fromARGB(
            255,
            24,
            30,
            36,
          ); // dark blue‑grey when inactive
    final Color labelColor = active
        ? const Color(0xFFE53935)
        : const ui.Color.fromARGB(255, 24, 30, 36);

    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(index),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 1,
          ), // reduced to prevent overflow
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor, size: 24),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  color: labelColor,
                  fontSize: 12,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// GLASS BADGE – route loading / clear-route indicator
// ─────────────────────────────────────────────────────────────────────────────
class _GlassBadge extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool loading;
  final VoidCallback? onTap;

  const _GlassBadge({
    required this.label,
    this.icon,
    this.loading = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.20),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.12)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (loading)
                  const SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                else if (icon != null)
                  Icon(icon, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
