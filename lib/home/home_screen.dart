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
import 'package:Riden/widgets/riden_bottom_nav.dart';
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

// ─── Custom red teardrop marker ──────────────────────(unchanged) ────────────
// _buildCustomMarker function was here. Now it's replaced by pointer.png asset.

// ─────────────────────────────────────────────────────────────────────────────
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNavIndex = -1;

  // ── Tracks whether the bookings sheet is open (used only for sheet state) ──
  bool _bookingsSheetOpen = false;

  // ── Map ───────────────────────────────────────────────────────────────────
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

  // ── nav bar height — used to position sheet & pill ───────────────────────
  static const double _kNavH = 80.0;

  @override
  void initState() {
    super.initState();
    // Use pointer.png from assets
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/images/pointer.png',
    ).then((icon) {
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

  // ─── map ────────────────────────────────────────────────────────────────
  Future<void> _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
    try {
      await controller.setMapStyle(_kDarkMapStyle);
    } catch (e) {
      debugPrint('Map style: $e');
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
            onError: (e) => debugPrint('GPS: $e'),
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

  // Duplicate _handleNavigate removed to resolve naming conflict.

  void _openMainSheet(int index) {
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
    final double navBarH = 80.0; // approx height of floating nav bar

    // Pill is always at bottom-right, above the nav bar
    final double pillBottomClosed = navBarH + 16;
    final double pillRightClosed = 16;

    return Scaffold(
      backgroundColor: Colors.black,
      // No bottomNavigationBar here — nav bar lives in the Stack below
      // so it always renders above the sheet route.
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── 1. MAP ────────────────────────────────────────────────────
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

          // ── 2. LOADING OVERLAY ────────────────────────────────────────
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

          // ── 3. SEARCH BAR ──────────────────────────────────────────────
          Positioned(
            top: statusBarH + 12,
            left: 16,
            right: 16,
            child: _TopSearchBar(controller: _searchController),
          ),
          // Route badges (unchanged)─
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

          // ── 5. GPS + NAVIGATE PILL ─────────────────────────────────────
          // ── Combined pill at bottom‑right (3 icons) ─────────────────────
          Positioned(
            bottom: navBarH + 28, // INCREASED GAP HERE (was + 8)
            right: 16,
            child: _CombinedPill(
              locating: _locating,
              onGpsTap: _centerOnUser,
              onNavigateTap: _handleNavigate,
              onNotificationsTap: () => _openSheet(2), // notifications sheet
            ),
          ),
        ],
      ),

      // BOTTOM NAV — Standardized RidenBottomNav
      bottomNavigationBar: RidenBottomNav(
        selectedIndex: _selectedNavIndex,
        isFromSheet: false,
        onChanged: (v) {
          setState(() => _selectedNavIndex = v);
          // Redundant _openMainSheet call removed.
          // RidenBottomNav now handles its own navigation autonomously.
        },
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

  // ── Sheet launcher ────────────────────────────────────────────────────────
  void _openSheet(int index) {
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
      case 1: // Support/Chat
        builder = (sc) => ChatBottomSheet(scrollController: sc);
        break;
      case 2: // Notifications
        builder = (sc) => NotificationsBottomSheet(scrollController: sc);
        break;
      case 3: // Account/Profile
        builder = (sc) => ProfileBottomSheet(scrollController: sc);
        break;
      default:
        return;
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
}

// ─────────────────────────────────────────────────────────────────────────────
// SEARCH BAR — full-pill frosted glass (dark, for map overlay)
// ─────────────────────────────────────────────────────────────────────────────
class _TopSearchBar extends StatelessWidget {
  final TextEditingController controller;
  const _TopSearchBar({required this.controller});

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
// COMBINED PILL — GPS + Navigate in one frosted-glass pill
// Always positioned at bottom-right above nav bar
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white.withOpacity(0.20), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.20),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // GPS button
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
              // Divider
              Container(
                width: 26,
                height: 1,
                color: Colors.white.withOpacity(0.20),
              ),
              // Navigate button
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
    );
  }
}



// ─────────────────────────────────────────────────────────────────────────────
// GLASS BADGE — route loading / clear-route indicator
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
