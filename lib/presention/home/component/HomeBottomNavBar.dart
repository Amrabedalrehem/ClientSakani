import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/HomeData.dart';

 

class HomeBottomNavBar extends StatelessWidget {
  final BottomNavItem currentItem;
  final ValueChanged<BottomNavItem> onItemSelected;
  final int savedCount; 
  const HomeBottomNavBar({
    super.key,
    required this.currentItem,
    required this.onItemSelected,
    this.savedCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: BottomNavItem.values.map((item) {
              return Expanded(
                child: _NavBarItem(
                  item: item,
                  isActive: item == currentItem,
                  badge: item == BottomNavItem.saved && savedCount > 0
                      ? savedCount
                      : null,
                  onTap: () => onItemSelected(item),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
 class _NavBarItem extends StatelessWidget {
  final BottomNavItem item;
  final bool isActive;
  final int? badge;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.item,
    required this.isActive,
    required this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    const activeColor = Color(0xFF1A7EC8);
    final inactiveColor = Colors.grey[500]!;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Stack(
            clipBehavior: Clip.none,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  isActive ? item.activeIcon : item.icon,
                  key: ValueKey(isActive),
                  size: 24,
                  color: isActive ? activeColor : inactiveColor,
                ),
              ),

               if (badge != null)
                Positioned(
                  top: -4,
                  right: -8,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1A7EC8),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '$badge',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 4),

           AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: 11,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              color: isActive ? activeColor : inactiveColor,
            ),
            child: Text(item.label),
          ),

          const SizedBox(height: 4),

           AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isActive ? 6 : 0,
            height: isActive ? 6 : 0,
            decoration: const BoxDecoration(
              color: activeColor,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}