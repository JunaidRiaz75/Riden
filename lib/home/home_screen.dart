// home_screen.dart
// ignore_for_file: unused_import, curly_braces_in_flow_control_structures, deprecated_member_use

import 'dart:async';
import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:riden/bookings/bookingride_loading.dart';
import 'package:riden/bookings/bookride.dart';
import 'package:riden/call_and_chat/chat_screen.dart';
import 'package:riden/home/your_locations_screen.dart';
import 'package:riden/my_profile/profilesheet.dart';
import 'package:riden/widgets/bottom_navbar.dart';
import 'package:riden/widgets/glass.dart';
import '../theme/app_colors.dart';

// ─── Dark blue map style (matches Image 1) ───────────────────────────────────
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ── Nav ──────────────────────────────────────────────────────
  int _selectedNavIndex = 0;

  // ── Map ──────────────────────────────────────────────────────
  GoogleMapController? _mapController;
  bool _mapLoading = true;

  /// Start at zoom 2 so the whole world is visible — user can then
  /// pinch-zoom, scroll, rotate and tilt freely anywhere on the globe.
  static const CameraPosition _initialCamera = CameraPosition(
    target: LatLng(20.0, 0.0),
    zoom: 2.0,
    tilt: 0,
    bearing: 0,
  );

  // ── Markers & Polylines ───────────────────────────────────────
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  // ── User location ─────────────────────────────────────────────
  LatLng? _userLatLng;
  bool _locating = false;
  StreamSubscription<Position>? _locationStream;

  // ── Route state ───────────────────────────────────────────────
  bool _fetchingRoute = false;

  static const LatLng _demoDestination = LatLng(33.1480, 72.7850);

  // ─────────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    // Style is applied inline in _onMapCreated — no file loading needed.
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;

    // Apply the dark style immediately — baked into the constant above.
    try {
      await controller.setMapStyle(_kDarkMapStyle);
    } catch (e) {
      debugPrint('Map style error: $e');
    }

    if (mounted) setState(() => _mapLoading = false);

    // Start live GPS tracking — red marker appears and camera flies to user.
    await _startLiveTracking();
  }

  // ── Continuous live GPS stream ────────────────────────────────
  Future<void> _startLiveTracking() async {
    if (_locating) return;
    if (mounted) setState(() => _locating = true);

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showSnack('Location services disabled. Please enable GPS.');
        if (mounted) setState(() => _locating = false);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showSnack('Location permission denied.');
          if (mounted) setState(() => _locating = false);
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        _showSnack(
          'Location permission permanently denied. Enable in Settings.',
        );
        if (mounted) setState(() => _locating = false);
        return;
      }

      // Immediate first fix — fly camera to user at street level.
      final Position first = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      _updateUserMarker(
        LatLng(first.latitude, first.longitude),
        flyCamera: true,
      );
      if (mounted) setState(() => _locating = false);

      // Continuous updates every 5 metres — marker moves, camera stays free.
      _locationStream =
          Geolocator.getPositionStream(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.high,
              distanceFilter: 5,
            ),
          ).listen((Position pos) {
            _updateUserMarker(
              LatLng(pos.latitude, pos.longitude),
              flyCamera: false, // user is free to pan/zoom; don't hijack camera
            );
          }, onError: (e) => debugPrint('Location stream error: $e'));
    } catch (e) {
      _showSnack('Could not get location: $e');
      if (mounted) setState(() => _locating = false);
    }
  }

  // ── Place / move the red marker (identical to Image 1) ────────
  void _updateUserMarker(LatLng pos, {bool flyCamera = false}) {
    if (!mounted) return;
    _userLatLng = pos;
    setState(() {
      _markers.removeWhere((m) => m.markerId.value == 'current_location');
      _markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: pos,
          // Pure red drop pin — exactly like Google Maps default / Image 1.
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: const InfoWindow(
            title: 'You are here',
            snippet: 'Live location',
          ),
          // Pin bottom tip sits exactly on the coordinate point.
          anchor: const Offset(0.5, 1.0),
          zIndex: 2,
        ),
      );
    });

    if (flyCamera && _mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: pos,
            zoom: 15.5, // street-level zoom matching Image 1
            tilt: 0,
            bearing: 0,
          ),
        ),
      );
    }
  }

  // ── Re-center / GPS button ────────────────────────────────────
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

  // ── Destination marker ────────────────────────────────────────
  void _addDestinationMarker(LatLng destination) {
    setState(() {
      _markers.removeWhere((m) => m.markerId.value == 'destination');
      _markers.add(
        Marker(
          markerId: const MarkerId('destination'),
          position: destination,
          infoWindow: const InfoWindow(
            title: 'Destination',
            snippet: 'Tap to navigate',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueOrange,
          ),
          zIndex: 1,
        ),
      );
    });
  }

  // ── Draw route via Directions API ─────────────────────────────
  Future<void> fetchAndDrawRoute(LatLng origin, LatLng destination) async {
    if (_fetchingRoute) return;
    setState(() => _fetchingRoute = true);

    _addDestinationMarker(destination);

    try {
      const apiKey = 'YOUR_GOOGLE_MAPS_API_KEY'; // ← replace with your key
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json'
        '?origin=${origin.latitude},${origin.longitude}'
        '&destination=${destination.latitude},${destination.longitude}'
        '&mode=driving'
        '&key=$apiKey',
      );

      final response = await http.get(url);
      if (response.statusCode != 200) {
        throw Exception('HTTP ${response.statusCode}');
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (data['status'] != 'OK') {
        throw Exception('Directions API: ${data['status']}');
      }

      final encoded =
          data['routes'][0]['overview_polyline']['points'] as String;
      final List<List<num>> decoded = decodePolyline(encoded);
      final List<LatLng> points = decoded
          .map((p) => LatLng(p[0].toDouble(), p[1].toDouble()))
          .toList();

      final LatLngBounds bounds = _boundsFromLatLngList([origin, destination]);

      setState(() {
        _polylines.clear();
        _polylines.add(
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
        CameraUpdate.newLatLngBounds(bounds, 80),
      );
    } catch (e) {
      _showSnack('Could not fetch route: $e');
    } finally {
      if (mounted) setState(() => _fetchingRoute = false);
    }
  }

  // ── Clear route ───────────────────────────────────────────────
  void _clearRoute() {
    setState(() {
      _polylines.clear();
      _markers.removeWhere((m) => m.markerId.value == 'destination');
    });
    if (_userLatLng != null) {
      _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _userLatLng!, zoom: 15.5),
        ),
      );
    }
  }

  LatLngBounds _boundsFromLatLngList(List<LatLng> list) {
    double minLat = list.first.latitude;
    double maxLat = list.first.latitude;
    double minLng = list.first.longitude;
    double maxLng = list.first.longitude;
    for (final p in list) {
      if (p.latitude < minLat) minLat = p.latitude;
      if (p.latitude > maxLat) maxLat = p.latitude;
      if (p.longitude < minLng) minLng = p.longitude;
      if (p.longitude > maxLng) maxLng = p.longitude;
    }
    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
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

  @override
  void dispose() {
    _locationStream?.cancel();
    _mapController?.dispose();
    super.dispose();
  }

  // ─────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    const double bottomNavHeight = 70.0;
    const double bottomNavBottomMargin = 16.0;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── GOOGLE MAP ────────────────────────────────────────
          Positioned.fill(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: _initialCamera,
              markers: _markers,
              polylines: _polylines,

              // ── No system blue dot — we use our own red pin ───
              myLocationEnabled: false,
              myLocationButtonEnabled: false,

              // ── ALL gestures ON ───────────────────────────────
              // These MUST all be true for full map interactivity.
              zoomControlsEnabled: false, // no ugly +/- buttons
              zoomGesturesEnabled: true, // ✅ pinch-to-zoom
              scrollGesturesEnabled: true, // ✅ drag / pan anywhere on globe
              rotateGesturesEnabled: true, // ✅ two-finger rotate
              tiltGesturesEnabled: true, // ✅ two-finger 3-D tilt
              // ── Map content — show everything ─────────────────
              compassEnabled: true,
              mapToolbarEnabled: false,
              trafficEnabled: false, // set true to show live traffic
              buildingsEnabled: true, // 3-D buildings when zoomed in
              indoorViewEnabled: true, // indoor maps in malls / airports
              // ── Normal type shows ALL labels & countries ──────
              // satellite / hybrid hide the custom dark style.
              mapType: MapType.normal,

              // ── Tap anywhere to draw a route from user ────────
              onTap: (LatLng tapped) {
                if (_userLatLng != null) {
                  fetchAndDrawRoute(_userLatLng!, tapped);
                }
              },
            ),
          ),

          // ── MAP LOADING OVERLAY ───────────────────────────────
          if (_mapLoading)
            Positioned.fill(
              child: Container(
                color: const Color(0xFF1d2c4d),
                child: const Center(
                  child: CircularProgressIndicator(color: Color(0xFF4FC3F7)),
                ),
              ),
            ),

          // ── ROUTE FETCHING BADGE ──────────────────────────────
          if (_fetchingRoute)
            Positioned(
              top: statusBarHeight + 12,
              left: 0,
              right: 0,
              child: Center(
                child: _GlassBadge(label: 'Finding route…', loading: true),
              ),
            ),

          // ── CLEAR ROUTE BADGE ─────────────────────────────────
          if (_polylines.isNotEmpty && !_fetchingRoute)
            Positioned(
              top: statusBarHeight + 12,
              left: 16,
              child: _GlassBadge(
                label: 'Clear route',
                icon: Icons.close,
                onTap: _clearRoute,
              ),
            ),

          // ── TOP-RIGHT GLASSY PILL (notifications / GPS / navigate) ──
          Positioned(
            top: statusBarHeight + 12,
            right: 16,
            child: _GlassyActionPill(
              locating: _locating,
              onNotificationTap: () {},
              onGpsTap: _centerOnUser,
              onNavigateTap: () {
                if (_userLatLng != null) {
                  fetchAndDrawRoute(_userLatLng!, _demoDestination);
                } else {
                  _showSnack('Getting your location first…');
                  _startLiveTracking().then((_) {
                    if (_userLatLng != null) {
                      fetchAndDrawRoute(_userLatLng!, _demoDestination);
                    }
                  });
                }
              },
            ),
          ),

          // ── DRAGGABLE BOTTOM SHEET ────────────────────────────
          Positioned(
            left: 0,
            right: 0,
            bottom: bottomNavHeight + bottomNavBottomMargin,
            child: DraggableScrollableSheet(
              initialChildSize: 0.15,
              minChildSize: 0.12,
              maxChildSize: 0.65,
              snap: true,
              snapSizes: const [0.15, 0.35, 0.65],
              builder: (context, scrollController) {
                return ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.21),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(28),
                          topRight: Radius.circular(28),
                        ),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.13),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Center(
                              child: Container(
                                width: 45,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(2.5),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: YourLocationsScreen(
                              scrollController: scrollController,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // ── BOTTOM NAV ────────────────────────────────────────────
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: bottomNavBottomMargin),
        child: GlassyBottomNavBar(
          currentIndex: _selectedNavIndex,
          onChanged: (int value) {
            setState(() => _selectedNavIndex = value);
            if (value == 0)
              _openRideBottomSheet(context);
            else if (value == 1)
              _openBookingBottomSheet(context);
            else if (value == 2)
              _openChatBottomSheet(context);
            else if (value == 3)
              _openProfileBottomSheet(context);
          },
        ),
      ),
    );
  }

  // ── Bottom-sheet openers ──────────────────────────────────────
  void _openRideBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        snap: true,
        snapSizes: const [0.5, 0.85, 0.95],
        builder: (context, sc) => BookRideBottomSheet(scrollController: sc),
      ),
    );
  }

  void _openBookingBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        snap: true,
        snapSizes: const [0.5, 0.85, 0.95],
        builder: (context, sc) => BookingBottomSheet(scrollController: sc),
      ),
    );
  }

  void _openChatBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        snap: true,
        snapSizes: const [0.5, 0.85, 0.95],
        builder: (context, sc) => ChatBottomSheet(scrollController: sc),
      ),
    );
  }

  void _openProfileBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        snap: true,
        snapSizes: const [0.5, 0.85, 0.95],
        builder: (context, sc) => ProfileBottomSheet(scrollController: sc),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// GLASSY ACTION PILL  (top-right: bell / GPS / navigate)
