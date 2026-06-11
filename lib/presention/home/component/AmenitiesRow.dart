
import 'package:flutter/material.dart';

class AmenitiesRow extends StatelessWidget {
  final List<String> amenities;

  const AmenitiesRow({required this.amenities});

  @override
  Widget build(BuildContext context) {
    const maxShow = 3;
    final shown = amenities.take(maxShow).toList();
    final extra = amenities.length - maxShow;

    return Row(
      children: [
        ...shown.map((a) => Text(
              '$a • ',
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            )),
        if (extra > 0)
          Text('...', style: TextStyle(fontSize: 13, color: Colors.grey[600])),
      ],
    );
  }
}