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

// ─── Dark map style (enhanced with more details) ────────────────────────────
const String _kDarkMapStyle = '''
[
  { "elementType": "geometry", "stylers": [{ "color": "#1a1a1a" }] },
  { "elementType": "labels.text.fill", "stylers": [{ "color": "#aaaaaa" }] },
  { "elementType": "labels.text.stroke", "stylers": [{ "color": "#1a1a1a" }] },
  { "featureType": "administrative", "elementType": "geometry", "stylers": [{ "color": "#2a2a2a" }] },
  { "featureType": "administrative", "elementType": "labels.text.fill", "stylers": [{ "color": "#cccccc" }] },
  { "featureType": "administrative.country", "elementType": "labels.text.fill", "stylers": [{ "color": "#ffffff" }] },
  { "featureType": "administrative.locality", "elementType": "labels.text.fill", "stylers": [{ "color": "#bbbbbb" }] },
  { "featureType": "administrative.province", "elementType": "labels.text.fill", "stylers": [{ "color": "#aaaaaa" }] },
  { "featureType": "landscape", "elementType": "geometry", "stylers": [{ "color": "#1a1a1a" }] },
  { "featureType": "landscape.man_made", "elementType": "geometry.fill", "stylers": [{ "color": "#232323" }] },
  { "featureType": "landscape.natural", "elementType": "geometry", "stylers": [{ "color": "#161616" }] },
  { "featureType": "poi", "elementType": "geometry", "stylers": [{ "color": "#2a2a2a" }] },
  { "featureType": "poi", "elementType": "labels.text.fill", "stylers": [{ "color": "#888888" }] },
  { "featureType": "poi", "elementType": "labels.icon", "stylers": [{ "visibility": "on" }] },
  { "featureType": "poi.attraction", "elementType": "labels.text.fill", "stylers": [{ "color": "#999999" }] },
  { "featureType": "poi.business", "elementType": "labels.text.fill", "stylers": [{ "color": "#999999" }] },
  { "featureType": "poi.government", "elementType": "labels.text.fill", "stylers": [{ "color": "#999999" }] },
  { "featureType": "poi.medical", "elementType": "labels.text.fill", "stylers": [{ "color": "#999999" }] },
  { "featureType": "poi.park", "elementType": "geometry.fill", "stylers": [{ "color": "#1f3d2e" }] },
  { "featureType": "poi.park", "elementType": "labels.text.fill", "stylers": [{ "color": "#7db89a" }] },
  { "featureType": "poi.place_of_worship", "elementType": "labels.text.fill", "stylers": [{ "color": "#999999" }] },
  { "featureType": "poi.school", "elementType": "labels.text.fill", "stylers": [{ "color": "#999999" }] },
  { "featureType": "road", "elementType": "geometry", "stylers": [{ "color": "#3a3a3a" }] },
  { "featureType": "road", "elementType": "labels.text.fill", "stylers": [{ "color": "#888888" }] },
  { "featureType": "road", "elementType": "labels.text.stroke", "stylers": [{ "color": "#1a1a1a" }] },
  { "featureType": "road.arterial", "elementType": "geometry", "stylers": [{ "color": "#414141" }] },
  { "featureType": "road.highway", "elementType": "geometry", "stylers": [{ "color": "#4a4a4a" }] },
  { "featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [{ "color": "#2a2a2a" }] },
  { "featureType": "road.highway.controlled_access", "elementType": "geometry", "stylers": [{ "color": "#474747" }] },
  { "featureType": "road.local", "elementType": "labels.text.fill", "stylers": [{ "color": "#777777" }] },
  { "featureType": "transit", "elementType": "labels.text.fill", "stylers": [{ "color": "#888888" }] },
  { "featureType": "transit", "elementType": "labels.icon", "stylers": [{ "visibility": "on" }] },
  { "featureType": "transit.line", "elementType": "geometry.fill", "stylers": [{ "color": "#2a2a2a" }] },
  { "featureType": "transit.station", "elementType": "geometry", "stylers": [{ "color": "#323232" }] },
  { "featureType": "water", "elementType": "geometry", "stylers": [{ "color": "#0f0f0f" }] },
  { "featureType": "water", "elementType": "labels.text.fill", "stylers": [{ "color": "#555555" }] }
]
''';

