import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_application_1/core/const/HomeConst.dart';
import 'package:flutter_application_1/data/repo/SavedRepository.dart';
import 'package:flutter_application_1/presention/detail/component/detail_code_card.dart';
import 'package:flutter_application_1/presention/detail/component/detail_contact_button.dart';
import 'package:flutter_application_1/presention/detail/component/detail_header_card.dart';
import 'package:flutter_application_1/presention/detail/component/detail_image_carousel.dart';
import 'package:flutter_application_1/presention/detail/component/detail_location_card.dart';
import 'dart:math' as math;
import 'package:flutter_application_1/presention/detail/component/detail_rules_card.dart';
import 'package:flutter_application_1/presention/detail/component/detail_services_card.dart';
import 'package:flutter_application_1/presention/detail/component/detail_stats_card.dart';
import 'package:flutter_application_1/presention/home/component/ConfirmUnsaveDialog.dart';

class PropertyDetailScreen extends StatefulWidget {
  final PropertyModel property;

  const PropertyDetailScreen({super.key, required this.property});

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  final SavedRepository _repo = SavedRepository();
  late bool _isSaved;
  late PropertyModel _property;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _property = widget.property;
    _isSaved = _repo.isSaved(_property.id);
    _fetchDetails();
  }

  Future<void> _fetchDetails() async {
    try {
      final details = await _repo.getApartmentById(int.parse(_property.id));
      if (details != null && mounted) {
        setState(() {
          _property = details;
          _isLoading = false;
        });
      } else {
        if (mounted) setState(() => _isLoading = false);
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _toggleSave() async {
    if (_isSaved) {
      final confirm = await showConfirmUnsaveDialog(context);
      if (confirm != true) return;
    }
    await _repo.toggleSaved(_property.id);
    setState(() => _isSaved = _repo.isSaved(_property.id));
  }

  @override
  Widget build(BuildContext context) {
    final property = _property;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Icon(Icons.arrow_back_rounded,
                    color: Color(0xFF1A1A2E), size: 20.sp),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: _toggleSave,
                child: TweenAnimationBuilder<double>(
                  key: ValueKey(_isSaved),
                  duration: const Duration(milliseconds: 400),
                  tween: Tween(begin: 0.0, end: 1.0),
                  curve: Curves.easeInOutCubic,
                  builder: (context, value, child) {
                    double scale = 1.0;
                    if (_isSaved) {
                      scale = 1.0 + (math.sin(value * math.pi) * 0.4);
                    }
                    return Transform.scale(
                      scale: scale,
                      child: child,
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(8.r),
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Icon(
                      _isSaved
                          ? Icons.bookmark_rounded
                          : Icons.bookmark_border_rounded,
                      color: _isSaved
                          ? const Color(0xFF1A7EC8)
                          : const Color(0xFF1A1A2E),
                      size: 20.sp,
                    ),
                  ),
                ),
              ),
            ],
            title: Text(
              property.name,
              style: TextStyle(
                color: Color(0xFF1A1A2E),
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: DetailImageCarousel(images: property.allImages),
            ),
          ),

          SliverToBoxAdapter(
            child: _isLoading 
            ? Padding(
                padding: EdgeInsets.all(16.0.r),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 100.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          Expanded(child: Container(height: 80.h, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12.r)))),
                          SizedBox(width: 16.w),
                          Expanded(child: Container(height: 80.h, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12.r)))),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        width: double.infinity,
                        height: 150.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        width: double.infinity,
                        height: 100.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Column(
              children: [
                SizedBox(height: 12.h),
                DetailHeaderCard(property: property),
                DetailStatsCard(property: property),
                DetailLocationCard(property: property),
                DetailServicesCard(property: property),
                DetailRulesCard(property: property),
                DetailCodeCard(property: property),
                DetailContactButton(property: property),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
