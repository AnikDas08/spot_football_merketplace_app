import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/common_appbar/common_appbar.dart';
import 'package:untitled/component/common_appbar/secondary_appbar.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/utils/constants/app_colors.dart';

import '../widgets/transfer_list_widget.dart';
import '../widgets/transfer_summary_card.dart';
import '../widgets/transfer_tab_widget.dart';

class TransfersHistoryScreen extends StatelessWidget {
  const TransfersHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const SecondaryAppBar(title: 'TRANSFERS HISTORY'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16.h),
            const TransferSummaryCard(),
            SizedBox(height: 20.h),
            const TransferTabWidget(),
            SizedBox(height: 16.h),
            const TransferListWidget(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
