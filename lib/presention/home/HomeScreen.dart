import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_application_1/core/const/HomeConst.dart';
import 'package:flutter_application_1/core/dp/HiveService.dart';
import 'package:flutter_application_1/presention/detail/property_detail_screen.dart';
import 'package:flutter_application_1/presention/home/component/EmptyState.dart';
import 'package:flutter_application_1/presention/home/component/HomeAppBar.dart';
import 'package:flutter_application_1/presention/home/component/HomeBottomNavBar.dart';
import 'package:flutter_application_1/presention/home/component/HomeFilterSection.dart';
import 'package:flutter_application_1/presention/home/component/PropertyCard.dart';
import 'package:flutter_application_1/presention/home/cubit/home_cubit.dart';
import 'package:flutter_application_1/presention/map/cubit/map_cubit.dart';
import 'package:flutter_application_1/presention/map/map_screen.dart';
import 'package:flutter_application_1/presention/save/saved_screen.dart';
import 'package:flutter_application_1/presention/settings/settings_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit()..fetchProperties(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  void _onPropertyTap(BuildContext context, PropertyModel property) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PropertyDetailScreen(property: property),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();

         final HomeLoaded? loaded = state is HomeLoaded
            ? state
            : state is HomeFilterLoading
                ? state.previousState
                : null;

        final currentNav = loaded?.currentNav ?? BottomNavItem.home;
        final navHistory = loaded?.navHistory ?? [BottomNavItem.home];

        final navIndex = {
          BottomNavItem.home: 0,
          BottomNavItem.map: 1,
          BottomNavItem.saved: 2,
          BottomNavItem.settings: 3,
        };

        return PopScope(
          canPop: navHistory.length <= 1,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;
            cubit.popNav();
          },
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: currentNav == BottomNavItem.home
                ? HomeAppBar(
                    activeFiltersCount: loaded?.activeFiltersCount ?? 0,
                    onFiltersTap: () => cubit.toggleFilters(),
                  )
                : null,
            body: IndexedStack(
              index: navIndex[currentNav]!,
              children: [
                _buildHomePage(context, state, loaded, cubit),
                _buildMapPage(loaded),
                SavedScreen(
                  properties: loaded?.properties ?? [],
                  onBrowseTap: () => cubit.changeTab(BottomNavItem.home),
                ),
                const SettingsScreen(),
              ],
            ),
            bottomNavigationBar: ValueListenableBuilder(
              valueListenable: HiveService.savedBox.listenable(),
              builder: (context, box, _) {
                return HomeBottomNavBar(
                  currentItem: currentNav,
                  savedCount: cubit.savedCount,
                  onItemSelected: cubit.changeTab,
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildMapPage(HomeLoaded? loaded) {
    return BlocProvider(
      create: (_) => MapCubit(),
      child: MapScreen(properties: loaded?.properties ?? []),
    );
  }

  Widget _buildHomePage(
    BuildContext context,
    HomeState state,
    HomeLoaded? loaded,
    HomeCubit cubit,
  ) {
    final isLoading = state is HomeLoading;
    final isFilterLoading = state is HomeFilterLoading;
    final isError = state is HomeError;

    if (isError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.grey, size: 48),
            const SizedBox(height: 12),
            Text(
              'Failed to load properties',
              style: TextStyle(color: Colors.grey, fontSize: 14.sp),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => cubit.fetchProperties(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final properties = loaded?.properties ?? [];
    final showFilters = loaded?.showFilters ?? false;
    final areas = loaded?.areas ?? ['All Areas'];

    return ValueListenableBuilder(
      valueListenable: HiveService.savedBox.listenable(),
      builder: (context, box, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: showFilters
                  ? HomeFilterSection(
                      areas: areas,
                      onActiveFiltersChanged: cubit.setActiveFiltersCount,
                      onFiltersChanged: cubit.fetchFilteredProperties,
                    )
                  : const SizedBox.shrink(),
            ),

            Divider(height: 1.h, thickness: 1, color: Theme.of(context).dividerColor),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Text(
                isLoading ? 'Loading...' : '${properties.length} properties found',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await cubit.fetchProperties();
                },
                color: const Color(0xFF1A7EC8),
                child: (isLoading)
                    ? _buildShimmer(context)
                    : (isFilterLoading)
                        ? _buildShimmer(context)
                        : properties.isEmpty
                            ? Stack(
                                children: [
                                  ListView(physics: const AlwaysScrollableScrollPhysics()),
                                  const EmptyState(),
                                ],
                              )
                            : ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.only(bottom: 16.h),
                                itemCount: properties.length,
                                itemBuilder: (context, index) {
                                  final property = properties[index];
                                  final isSaved = cubit.isSaved(property.id);
                                  final updatedProperty =
                                      property.copyWith(isSaved: isSaved);
                                  return PropertyCard(
                                    property: updatedProperty,
                                    onTap: () => _onPropertyTap(
                                        context, updatedProperty),
                                    onSaveToggle: (val) =>
                                        cubit.toggleSave(property.id),
                                  );
                                },
                              ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildShimmer(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;
    final surfaceColor = Theme.of(context).colorScheme.surface;

    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Container(
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 180.h,
                    decoration: BoxDecoration(
                      color: surfaceColor,
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16.r)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(14.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 20.h,
                            width: double.infinity,
                            color: surfaceColor),
                        SizedBox(height: 12.h),
                        Container(
                            height: 16.h, width: 200.w, color: surfaceColor),
                        SizedBox(height: 12.h),
                        Container(
                            height: 16.h, width: 140.w, color: surfaceColor),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Container(
                                height: 32.h,
                                width: 80.w,
                                decoration: BoxDecoration(
                                    color: surfaceColor,
                                    borderRadius:
                                        BorderRadius.circular(20.r))),
                            SizedBox(width: 8.w),
                            Container(
                                height: 32.h,
                                width: 80.w,
                                decoration: BoxDecoration(
                                    color: surfaceColor,
                                    borderRadius:
                                        BorderRadius.circular(20.r))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}