import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/datasource/HomeDataSource.dart';
import 'package:flutter_application_1/data/model/HomeData.dart';
import 'package:flutter_application_1/data/network/HiveService.dart';
import 'package:flutter_application_1/data/repo/SavedRepository.dart';
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
  int _activeFiltersCount = 0;
  bool _showFilters = false;

  final SavedRepository _savedRepo = SavedRepository();

  FilterValues _filterValues = const FilterValues(
    area: 'All Areas',
    gender: GenderFilter.all,
  );

  List<PropertyModel> get _filteredProperties {
    return kDummyProperties.where((p) {
      if (_filterValues.area != 'All Areas' && p.area != _filterValues.area) {
        return false;
      }
      if (_filterValues.gender != GenderFilter.all) {
        final genderMatch = {
          GenderFilter.males: PropertyGender.males,
          GenderFilter.females: PropertyGender.females,
          GenderFilter.mixed: PropertyGender.mixed,
        };
        if (p.gender != genderMatch[_filterValues.gender]) return false;
      }
      if (_filterValues.maxPrice != null &&
          p.pricePerMonth > _filterValues.maxPrice!) {
        return false;
      }
      return true;
    })
        .map((p) => p.copyWith(isSaved: _savedRepo.isSaved(p.id)))
        .toList();
  }

  int get _savedCount => _savedRepo.savedCount;

  Future<void> _toggleSave(String id, bool val) async {
    await _savedRepo.toggleSaved(id);
    setState(() {});
  }

  void _onFiltersTap() {
    setState(() => _showFilters = !_showFilters);
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
        final filtered = _filteredProperties;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: _showFilters
                  ? HomeFilterSection(
                      onActiveFiltersChanged: (count) {
                        setState(() => _activeFiltersCount = count);
                      },
                      onFiltersChanged: (values) {
                        setState(() => _filterValues = values);
                      },
                    )
                  : const SizedBox.shrink(),
            ),

            const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Text(
                '${filtered.length} properties found',
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            Expanded(
              child: filtered.isEmpty
                  ? const EmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 16),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final property = filtered[index];
                        return PropertyCard(
                          property: property,
                          onTap: () => _onPropertyTap(property),
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

    return Scaffold(
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

           const MapScreen(),

           SavedScreen(
            onBrowseTap: () {
              setState(() => _currentNav = BottomNavItem.home);
            },
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
            onItemSelected: (item) {
              setState(() => _currentNav = item);
            },
          );
        },
      ),
    );
  }
}