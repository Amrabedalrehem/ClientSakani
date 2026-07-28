import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailImageViewerScreen extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const DetailImageViewerScreen({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  State<DetailImageViewerScreen> createState() => _DetailImageViewerScreenState();
}

class _DetailImageViewerScreenState extends State<DetailImageViewerScreen> {
  late final PageController _controller;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(0, widget.images.isEmpty ? 0 : widget.images.length - 1);
    _controller = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Center(
            child: Icon(Icons.broken_image_rounded, color: Colors.white54, size: 64.sp),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: widget.images.length,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              itemBuilder: (context, index) {
                return Center(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Hero(
                      tag: 'detail-image-$index',
                      child: InteractiveViewer(
                        minScale: 1.0,
                        maxScale: 3.0,
                        child: SizedBox.expand(
                          child: Image.network(
                            widget.images[index],
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => Center(
                              child: Icon(
                                Icons.broken_image_rounded,
                                color: Colors.white54,
                                size: 64.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: 12.h,
              left: 12.w,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.45),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close_rounded, color: Colors.white, size: 22.sp),
                ),
              ),
            ),
            if (widget.images.length > 1)
              Positioned(
                bottom: 18.h,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(widget.images.length, (index) {
                    final active = index == _currentIndex;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      width: active ? 18.w : 7.w,
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
      ),
    );
  }
}