// ─────────────────────────────────────────────────────────────
class _GlassyActionPill extends StatelessWidget {
  final bool locating;
  final VoidCallback onNotificationTap;
  final VoidCallback onGpsTap;
  final VoidCallback onNavigateTap;

  const _GlassyActionPill({
    required this.locating,
    required this.onNotificationTap,
    required this.onGpsTap,
    required this.onNavigateTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassSection(
      radius: 28,
      blur: 18,
      opacity: 0.21,
      borderColor: Colors.white.withOpacity(0.13),
      child: SizedBox(
        width: 54,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _PillIconButton(
              icon: Icons.notifications_outlined,
              onTap: onNotificationTap,
            ),
            _PillIconButton(
              icon: locating ? Icons.gps_not_fixed : Icons.gps_fixed,
              onTap: onGpsTap,
              spinning: locating,
            ),
            _PillIconButton(icon: Icons.near_me_outlined, onTap: onNavigateTap),
          ],
        ),
      ),
    );
  }
}

class _PillIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool spinning;

  const _PillIconButton({
    required this.icon,
    required this.onTap,
    this.spinning = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 54,
        height: 52,
        child: spinning
            ? const Center(
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ),
              )
            : Icon(icon, color: Colors.white.withOpacity(0.91), size: 22),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// GLASS BADGE  (route loading / clear route)
// ─────────────────────────────────────────────────────────────
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
              color: Colors.white.withOpacity(0.21),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.13)),
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
