import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomShimmer extends StatefulWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const CustomShimmer.rectangular({
    super.key,
    this.width = double.infinity,
    required this.height,
  }) : shapeBorder = const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        );

  const CustomShimmer.circular({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.shapeBorder = const CircleBorder(),
  });

  @override
  State<CustomShimmer> createState() => _CustomShimmerState();
}

class _CustomShimmerState extends State<CustomShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: ShapeDecoration(
            shape: widget.shapeBorder,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.grey[300]!,
                Colors.grey[100]!,
                Colors.grey[300]!,
              ],
              stops: [
                0.0,
                _controller.value,
                1.0,
              ],
            ),
          ),
        );
      },
    );
  }
}

class ShimmerGridLoading extends StatelessWidget {
  const ShimmerGridLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      itemCount: 6,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (_, __) {
        return Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              CustomShimmer.rectangular(height: 16.h, width: 80.w),
              SizedBox(height: 8.h),
              const Divider(),
              SizedBox(height: 8.h),
              Expanded(
                child: CustomShimmer.rectangular(height: 70.h),
              ),
              SizedBox(height: 12.h),
              CustomShimmer.rectangular(height: 14.h, width: 100.w),
              SizedBox(height: 10.h),
              CustomShimmer.rectangular(height: 35.h, width: double.infinity),
            ],
          ),
        );
      },
    );
  }
}

class ShimmerListLoading extends StatelessWidget {
  const ShimmerListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      itemCount: 5,
      itemBuilder: (_, __) {
        return Container(
          margin: EdgeInsets.only(bottom: 16.h),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomShimmer.rectangular(height: 150.h, width: double.infinity),
              SizedBox(height: 12.h),
              CustomShimmer.rectangular(height: 20.h, width: 200.w),
              SizedBox(height: 8.h),
              CustomShimmer.rectangular(height: 14.h, width: double.infinity),
            ],
          ),
        );
      },
    );
  }
}

class TransferShimmer extends StatelessWidget {
  const TransferShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: CustomShimmer.rectangular(height: 24.h, width: 150.w),
          ),
          SizedBox(
            height: 200.h,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (_, __) => Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: CustomShimmer.rectangular(height: 200.h, width: 280.w),
              ),
            ),
          ),
          SizedBox(height: 32.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomShimmer.rectangular(height: 24.h, width: 150.w),
          ),
          SizedBox(height: 16.h),
          ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (_, __) => Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  children: [
                    CustomShimmer.rectangular(height: 72.w, width: 72.w),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomShimmer.rectangular(height: 20.h, width: 150.w),
                          SizedBox(height: 8.h),
                          CustomShimmer.rectangular(height: 14.h, width: double.infinity),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
