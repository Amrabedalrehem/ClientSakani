import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/const/HomeConst.dart';
import 'package:flutter_application_1/core/dp/HiveService.dart';
import 'package:flutter_application_1/data/repo/SavedRepository.dart';
import 'package:flutter_application_1/presention/detail/property_detail_screen.dart';
import 'package:flutter_application_1/presention/home/component/PropertyCard.dart';
import 'package:flutter_application_1/presention/save/component/empty_state.dart';
import 'package:flutter_application_1/presention/save/component/saved_app_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SavedScreen extends StatelessWidget {
  final VoidCallback onBrowseTap;
  final List<PropertyModel> properties;

  const SavedScreen({
    super.key,
    required this.onBrowseTap,
    required this.properties,
  });

  @override
  Widget build(BuildContext context) {
    final repo = SavedRepository();

    return ValueListenableBuilder(
      valueListenable: HiveService.savedBox.listenable(),
      builder: (context, box, _) {
        final savedIds = repo.getSavedIds();
        final saved =
            properties.where((p) => savedIds.contains(p.id)).toList();

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: SavedAppBar(savedCount: saved.length),
          body: saved.isEmpty
              ? EmptyState(onBrowseTap: onBrowseTap)
              : ListView.builder(
                  padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
                  itemCount: saved.length,
                  itemBuilder: (context, index) {
                    final property = saved[index];
                    return PropertyCard(
                      property: property.copyWith(isSaved: true),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PropertyDetailScreen(
                            property: property.copyWith(isSaved: true),
                          ),
                        ),
                      ),
                      onSaveToggle: (val) async {
                        await repo.toggleSaved(property.id);
                      },
                    );
                  },
                ),
        );
      },
    );
  }
}