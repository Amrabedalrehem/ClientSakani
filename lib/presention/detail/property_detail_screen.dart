import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/HomeData.dart';
import 'package:flutter_application_1/data/repo/SavedRepository.dart';
import 'package:flutter_application_1/presention/detail/component/detail_code_card.dart';
import 'package:flutter_application_1/presention/detail/component/detail_contact_button.dart';
import 'package:flutter_application_1/presention/detail/component/detail_header_card.dart';
import 'package:flutter_application_1/presention/detail/component/detail_image_carousel.dart';
import 'package:flutter_application_1/presention/detail/component/detail_location_card.dart';
import 'package:flutter_application_1/presention/detail/component/detail_rules_card.dart';
import 'package:flutter_application_1/presention/detail/component/detail_services_card.dart';
import 'package:flutter_application_1/presention/detail/component/detail_stats_card.dart';

class PropertyDetailScreen extends StatefulWidget {
  final PropertyModel property;

  const PropertyDetailScreen({super.key, required this.property});

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  final SavedRepository _repo = SavedRepository();
  late bool _isSaved;

  @override
  void initState() {
    super.initState();
    _isSaved = _repo.isSaved(widget.property.id);
  }

  Future<void> _toggleSave() async {
    await _repo.toggleSaved(widget.property.id);
    setState(() => _isSaved = _repo.isSaved(widget.property.id));
  }

  @override
  Widget build(BuildContext context) {
    final property = widget.property;

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
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: const Icon(Icons.arrow_back_rounded,
                    color: Color(0xFF1A1A2E), size: 20),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: _toggleSave,
                child: Container(
                  margin: const EdgeInsets.all(8),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
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
                    size: 20,
                  ),
                ),
              ),
            ],
            title: Text(
              property.name,
              style: const TextStyle(
                color: Color(0xFF1A1A2E),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: DetailImageCarousel(images: property.allImages),
            ),
          ),

          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 12),
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
