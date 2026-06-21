part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<PropertyModel> properties;
  final List<AreaModel> areaModels;
  final List<String> areas;
  final BottomNavItem currentNav;
  final List<BottomNavItem> navHistory;
  final bool showFilters;
  final int activeFiltersCount;
  final FilterValues filterValues;

  HomeLoaded({
    required this.properties,
    required this.areaModels,
    required this.areas,
    required this.currentNav,
    required this.navHistory,
    required this.showFilters,
    required this.activeFiltersCount,
    required this.filterValues,
  });

  HomeLoaded copyWith({
    List<PropertyModel>? properties,
    List<AreaModel>? areaModels,
    List<String>? areas,
    BottomNavItem? currentNav,
    List<BottomNavItem>? navHistory,
    bool? showFilters,
    int? activeFiltersCount,
    FilterValues? filterValues,
  }) {
    return HomeLoaded(
      properties: properties ?? this.properties,
      areaModels: areaModels ?? this.areaModels,
      areas: areas ?? this.areas,
      currentNav: currentNav ?? this.currentNav,
      navHistory: navHistory ?? this.navHistory,
      showFilters: showFilters ?? this.showFilters,
      activeFiltersCount: activeFiltersCount ?? this.activeFiltersCount,
      filterValues: filterValues ?? this.filterValues,
    );
  }
}

class HomeFilterLoading extends HomeState {
  final HomeLoaded previousState;
  HomeFilterLoading(this.previousState);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
