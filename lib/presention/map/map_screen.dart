import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/const/HomeConst.dart';
import 'package:flutter_application_1/data/repo/SavedRepository.dart';
import 'package:flutter_application_1/presention/detail/property_detail_screen.dart';
import 'package:flutter_application_1/presention/map/component/filter_toggle.dart';
import 'package:flutter_application_1/presention/map/component/map_legend.dart';
import 'package:flutter_application_1/presention/map/component/property_card.dart';
import 'package:flutter_application_1/presention/map/component/property_marker.dart';
import 'package:flutter_application_1/presention/map/cubit/map_cubit.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  final List<PropertyModel> properties;
  const MapScreen({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
     return const _MapView();
  }
}

class _MapView extends StatelessWidget {
  const _MapView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MapCubit>();
    final repo = SavedRepository();

    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
         final allProperties =
            (context.findAncestorWidgetOfExactType<MapScreen>())?.properties ??
                [];

        final visibleProperties = state.showSavedOnly
            ? allProperties
                .where((p) => repo.getSavedIds().contains(p.id))
                .toList()
            : allProperties;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            elevation: 0,
            scrolledUnderElevation: 0,
            titleSpacing: 16,
            title: const Text('Map View'),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: FilterToggle(
                  isSavedOnly: state.showSavedOnly,
                  onToggle: cubit.toggleSavedOnly,
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              FlutterMap(
                options: MapOptions(
                  initialCenter: visibleProperties.isNotEmpty
                      ? LatLng(visibleProperties.first.lat,
                          visibleProperties.first.lng)
                      : const LatLng(30.0444, 31.2357),
                  initialZoom: visibleProperties.isNotEmpty &&
                          visibleProperties.first.lat == 0
                      ? 3
                      : 12,
                  onTap: (_, __) => cubit.selectProperty(null),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.flutter_application_1',
                  ),
                  MarkerLayer(
                    markers: visibleProperties.map((p) {
                      final isSaved = repo.isSaved(p.id);
                      final isSelected = state.selectedProperty?.id == p.id;
                      return Marker(
                        point: LatLng(p.lat, p.lng),
                        width: isSelected ? 52 : 44,
                        height: isSelected ? 52 : 44,
                        child: GestureDetector(
                          onTap: () => cubit.selectProperty(p),
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

              if (state.selectedProperty != null)
                Positioned(
                  bottom: 16.h,
                  left: 16.w,
                  right: 16.w,
                  child: PropertyCard(
                    property: state.selectedProperty!,
                    isSaved: repo.isSaved(state.selectedProperty!.id),
                    onClose: () => cubit.selectProperty(null),
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
                child: MapLegend(),
              ),
            ],
          ),
        );
      },
    );
  }
}