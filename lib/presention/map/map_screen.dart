import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/HomeData.dart';
 import 'package:flutter_application_1/presention/map/component/filter_toggle.dart';
import 'package:flutter_application_1/presention/map/component/map_legend.dart';
import 'package:flutter_application_1/presention/map/component/property_card.dart';
import 'package:flutter_application_1/presention/map/component/property_marker.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_application_1/data/datasource/HomeDataSource.dart';
import 'package:flutter_application_1/data/repo/SavedRepository.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final SavedRepository _repo = SavedRepository();
  PropertyModel? _selectedProperty;
  bool _showSavedOnly = false;

  List<PropertyModel> get _properties {
    if (_showSavedOnly) {
      final savedIds = _repo.getSavedIds();
      return kDummyProperties
          .where((p) => savedIds.contains(p.id))
          .toList();
    }
    return kDummyProperties;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 16,
        title: const Text('Map View'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: FilterToggle(
              isSavedOnly: _showSavedOnly,
              onToggle: () => setState(() {
                _showSavedOnly = !_showSavedOnly;
                _selectedProperty = null;
              }),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: const LatLng(30.0444, 31.2357),
              initialZoom: 12,
              onTap: (_, __) =>
                  setState(() => _selectedProperty = null),
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName:
                    'com.example.flutter_application_1',
              ),
              MarkerLayer(
                markers: _properties.map((p) {
                  final isSaved = _repo.isSaved(p.id);
                  final isSelected =
                      _selectedProperty?.id == p.id;

                  return Marker(
                    point: LatLng(p.lat, p.lng),
                    width: isSelected ? 52 : 44,
                    height: isSelected ? 52 : 44,
                    child: GestureDetector(
                      onTap: () =>
                          setState(() => _selectedProperty = p),
                      child: PropertyMarker(
                        property: p,
                        isSaved: isSaved,
                        isSelected: isSelected,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          if (_selectedProperty != null)
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: PropertyCard(
                property: _selectedProperty!,
                isSaved: _repo.isSaved(_selectedProperty!.id),
                onClose: () =>
                    setState(() => _selectedProperty = null),
              ),
            ),

          const Positioned(
            top: 12,
            right: 16,
            child: MapLegend(),
          ),
        ],
      ),
    );
  }
}