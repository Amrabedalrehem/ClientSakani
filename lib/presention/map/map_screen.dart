import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/const/HomeConst.dart';
import 'package:flutter_application_1/core/dp/HiveService.dart';
import 'package:flutter_application_1/data/repo/SavedRepository.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/presention/detail/property_detail_screen.dart';
import 'package:flutter_application_1/presention/map/component/MapAppBar.dart';
import 'package:flutter_application_1/presention/map/component/map_legend.dart';
import 'package:flutter_application_1/presention/map/component/property_card.dart';
import 'package:flutter_application_1/presention/map/cubit/map_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const CameraPosition _fallbackCamera = CameraPosition(
    target: LatLng(30.0444, 31.2357),
    zoom: 11,
  );

  static const String _darkMapStyle = '''
[
  {"elementType":"geometry","stylers":[{"color":"#242f3e"}]},
  {"elementType":"labels.text.fill","stylers":[{"color":"#746855"}]},
  {"elementType":"labels.text.stroke","stylers":[{"color":"#242f3e"}]},
  {"featureType":"administrative.locality","elementType":"labels.text.fill","stylers":[{"color":"#d59563"}]},
  {"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#d59563"}]},
  {"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#263c3f"}]},
  {"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#6b9a76"}]},
  {"featureType":"road","elementType":"geometry","stylers":[{"color":"#38414e"}]},
  {"featureType":"road","elementType":"geometry.stroke","stylers":[{"color":"#212a37"}]},
  {"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#9ca5b3"}]},
  {"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#746855"}]},
  {"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#1f2835"}]},
  {"featureType":"road.highway","elementType":"labels.text.fill","stylers":[{"color":"#f3d19c"}]},
  {"featureType":"transit","elementType":"geometry","stylers":[{"color":"#2f3948"}]},
  {"featureType":"transit.station","elementType":"labels.text.fill","stylers":[{"color":"#d59563"}]},
  {"featureType":"water","elementType":"geometry","stylers":[{"color":"#17263c"}]},
  {"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#515c6d"}]},
  {"featureType":"water","elementType":"labels.text.stroke","stylers":[{"color":"#17263c"}]}
]
''';

  final SavedRepository _repo = SavedRepository();
  late final Future<List<PropertyModel>> _propertiesFuture;
  GoogleMapController? _mapController;
  List<PropertyModel> _latestVisibleProperties = const [];
  String? _lastCameraSignature;

  @override
  void initState() {
    super.initState();
    _propertiesFuture = _repo.getApartments();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        return FutureBuilder<List<PropertyModel>>(
          future: _propertiesFuture,
          builder: (context, snapshot) {
            final appBar = MapAppBar(
              isSavedOnly: state.showSavedOnly,
              onToggle: context.read<MapCubit>().toggleSavedOnly,
            );

            if (snapshot.connectionState != ConnectionState.done) {
              if (!state.showSavedOnly) {
                return Scaffold(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  appBar: appBar,
                  body: const Center(child: CircularProgressIndicator()),
                );
              }
            }

            if (snapshot.hasError && !state.showSavedOnly) {
              return Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                appBar: appBar,
                body: Center(
                  child: Text(
                    AppLocalizations.of(context)?.failedToLoad ?? 'Failed to load properties',
                    style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                  ),
                ),
              );
            }

            final allProperties = state.showSavedOnly
                ? _repo.getSavedProperties()
                : snapshot.data ?? [];

            return ValueListenableBuilder<Box<String>>(
              valueListenable: HiveService.savedBox.listenable(),
              builder: (context, _, __) {
                final savedIds = _repo.getSavedIds();
                final visibleProperties = allProperties;

                _latestVisibleProperties = visibleProperties;
                _scheduleCameraFit(visibleProperties);

                final markers = visibleProperties.map((property) {
                  final isSaved = savedIds.contains(property.id);
                  final isSelected = state.selectedProperty?.id == property.id;
                  return Marker(
                    markerId: MarkerId(property.id),
                    position: LatLng(property.lat, property.lng),
                    infoWindow: InfoWindow.noText,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      _markerHue(isSaved: isSaved, isSelected: isSelected),
                    ),
                    onTap: () => context.read<MapCubit>().selectProperty(property),
                  );
                }).toSet();

                return Scaffold(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  appBar: appBar,
                  body: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition: _fallbackCamera,
                        mapType: MapType.normal,
                        style: isDark ? _darkMapStyle : null,
                        myLocationButtonEnabled: false,
                        myLocationEnabled: false,
                        zoomControlsEnabled: false,
                        compassEnabled: false,
                        mapToolbarEnabled: false,
                        markers: markers,
                        onTap: (LatLng _) => context.read<MapCubit>().selectProperty(null),
                        onMapCreated: _onMapCreated,
                      ),
                      if (state.selectedProperty != null)
                        Positioned(
                          bottom: 16.h,
                          left: 16.w,
                          right: 16.w,
                          child: PropertyCard(
                            property: state.selectedProperty!,
                            isSaved: savedIds.contains(state.selectedProperty!.id),
                            onClose: () => context.read<MapCubit>().selectProperty(null),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PropertyDetailScreen(
                                  property: state.selectedProperty!,
                                ),
                              ),
                            ),
                          ),
                        ),
                      Positioned(
                        top: 12.h,
                        right: 16.w,
                        child: const MapLegend(),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _fitCamera(_latestVisibleProperties);
  }

  void _scheduleCameraFit(List<PropertyModel> visibleProperties) {
    final signature = '${visibleProperties.map((e) => e.id).join(",")}';
    if (signature == _lastCameraSignature) return;
    _lastCameraSignature = signature;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _fitCamera(visibleProperties);
    });
  }

  Future<void> _fitCamera(List<PropertyModel> visibleProperties) async {
    final controller = _mapController;
    if (controller == null || !mounted) return;

    try {
      if (visibleProperties.isEmpty) {
        await controller.animateCamera(
          CameraUpdate.newCameraPosition(_fallbackCamera),
        );
        return;
      }

      final points = visibleProperties
          .map((p) => LatLng(p.lat, p.lng))
          .toList(growable: false);

      if (points.length == 1 || _allPointsEqual(points)) {
        await controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: points.first,
              zoom: 13,
            ),
          ),
        );
        return;
      }

      await controller.animateCamera(
        CameraUpdate.newLatLngBounds(_boundsFromPoints(points), 72.0),
      );
    } catch (_) {
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(_fallbackCamera),
      );
    }
  }

  bool _allPointsEqual(List<LatLng> points) {
    final first = points.first;
    return points.every(
      (point) => point.latitude == first.latitude && point.longitude == first.longitude,
    );
  }

  LatLngBounds _boundsFromPoints(List<LatLng> points) {
    double south = points.first.latitude;
    double west = points.first.longitude;
    double north = points.first.latitude;
    double east = points.first.longitude;

    for (final point in points.skip(1)) {
      if (point.latitude < south) south = point.latitude;
      if (point.latitude > north) north = point.latitude;
      if (point.longitude < west) west = point.longitude;
      if (point.longitude > east) east = point.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(south, west),
      northeast: LatLng(north, east),
    );
  }

  double _markerHue({required bool isSaved, required bool isSelected}) {
    if (isSelected) return BitmapDescriptor.hueGreen;
    if (isSaved) return BitmapDescriptor.hueAzure;
    return BitmapDescriptor.hueRed;
  }
}
