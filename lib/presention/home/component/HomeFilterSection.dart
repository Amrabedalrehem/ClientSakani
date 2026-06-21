import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/const/HomeConst.dart';
import 'package:flutter_application_1/presention/home/component/AreaDropdown.dart';
import 'package:flutter_application_1/presention/home/component/GenderChips.dart';
import 'package:flutter_application_1/presention/home/component/PriceInput.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';

class HomeFilterSection extends StatefulWidget {
  final ValueChanged<int> onActiveFiltersChanged;
  final ValueChanged<FilterValues> onFiltersChanged; 
  final List<String> areas;

  const HomeFilterSection({
    super.key,
    required this.onActiveFiltersChanged,
    required this.onFiltersChanged,
    required this.areas,
  });

  @override
  State<HomeFilterSection> createState() => _HomeFilterSectionState();
}

class _HomeFilterSectionState extends State<HomeFilterSection> {
  String _selectedArea = 'All Areas';
  GenderFilter _selectedGender = GenderFilter.all;
  final TextEditingController _priceController = TextEditingController();
  bool _isPriceFocused = false;

  int get _activeFiltersCount {
    int count = 0;
    if (_selectedArea != 'All Areas') count++;
    if (_selectedGender != GenderFilter.all) count++;
    if (_priceController.text.isNotEmpty) count++;
    return count;
  }

  void _clearAllFilters() {
    setState(() {
      _selectedArea = 'All Areas';
      _selectedGender = GenderFilter.all;
      _priceController.clear();
    });
    _notifyFilterChange();
  }

  void _notifyFilterChange() {
    widget.onActiveFiltersChanged(_activeFiltersCount);
    widget.onFiltersChanged(FilterValues(
      area: _selectedArea,
      gender: _selectedGender,
      maxPrice: int.tryParse(_priceController.text),
    ));
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           AreaDropdown(
            selectedArea: _selectedArea,
            areas: widget.areas,
            onChanged: (val) {
              setState(() => _selectedArea = val);
              _notifyFilterChange();
            },
          ),

          SizedBox(height: 10.h),

           GenderChips(
            selected: _selectedGender,
            onChanged: (val) {
              setState(() => _selectedGender = val);
              _notifyFilterChange();
            },
          ),

          SizedBox(height: 10.h),

           PriceInput(
            controller: _priceController,
            isFocused: _isPriceFocused,
            onFocusChange: (v) => setState(() => _isPriceFocused = v),
            onClear: () {
              setState(() => _priceController.clear());
              _notifyFilterChange();
            },
            onChanged: (_) => _notifyFilterChange(),
          ),

           if (_activeFiltersCount > 0) ...[
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: _clearAllFilters,
              child: Text(
                AppLocalizations.of(context)?.emptyFilterDesc ?? 'Clear all filters',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Color(0xFF1A7EC8),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}