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
import 'package:flutter_application_1/l10n/app_localizations.dart';

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
                    activeFiltersCount: loaded?.filterValues.activeCount ?? 0,
                    onFiltersTap: () => cubit.toggleFilters(),
                  )
                : null,
            body: IndexedStack(
              index: navIndex[currentNav]!,
              children: [
                _buildHomePage(context, state, loaded, cubit),
                _buildMapPage(),
                SavedScreen(
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

  Widget _buildMapPage() {
    return BlocProvider(
      create: (_) => MapCubit(),
      child: const MapScreen(),
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
    final isOffline = loaded?.isOffline ?? false;

    if (isError) {
      final l10n = AppLocalizations.of(context);
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.grey, size: 48),
            const SizedBox(height: 12),
            Text(
              l10n?.failedToLoad ?? 'Failed to load properties',
              style: TextStyle(color: Colors.grey, fontSize: 14.sp),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => cubit.fetchProperties(),
              child: Text(l10n?.retry ?? 'Retry'),
            ),
          ],
        ),
      );
    }

    final properties = loaded?.properties ?? [];
    final showFilters = loaded?.showFilters ?? false;
    final areas = loaded?.areas ?? ['All Areas'];
    final maxAvailablePrice = properties.isNotEmpty
        ? properties.map((p) => p.pricePerMonth).reduce((a, b) => a > b ? a : b)
        : null;

    return ValueListenableBuilder(
      valueListenable: HiveService.savedBox.listenable(),
      builder: (context, box, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isOffline)
              _OfflineBanner(
                title: AppLocalizations.of(context)?.offlineModeTitle ?? "You're offline",
                subtitle: AppLocalizations.of(context)?.offlineModeDesc ??
                    'Showing cached data when available.',
              ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: showFilters
                  ? HomeFilterSection(
                      areas: areas,
                      maxAllowedPrice: maxAvailablePrice,
                      initialValues: loaded?.filterValues ??
                          const FilterValues(
                            area: 'All Areas',
                            gender: GenderFilter.all,
                          ),
                      onActiveFiltersChanged: cubit.setActiveFiltersCount,
                      onFiltersChanged: cubit.fetchFilteredProperties,
                    )
                  : const SizedBox.shrink(),
            ),

            Divider(height: 1.h, thickness: 1, color: Theme.of(context).dividerColor),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Text(
                isLoading
                    ? (AppLocalizations.of(context)?.loadingProperties ?? 'Loading...')
                    : (AppLocalizations.of(context)?.propertiesFound(properties.length) ?? '${properties.length} properties found'),
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
                            ? (isOffline
                                ? _OfflineEmptyState(
                                    title: AppLocalizations.of(context)?.offlineModeEmptyTitle ??
                                        'No cached housing yet.',
                                    subtitle: AppLocalizations.of(context)?.offlineModeEmptyDesc ??
                                        'Connect once to load data, then it will stay available offline.',
                                  )
                                : Stack(
                                    children: [
                                      ListView(
                                        physics: const AlwaysScrollableScrollPhysics(),
                                      ),
                                      EmptyState(
                                        onClearFilters: () => cubit.clearFilters(),
                                      ),
                                    ],
                                  ))
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
                                        cubit.toggleSave(property),
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

class _OfflineBanner extends StatelessWidget {
  final String title;
  final String subtitle;

  const _OfflineBanner({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 6.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF7E8),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFFF2C96D)),
        ),
        child: Row(
          children: [
            Container(
              width: 36.w,
              height: 36.h,
              decoration: const BoxDecoration(
                color: Color(0xFFF2C96D),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.wifi_off_rounded, color: Colors.white),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF7A5A00),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11.5.sp,
                      color: const Color(0xFF7A5A00).withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OfflineEmptyState extends StatelessWidget {
  final String title;
  final String subtitle;

  const _OfflineEmptyState({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 84.w,
              height: 84.h,
              decoration: BoxDecoration(
                color: const Color(0xFF1A7EC8).withOpacity(0.10),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.cloud_off_rounded,
                size: 40.sp,
                color: const Color(0xFF1A7EC8),
              ),
            ),
            SizedBox(height: 18.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
            SizedBox(height: 18.h),
            OutlinedButton.icon(
              onPressed: () async {
                await context.read<HomeCubit>().fetchProperties();
              },
              icon: const Icon(Icons.refresh_rounded),
              label: Text(AppLocalizations.of(context)?.retry ?? 'Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
