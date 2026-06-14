import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/datasource/HomeDataSource.dart';
import 'package:flutter_application_1/data/model/HomeData.dart';
import 'package:flutter_application_1/data/network/HiveService.dart';
import 'package:flutter_application_1/data/repo/SavedRepository.dart';
import 'package:flutter_application_1/presention/home/component/PropertyCard.dart';
import 'package:flutter_application_1/presention/save/component/empty_state.dart';
 
import 'package:flutter_application_1/presention/save/component/saved_app_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';

 
 
class SavedScreen extends StatefulWidget {
  final VoidCallback onBrowseTap;

  const SavedScreen({super.key, required this.onBrowseTap});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  final SavedRepository _repo = SavedRepository();

  List<PropertyModel> get _savedProperties {
    final savedIds = _repo.getSavedIds();
    return kDummyProperties.where((p) => savedIds.contains(p.id)).toList();
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
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            itemCount: saved.length,
            itemBuilder: (context, index) {
              final property = saved[index];

              return PropertyCard(
                property: property.copyWith(isSaved: true),
                onTap: () {},
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