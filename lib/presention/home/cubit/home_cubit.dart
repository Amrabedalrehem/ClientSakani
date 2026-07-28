import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/core/const/HomeConst.dart';
import 'package:flutter_application_1/data/model/AreaModel.dart';
import 'package:flutter_application_1/data/repo/SavedRepository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final SavedRepository _repo;

  HomeCubit({SavedRepository? repo})
      : _repo = repo ?? SavedRepository(),
        super(HomeInitial());

 
  Future<void> fetchProperties() async {
    emit(HomeLoading());
    try {
      final results = await Future.wait([
        _repo.getApartments(),
        _repo.getAreas(),
      ]);
      final properties = results[0] as List<PropertyModel>;
      final areaModels = results[1] as List<AreaModel>;
      final areas = ['All Areas', ...areaModels.map((e) => e.name)];

      emit(HomeLoaded(
        properties: properties,
        areaModels: areaModels,
        areas: areas,
        currentNav: BottomNavItem.home,
        navHistory: [BottomNavItem.home],
        showFilters: false,
        activeFiltersCount: 0,
        filterValues: const FilterValues(
          area: 'All Areas',
          gender: GenderFilter.all,
        ),
        isOffline: false,
      ));
    } catch (e) {
      final cachedProperties = _repo.getCachedApartments();
      final cachedAreas = _repo.getCachedAreas();
      emit(HomeLoaded(
        properties: cachedProperties,
        areaModels: cachedAreas,
        areas: ['All Areas', ...cachedAreas.map((e) => e.name)],
        currentNav: BottomNavItem.home,
        navHistory: [BottomNavItem.home],
        showFilters: false,
        activeFiltersCount: 0,
        filterValues: const FilterValues(
          area: 'All Areas',
          gender: GenderFilter.all,
        ),
        isOffline: true,
      ));
    }
  }

 
  Future<void> fetchFilteredProperties(FilterValues values) async {
    final current = state;
    if (current is! HomeLoaded) return;

    emit(HomeFilterLoading(current));
    try {
      int? areaId;
      if (values.area != 'All Areas') {
        final match = current.areaModels.where((a) => a.name == values.area);
        if (match.isNotEmpty) areaId = match.first.id;
      }

      int? genderId;
      if (values.gender == GenderFilter.males) {
        genderId = 0;
      } else if (values.gender == GenderFilter.females) {
        genderId = 1;
      }

      final properties = await _repo.searchApartments(
        areaId: areaId,
        gender: genderId,
        maxPrice: values.maxPrice?.toDouble(),
      );
      final sortedProperties = _sortProperties(properties, values.sortOrder);

      emit(current.copyWith(
        properties: sortedProperties,
        filterValues: values,
        activeFiltersCount: values.activeCount,
        showFilters: values.activeCount > 0 ? true : current.showFilters,
        isOffline: false,
      ));
    } catch (e) {
      emit(current.copyWith(isOffline: true));
    }
  }

  Future<void> clearFilters() async {
    await fetchProperties();
  }

 
  Future<void> toggleSave(PropertyModel property) async {
    await _repo.toggleSaved(property);
    final current = _loadedStateOrNull();
    if (current != null) {
      emit(current.copyWith());
    }
  }

  
  void changeTab(BottomNavItem item) {
    final current = _loadedStateOrNull();
    if (current == null) return;
    if (current.currentNav == item) return;

    final newHistory = List<BottomNavItem>.from(current.navHistory)
      ..remove(item)
      ..add(item);

    emit(current.copyWith(
      currentNav: item,
      navHistory: newHistory,
      showFilters: false,
    ));
  }

  bool popNav() {
    final current = _loadedStateOrNull();
    if (current == null) return false;
    if (current.navHistory.length <= 1) return false;

    final newHistory = List<BottomNavItem>.from(current.navHistory)..removeLast();
    emit(current.copyWith(
      currentNav: newHistory.last,
      navHistory: newHistory,
      showFilters: false,
    ));
    return true;
  }

  List<PropertyModel> _sortProperties(
    List<PropertyModel> properties,
    PriceSortOrder sortOrder,
  ) {
    final sorted = List<PropertyModel>.from(properties);

    switch (sortOrder) {
      case PriceSortOrder.lowToHigh:
        sorted.sort((a, b) => a.pricePerMonth.compareTo(b.pricePerMonth));
        break;
      case PriceSortOrder.highToLow:
        sorted.sort((a, b) => b.pricePerMonth.compareTo(a.pricePerMonth));
        break;
      case PriceSortOrder.none:
        break;
    }

    return sorted;
  }

  
  void toggleFilters() {
    final current = _loadedStateOrNull();
    if (current == null) return;
    emit(current.copyWith(showFilters: !current.showFilters));
  }

  void setActiveFiltersCount(int count) {
    final current = _loadedStateOrNull();
    if (current == null) return;
    emit(current.copyWith(activeFiltersCount: count));
  }

  HomeLoaded? _loadedStateOrNull() {
    final current = state;
    if (current is HomeLoaded) return current;
    if (current is HomeFilterLoading) return current.previousState;
    return null;
  }

 
  bool isSaved(String id) => _repo.isSaved(id);
  int get savedCount => _repo.savedCount;
  List<String> getSavedIds() => _repo.getSavedIds();
}
