part of 'map_cubit.dart';

class MapState {
  final PropertyModel? selectedProperty;
  final bool showSavedOnly;

  const MapState({
    this.selectedProperty,
    this.showSavedOnly = false,
  });

  MapState copyWith({
    PropertyModel? selectedProperty,
    bool clearSelected = false,
    bool? showSavedOnly,
  }) {
    return MapState(
      selectedProperty: clearSelected ? null : (selectedProperty ?? this.selectedProperty),
      showSavedOnly: showSavedOnly ?? this.showSavedOnly,
    );
  }
}
