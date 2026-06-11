
 
import 'package:flutter/material.dart';

class BookmarkButton extends StatelessWidget {
  final bool isSaved;
  final ValueChanged<bool> onToggle;

  const BookmarkButton({required this.isSaved, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onToggle(!isSaved),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: isSaved ? const Color(0xFF1A7EC8) : Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
          size: 18,
          color: isSaved ? Colors.white : Colors.grey[600],
        ),
      ),
    );
  }
}
