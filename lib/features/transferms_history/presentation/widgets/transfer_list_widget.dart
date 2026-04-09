import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/features/transferms_history/presentation/widgets/transfer_item_widget.dart';

class TransferListWidget extends StatelessWidget {
  const TransferListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (_, _) => const TransferItemWidget(),
    );
  }
}