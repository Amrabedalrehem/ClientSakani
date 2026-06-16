import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_application_1/data/datasource/HomeDataSource.dart';
import 'package:flutter_application_1/core/const/HomeConst.dart';
import 'package:flutter_application_1/core/dp/HiveService.dart';
import 'package:flutter_application_1/data/repo/SavedRepository.dart';
import 'package:flutter_application_1/data/model/AreaModel.dart';
import 'package:flutter_application_1/presention/detail/property_detail_screen.dart';
import 'package:flutter_application_1/presention/home/component/EmptyState.dart';
import 'package:flutter_application_1/presention/home/component/HomeAppBar.dart' show HomeAppBar;
import 'package:flutter_application_1/presention/home/component/HomeBottomNavBar.dart';
import 'package:flutter_application_1/presention/home/component/HomeFilterSection.dart';
import 'package:flutter_application_1/presention/home/component/PropertyCard.dart';
import 'package:flutter_application_1/presention/map/map_screen.dart';
import 'package:flutter_application_1/presention/save/saved_screen.dart';
import 'package:flutter_application_1/presention/settings/settings_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BottomNavItem _currentNav = BottomNavItem.home;
  final List<BottomNavItem> _navHistory = [BottomNavItem.home];
  int _activeFiltersCount = 0;
  bool _showFilters = false;
  bool _isLoading = true;

  final SavedRepository _savedRepo = SavedRepository();

  List<PropertyModel> _properties = [];
  List<AreaModel> _areaModels = [];
  List<String> _areas = ['All Areas'];

  @override
  void initState() {
    super.initState();
    _fetchProperties();
  }

  Future<void> _fetchProperties() async {
    try {
      final results = await Future.wait([
        _savedRepo.getApartments(),
        _savedRepo.getAreas(),
      ]);
      setState(() {
        _properties = results[0] as List<PropertyModel>;
        _areaModels = results[1] as List<AreaModel>;
        _areas = ['All Areas', ..._areaModels.map((e) => e.name)];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _properties = []; 
        _areaModels = [];
        _areas = ['All Areas'];
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchFilteredProperties(FilterValues values) async {
    setState(() => _isLoading = true);
    try {
      int? areaId;
      if (values.area != 'All Areas') {
        final match = _areaModels.where((a) => a.name == values.area);
        if (match.isNotEmpty) areaId = match.first.id;
      }

      int? genderId;
      if (values.gender == GenderFilter.males) genderId = 0;
      else if (values.gender == GenderFilter.females) genderId = 1;
      
      final maxPrice = values.maxPrice?.toDouble();

      final properties = await _savedRepo.searchApartments(
        areaId: areaId,
        gender: genderId,
        maxPrice: maxPrice,
      );
      setState(() {
        _properties = properties;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _properties = [];
        _isLoading = false;
      });
    }
  }

  FilterValues _filterValues = const FilterValues(
    area: 'All Areas',
    gender: GenderFilter.all,
  );

  int get _savedCount => _savedRepo.savedCount;

  Future<void> _toggleSave(String id, bool val) async {
    await _savedRepo.toggleSaved(id);
    setState(() {});
  }

  void _onFiltersTap() {
    setState(() => _showFilters = !_showFilters);
  }

  void _onTabTapped(BottomNavItem item) {
    if (_currentNav == item) return;
    setState(() {
      _navHistory.remove(item);
      _navHistory.add(item);
      _currentNav = item;
    });
  }

  void _onPropertyTap(PropertyModel property) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PropertyDetailScreen(property: property),
      ),
    );
  }

   Widget _buildHomePage() {
    return ValueListenableBuilder(
      valueListenable: HiveService.savedBox.listenable(),
      builder: (context, box, _) {
        final filtered = _properties;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: _showFilters
                  ? HomeFilterSection(
                      areas: _areas,
                      onActiveFiltersChanged: (count) {
                        setState(() => _activeFiltersCount = count);
                      },
                      onFiltersChanged: (values) {
                        setState(() => _filterValues = values);
                        _fetchFilteredProperties(values);
                      },
                    )
                  : SizedBox.shrink(),
            ),

            Divider(height: 1.h, thickness: 1, color: Color(0xFFEEEEEE)),

            Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Text(
                '${filtered.length} properties found',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            Expanded(
              child: _isLoading 
                  ? ListView.builder(
                      padding: EdgeInsets.only(bottom: 16.h),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 180.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(14.r),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(height: 20.h, width: double.infinity, color: Colors.white),
                                        SizedBox(height: 12.h),
                                        Container(height: 16.h, width: 200.w, color: Colors.white),
                                        SizedBox(height: 12.h),
                                        Container(height: 16.h, width: 140.w, color: Colors.white),
                                        SizedBox(height: 16.h),
                                        Row(
                                          children: [
                                            Container(height: 32.h, width: 80.w, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.r))),
                                            SizedBox(width: 8.w),
                                            Container(height: 32.h, width: 80.w, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.r))),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : filtered.isEmpty
                      ? const EmptyState()
                      : ListView.builder(
                      padding: EdgeInsets.only(bottom: 16.h),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final property = filtered[index];
                        final isSaved = _savedRepo.isSaved(property.id);
                        final updatedProperty = property.copyWith(isSaved: isSaved);
                        return PropertyCard(
                          property: updatedProperty,
                          onTap: () => _onPropertyTap(updatedProperty),
                          onSaveToggle: (val) => _toggleSave(property.id, val),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
     final navIndex = {
      BottomNavItem.home: 0,
      BottomNavItem.map: 1,
      BottomNavItem.saved: 2,
      BottomNavItem.settings: 3,
    };

    return PopScope(
      canPop: _navHistory.length <= 1,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        setState(() {
          _navHistory.removeLast();
          _currentNav = _navHistory.last;
        });
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F6FA),
         appBar: _currentNav == BottomNavItem.home
            ? HomeAppBar(
                activeFiltersCount: _activeFiltersCount,
                onFiltersTap: _onFiltersTap,
              )
            : null,
      body: IndexedStack(
        index: navIndex[_currentNav]!,
        children: [
           _buildHomePage(),

           MapScreen(properties: _properties),

           SavedScreen(
            properties: _properties,
            onBrowseTap: () => _onTabTapped(BottomNavItem.home),
          ),
 
          const SettingsScreen(),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: HiveService.savedBox.listenable(),
        builder: (context, box, _) {
          return HomeBottomNavBar(
            currentItem: _currentNav,
            savedCount: _savedRepo.savedCount,
            onItemSelected: _onTabTapped,
          );
        },
      ),
      ),
    );
  }
}