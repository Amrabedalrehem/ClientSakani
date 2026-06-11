
 
import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 56, color: Colors.grey[350]),
          const SizedBox(height: 16),
          Text(
            'No housing matches your filters.',
            style: TextStyle(fontSize: 15, color: Colors.grey[500]),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Clear all filters',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF1A7EC8),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}