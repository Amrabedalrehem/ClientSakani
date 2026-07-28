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

  const SavedScreen({
    super.key,
    required this.onBrowseTap,
  });

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  final SavedRepository _repo = SavedRepository();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<String>>(
      valueListenable: HiveService.savedBox.listenable(),
      builder: (context, box, _) {
        final saved = _repo.getSavedProperties();

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: SavedAppBar(savedCount: saved.length),
          body: saved.isEmpty
              ? EmptyState(onBrowseTap: widget.onBrowseTap)
              : ListView.builder(
                  padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
                  itemCount: saved.length,
                  itemBuilder: (context, index) {
                    final property = saved[index].copyWith(isSaved: true);
                    return PropertyCard(
                      property: property,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PropertyDetailScreen(
                            property: property,
                          ),
                        ),
                      ),
                      onSaveToggle: (val) async {
                        await _repo.toggleSaved(property);
                      },
                    );
                  },
                ),
        );
      },
    );
  }
}