// ─────────────────────────────────────────────────────────────────────────────
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNavIndex = -1;
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
  List<SearchResult> _searchResults = [];
  bool _searching = false;
  bool _showSearchResults = false;

  static const double _kNavH = 80.0;

  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/images/pointer.png',
    ).then((icon) {
      if (mounted) setState(() => _customMarkerIcon = icon);
    });

    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_searchController.text.isEmpty) {
      setState(() {
        _searchResults = [];
        _showSearchResults = false;
      });
      return;
    }
    _performPlaceSearch(_searchController.text);
  }

  Future<void> _performPlaceSearch(String query) async {
    if (query.isEmpty) return;
    
    setState(() => _searching = true);
    try {
      const key = 'AIzaSyD3Tw1rkB9PWTx_7vRUrGvgQfxIrBbNYkg';
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json'
        '?input=$query'
        '&key=$key'
        '${_userLatLng != null ? '&location=${_userLatLng!.latitude},${_userLatLng!.longitude}&radius=50000' : ''}',
      );
      
      final resp = await http.get(url);
      if (resp.statusCode != 200) throw Exception('HTTP ${resp.statusCode}');
      
      final data = jsonDecode(resp.body) as Map<String, dynamic>;
      final predictions = (data['predictions'] as List?)?.cast<Map<String, dynamic>>() ?? [];
      
      setState(() {
        _searchResults = predictions
            .map((p) => SearchResult(
              placeId: p['place_id'] as String? ?? '',
              mainText: p['main_text'] as String? ?? '',
              secondaryText: p['secondary_text'] as String? ?? '',
            ))
            .toList();
        _showSearchResults = true;
      });
    } catch (e) {
      _showSnack('Search error: $e');
    } finally {
      if (mounted) setState(() => _searching = false);
    }
  }

  Future<void> _getPlaceDetails(String placeId) async {
    try {
      const key = 'AIzaSyD3Tw1rkB9PWTx_7vRUrGvgQfxIrBbNYkg';
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json'
        '?place_id=$placeId'
        '&fields=geometry'
        '&key=$key',
      );
      
      final resp = await http.get(url);
      if (resp.statusCode != 200) throw Exception('HTTP ${resp.statusCode}');
      
      final data = jsonDecode(resp.body) as Map<String, dynamic>;
      final location = data['result']['geometry']['location'] as Map<String, dynamic>;
      final lat = location['lat'] as double;
      final lng = location['lng'] as double;
      
      final dest = LatLng(lat, lng);
      
      if (_userLatLng != null) {
        fetchAndDrawRoute(_userLatLng!, dest);
      } else {
        await _startLiveTracking();
        if (_userLatLng != null) {
          fetchAndDrawRoute(_userLatLng!, dest);
        }
      }
      
      setState(() {
        _showSearchResults = false;
        _searchController.clear();
      });
    } catch (e) {
      _showSnack('Could not get place details: $e');
    }
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

  void _openMainSheet(int index) {
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
              trafficEnabled: true,
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
                  color: const Color(0xFF1a1a1a),
                  child: const Center(
                    child: CircularProgressIndicator(color: Color(0xFF4FC3F7)),
                  ),
                ),
              ),
            ),

          // ── 3. SEARCH BAR WITH RESULTS ─────────────────────────────────
          Positioned(
            top: statusBarH + 12,
            left: 16,
            right: 16,
            child: Column(
              children: [
                _TopSearchBar(
                  controller: _searchController,
                  searching: _searching,
                ),
                if (_showSearchResults && _searchResults.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.15),
                        width: 1,
                      ),
                    ),
                    constraints: const BoxConstraints(maxHeight: 300),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _searchResults.length,
                      itemBuilder: (ctx, i) {
                        final result = _searchResults[i];
                        return GestureDetector(
                          onTap: () => _getPlaceDetails(result.placeId),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              border: i < _searchResults.length - 1
                                  ? Border(
                                      bottom: BorderSide(
                                        color: Colors.white.withOpacity(0.1),
                                        width: 0.5,
                                      ),
                                    )
                                  : null,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  result.mainText,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (result.secondaryText.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      result.secondaryText,
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                        fontSize: 12,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),

          // Route badges
          if (_fetchingRoute)
            Positioned(
              top: statusBarH + 130,
              left: 0,
              right: 0,
              child: Center(
                child: _GlassBadge(label: 'Finding route…', loading: true),
              ),
            ),
          if (_polylines.isNotEmpty && !_fetchingRoute)
            Positioned(
              top: statusBarH + 130,
              left: 16,
              child: _GlassBadge(
                label: 'Clear route',
                icon: Icons.close,
                onTap: _clearRoute,
              ),
            ),

          // ── 5. GPS + NAVIGATE PILL ─────────────────────────────────────
          Positioned(
            bottom: navBarH + 28,
            right: 16,
            child: _CombinedPill(
              locating: _locating,
              onGpsTap: _centerOnUser,
              onNavigateTap: _handleNavigate,
              onNotificationsTap: () => _openSheet(2),
            ),
          ),
        ],
      ),

      bottomNavigationBar: RidenBottomNav(
        selectedIndex: _selectedNavIndex,
        isFromSheet: false,
        onChanged: (v) {
          setState(() => _selectedNavIndex = v);
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
      case 1:
        builder = (sc) => ChatBottomSheet(scrollController: sc);
        break;
      case 2:
        builder = (sc) => NotificationsBottomSheet(scrollController: sc);
        break;
      case 3:
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
// SEARCH RESULT MODEL
// ─────────────────────────────────────────────────────────────────────────────
class SearchResult {
  final String placeId;
  final String mainText;
  final String secondaryText;

  SearchResult({
    required this.placeId,
    required this.mainText,
    required this.secondaryText,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// SEARCH BAR WITH AUTOCOMPLETE
// ─────────────────────────────────────────────────────────────────────────────
class _TopSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final bool searching;

  const _TopSearchBar({
    required this.controller,
    this.searching = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.40),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.white.withOpacity(0.20), width: 1),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Where to go...',
                    hintStyle: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              if (searching)
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
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
// COMBINED PILL — GPS + Navigate
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
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white.withOpacity(0.20), width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
                color: Colors.white.withOpacity(0.15),
              ),
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
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
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