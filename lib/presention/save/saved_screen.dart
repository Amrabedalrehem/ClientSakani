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

 
 
class SavedScreen extends StatefulWidget {
  final VoidCallback onBrowseTap;
  final List<PropertyModel> properties;

  const SavedScreen({super.key, required this.onBrowseTap, required this.properties});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  final SavedRepository _repo = SavedRepository();

  List<PropertyModel> get _savedProperties {
    final savedIds = _repo.getSavedIds();
    return widget.properties.where((p) => savedIds.contains(p.id)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: SavedAppBar(savedCount: _savedProperties.length),
      body: ValueListenableBuilder(
        valueListenable: HiveService.savedBox.listenable(),
        builder: (context, box, _) {
          final saved = _savedProperties;

          if (saved.isEmpty) {
            return EmptyState(
              onBrowseTap: widget.onBrowseTap,
            );
          }

          return ListView.builder(
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
                  await _repo.toggleSaved(property.id);
                },
              );
            },
          );
        },
      ),
    );
  }
}