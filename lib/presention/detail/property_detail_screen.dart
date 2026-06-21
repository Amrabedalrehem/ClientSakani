import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:math' as math;
import 'package:flutter_application_1/core/const/HomeConst.dart';
import 'package:flutter_application_1/presention/detail/component/detail_code_card.dart';
import 'package:flutter_application_1/presention/detail/component/detail_contact_button.dart';
import 'package:flutter_application_1/presention/detail/component/detail_header_card.dart';
import 'package:flutter_application_1/presention/detail/component/detail_image_carousel.dart';
import 'package:flutter_application_1/presention/detail/component/detail_location_card.dart';
import 'package:flutter_application_1/presention/detail/component/detail_rules_card.dart';
import 'package:flutter_application_1/presention/detail/component/detail_services_card.dart';
import 'package:flutter_application_1/presention/detail/component/detail_stats_card.dart';
import 'package:flutter_application_1/presention/detail/cubit/detail_cubit.dart';


class PropertyDetailScreen extends StatelessWidget {
  final PropertyModel property;

  const PropertyDetailScreen({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DetailCubit()..fetchDetails(property),
      child: const _DetailView(),
    );
  }
}

class _DetailView extends StatelessWidget {
  const _DetailView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DetailCubit>();

    return BlocBuilder<DetailCubit, DetailState>(
      builder: (context, state) {
        final isLoading = state is DetailLoading;
        final loaded = state is DetailLoaded ? state : null;
        final property = loaded?.property;
        final isSaved = loaded?.isSaved ?? false;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 260,
                pinned: true,
                backgroundColor: Theme.of(context).colorScheme.surface,
                elevation: 0,
                leading: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    margin: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Icon(Icons.arrow_back_rounded,
                        color: Theme.of(context).colorScheme.onSurface, size: 20.sp),
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: () => cubit.toggleSave(context),
                    child: TweenAnimationBuilder<double>(
                      key: ValueKey(isSaved),
                      duration: const Duration(milliseconds: 400),
                      tween: Tween(begin: 0.0, end: 1.0),
                      curve: Curves.easeInOutCubic,
                      builder: (context, value, child) {
                        double scale = 1.0;
                        if (isSaved) {
                          scale = 1.0 + (math.sin(value * math.pi) * 0.4);
                        }
                        return Transform.scale(scale: scale, child: child);
                      },
                      child: Container(
                        margin: EdgeInsets.all(8.r),
                        width: 40.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Icon(
                          isSaved
                              ? Icons.bookmark_rounded
                              : Icons.bookmark_border_rounded,
                          color: isSaved
                              ? const Color(0xFF1A7EC8)
                              : Theme.of(context).colorScheme.onSurface,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ),
                ],
                title: isLoading
                    ? null
                    : Text(
                        property?.name ?? '',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                flexibleSpace: FlexibleSpaceBar(
                  background: isLoading
                      ? Shimmer.fromColors(
                          baseColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey[800]! : Colors.grey[300]!,
                          highlightColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey[700]! : Colors.grey[100]!,
                          child: Container(color: Theme.of(context).colorScheme.surface),
                        )
                      : DetailImageCarousel(images: property?.allImages ?? []),
                ),
              ),

              SliverToBoxAdapter(
                child: isLoading
                    ? _buildShimmer(context)
                    : Column(
                        children: [
                          SizedBox(height: 12.h),
                          DetailHeaderCard(property: property!),
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
      },
    );
  }

  Widget _buildShimmer(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    return Padding(
      padding: EdgeInsets.all(16.0.r),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 100.h,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                    child: Container(
                        height: 80.h,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(12.r)))),
                SizedBox(width: 16.w),
                Expanded(
                    child: Container(
                        height: 80.h,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(12.r)))),
              ],
            ),
            SizedBox(height: 16.h),
            Container(
              width: double.infinity,
              height: 150.h,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              width: double.infinity,
              height: 100.h,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
