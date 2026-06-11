import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/datasource/HomeDataSource.dart';
import 'package:flutter_application_1/data/model/HomeData.dart';
import 'package:flutter_application_1/presention/home/component/EmptyState.dart';
import 'package:flutter_application_1/presention/home/component/HomeAppBar.dart';
import 'package:flutter_application_1/presention/home/component/HomeBottomNavBar.dart';
import 'package:flutter_application_1/presention/home/component/HomeFilterSection.dart';
import 'package:flutter_application_1/presention/home/component/PropertyCard.dart';

 import 'package:flutter/material.dart';
 
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   BottomNavItem _currentNav = BottomNavItem.home;
  int _activeFiltersCount = 0;
  bool _showFilters = false;

   FilterValues _filterValues = const FilterValues(
    area: 'All Areas',
    gender: GenderFilter.all,
  );

  late List<PropertyModel> _allProperties;

  @override
  void initState() {
    super.initState();
    _allProperties = kDummyProperties.toList();
  }

   List<PropertyModel> get _filteredProperties {
    return _allProperties.where((p) {
      // فلتر المنطقة
      if (_filterValues.area != 'All Areas' && p.area != _filterValues.area) {
        return false;
      }
      // فلتر الجنس
      if (_filterValues.gender != GenderFilter.all) {
        final genderMatch = {
          GenderFilter.males: PropertyGender.males,
          GenderFilter.females: PropertyGender.females,
          GenderFilter.mixed: PropertyGender.mixed,
        };
        if (p.gender != genderMatch[_filterValues.gender]) return false;
      }
      // فلتر السعر
      if (_filterValues.maxPrice != null &&
          p.pricePerMonth > _filterValues.maxPrice!) {
        return false;
      }
      return true;
    }).toList();
  }

   int get _savedCount => _allProperties.where((p) => p.isSaved).length;

  void _toggleSave(String id, bool val) {
    setState(() {
      _allProperties = _allProperties.map((p) {
        if (p.id == id) {
          return PropertyModel(
            id: p.id,
            name: p.name,
            area: p.area,
            imageUrl: p.imageUrl,
            pricePerMonth: p.pricePerMonth,
            totalBeds: p.totalBeds,
            availableBeds: p.availableBeds,
            amenities: p.amenities,
            gender: p.gender,
            isSaved: val,
          );
        }
        return p;
      }).toList();
    });
  }

  void _onFiltersTap() {
    setState(() => _showFilters = !_showFilters);
  }

  void _onPropertyTap(String id) {
    // TODO: navigate to property details
  }

   @override
  Widget build(BuildContext context) {
    final filtered = _filteredProperties;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: HomeAppBar(
        activeFiltersCount: _activeFiltersCount,
        onFiltersTap: _onFiltersTap,
      ),
      body: Column(
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
                        onTap: () => _onPropertyTap(property.id),
                        onSaveToggle: (val) => _toggleSave(property.id, val),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: HomeBottomNavBar(
        currentItem: _currentNav,
        savedCount: _savedCount,
        onItemSelected: (item) {
          setState(() => _currentNav = item);
          // TODO: handle navigation
        },
      ),
    );
  }
}

 