import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailImageCarousel extends StatefulWidget {
  final List<String> images;

  const DetailImageCarousel({super.key, required this.images});

  @override
  State<DetailImageCarousel> createState() => _DetailImageCarouselState();
}

class _DetailImageCarouselState extends State<DetailImageCarousel> {
  final PageController _controller = PageController();
  int _current = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (widget.images.isNotEmpty && _controller.hasClients) {
        int next = (_current + 1) % widget.images.length;
        _controller.animateToPage(
          next,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _go(int delta) {
    final next = (_current + delta).clamp(0, widget.images.length - 1);
    _controller.animateToPage(
      next,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260.h,
      child: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.images.length,
            onPageChanged: (i) => setState(() => _current = i),
            itemBuilder: (_, i) => Image.network(
              widget.images[i],
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (_, __, ___) => Container(
                color: const Color(0xFFEEEEEE),
                child: Icon(Icons.broken_image_rounded,
                    size: 48.sp, color: Colors.grey),
              ),
            ),
          ),

          if (_current > 0)
            Positioned(
              left: 12.w,
              top: 0.h,
              bottom: 0.h,
              child: Center(child: _NavBtn(icon: Icons.chevron_left_rounded, onTap: () => _go(-1))),
            ),

          if (_current < widget.images.length - 1)
            Positioned(
              right: 12.w,
              top: 0.h,
              bottom: 0.h,
              child: Center(child: _NavBtn(icon: Icons.chevron_right_rounded, onTap: () => _go(1))),
            ),

          Positioned(
            bottom: 12.h,
            left: 0.w,
            right: 0.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.images.length, (i) {
                final active = i == _current;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  width: active ? 18 : 7,
                  height: 7.h,
                  decoration: BoxDecoration(
                    color: active ? Colors.white : Colors.white54,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _NavBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.w,
        height: 36.h,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.45),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 22.sp),
      ),
    );
  }
}
