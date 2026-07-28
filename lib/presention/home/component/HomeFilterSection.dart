import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/const/HomeConst.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/presention/home/component/AreaDropdown.dart';
import 'package:flutter_application_1/presention/home/component/GenderChips.dart';

class HomeFilterSection extends StatefulWidget {
  final ValueChanged<int> onActiveFiltersChanged;
  final ValueChanged<FilterValues> onFiltersChanged;
  final List<String> areas;
  final int? maxAllowedPrice;
  final FilterValues initialValues;

  const HomeFilterSection({
    super.key,
    required this.onActiveFiltersChanged,
    required this.onFiltersChanged,
    required this.areas,
    required this.maxAllowedPrice,
    required this.initialValues,
  });

  @override
  State<HomeFilterSection> createState() => _HomeFilterSectionState();
}

class _HomeFilterSectionState extends State<HomeFilterSection> {
  late String _selectedArea;
  late GenderFilter _selectedGender;
  late PriceSortOrder _selectedSortOrder;
  late final TextEditingController _priceController;
  Timer? _priceDebounce;

  @override
  void initState() {
    super.initState();
    _selectedArea = widget.initialValues.area;
    _selectedGender = widget.initialValues.gender;
    _selectedSortOrder = widget.initialValues.sortOrder;
    _priceController = TextEditingController(
      text: widget.initialValues.maxPrice?.toString() ?? '',
    );
  }

  @override
  void didUpdateWidget(covariant HomeFilterSection oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialValues.area != widget.initialValues.area ||
        oldWidget.initialValues.gender != widget.initialValues.gender ||
        oldWidget.initialValues.sortOrder != widget.initialValues.sortOrder ||
        oldWidget.initialValues.maxPrice != widget.initialValues.maxPrice) {
      _selectedArea = widget.initialValues.area;
      _selectedGender = widget.initialValues.gender;
      _selectedSortOrder = widget.initialValues.sortOrder;
      final newPrice = widget.initialValues.maxPrice?.toString() ?? '';
      if (_priceController.text != newPrice) {
        _priceController.text = newPrice;
      }
    }
  }

  @override
  void dispose() {
    _priceDebounce?.cancel();
    _priceController.dispose();
    super.dispose();
  }

  int get _activeFiltersCount {
    var count = 0;
    if (_selectedArea != 'All Areas') count++;
    if (_selectedGender != GenderFilter.all) count++;
    if (_priceController.text.trim().isNotEmpty) count++;
    if (_selectedSortOrder != PriceSortOrder.none) count++;
    return count;
  }

  void _clearAllFilters() {
    _priceDebounce?.cancel();
    setState(() {
      _selectedArea = 'All Areas';
      _selectedGender = GenderFilter.all;
      _selectedSortOrder = PriceSortOrder.none;
      _priceController.clear();
    });
    _notifyFilterChange();
  }

  void _notifyFilterChange() {
    widget.onActiveFiltersChanged(_activeFiltersCount);
    widget.onFiltersChanged(FilterValues(
      area: _selectedArea,
      gender: _selectedGender,
      maxPrice: int.tryParse(_priceController.text.trim()),
      sortOrder: _selectedSortOrder,
    ));
  }

  void _onPriceChanged(String value) {
    setState(() {});
    _priceDebounce?.cancel();
    _priceDebounce = Timer(const Duration(milliseconds: 350), () {
      if (!mounted) return;
      _notifyFilterChange();
    });
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
          _buildPriceField(context),
          SizedBox(height: 10.h),
          _buildPriceSortSection(context),
          if (_activeFiltersCount > 0) ...[
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: _clearAllFilters,
              child: Text(
                AppLocalizations.of(context)?.emptyFilterDesc ?? 'Clear all filters',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFF1A7EC8),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPriceField(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isFilled = _priceController.text.trim().isNotEmpty;
    final maxAllowedPrice = widget.maxAllowedPrice;
    final hintText = maxAllowedPrice != null && maxAllowedPrice > 0
        ? l10n?.filterPriceHint(maxAllowedPrice) ??
            'Enter a max of $maxAllowedPrice EGP to show lower prices'
        : (l10n?.filterPriceRange ?? 'Price range');

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isFilled ? const Color(0xFF1A7EC8) : const Color(0xFFDDDDDD),
          width: 1.5.w,
        ),
      ),
      child: TextField(
        controller: _priceController,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          if (maxAllowedPrice != null && maxAllowedPrice > 0)
            _MaxPriceInputFormatter(maxAllowedPrice),
        ],
        onChanged: _onPriceChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            Icons.payments_outlined,
            size: 18.sp,
            color: isFilled ? const Color(0xFF1A7EC8) : Colors.grey,
          ),
          labelText: l10n?.filterPriceRange ?? 'Price range',
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 13.sp,
            color: Colors.grey[400],
          ),
          suffixIcon: isFilled
              ? IconButton(
                  onPressed: () {
                    _priceDebounce?.cancel();
                    setState(() {
                      _priceController.clear();
                    });
                    _notifyFilterChange();
                  },
                  icon: Icon(
                    Icons.close_rounded,
                    size: 18.sp,
                    color: Colors.grey[500],
                  ),
                )
              : null,
        ),
        style: TextStyle(
          fontSize: 14.sp,
          color: const Color(0xFF555555),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildPriceSortSection(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n?.sortPriceTitle ?? 'Sort by price',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
              child: _SortOptionChip(
                label: l10n?.sortPriceLowToHigh ?? 'Low to high',
                icon: Icons.trending_up_rounded,
                isSelected: _selectedSortOrder == PriceSortOrder.lowToHigh,
                selectedColor: const Color(0xFF1A7EC8),
                onTap: () {
                  setState(() => _selectedSortOrder = PriceSortOrder.lowToHigh);
                  _notifyFilterChange();
                },
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: _SortOptionChip(
                label: l10n?.sortPriceHighToLow ?? 'High to low',
                icon: Icons.trending_down_rounded,
                isSelected: _selectedSortOrder == PriceSortOrder.highToLow,
                selectedColor: const Color(0xFF1A7EC8),
                onTap: () {
                  setState(() => _selectedSortOrder = PriceSortOrder.highToLow);
                  _notifyFilterChange();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MaxPriceInputFormatter extends TextInputFormatter {
  final int maxPrice;

  _MaxPriceInputFormatter(this.maxPrice);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.isEmpty) return newValue;

    final value = int.tryParse(text);
    if (value == null) return oldValue;
    if (value > maxPrice) return oldValue;

    return newValue;
  }
}

class _SortOptionChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final Color selectedColor;
  final VoidCallback onTap;

  const _SortOptionChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.selectedColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? selectedColor : const Color(0xFFDDDDDD),
            width: 1.4.w,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16.sp,
              color: isSelected ? Colors.white : Colors.grey[600],
            ),
            SizedBox(width: 6.w),
            Flexible(
              child: Text(
                label,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11.5.sp,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : Colors.grey[700],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
