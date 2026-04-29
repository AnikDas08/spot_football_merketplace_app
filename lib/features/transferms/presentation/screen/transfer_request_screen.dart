import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/common_appbar/secondary_appbar.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/temp_image.dart';
import '../controller/transfer_request_controller.dart';

class TransferRequestScreen extends StatelessWidget {
  const TransferRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TransferRequestController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: const SecondaryAppBar(title: 'TRANSFERS REQUEST'),
      body: Column(
        children: [
          _buildTransferPortalBanner(),
          SizedBox(height: 16.h),
          _buildTabs(controller),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Obx(() => _buildTransferCard(controller, index));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransferPortalBanner() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFBC02D),
        borderRadius: BorderRadius.circular(16.r),
        image: const DecorationImage(
          alignment: Alignment.bottomRight,
          image: AssetImage(TempImage.upcomingEvent),
          opacity: 0.1,
          fit: BoxFit.none,
          scale: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: 'Transfer Portal',
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          SizedBox(height: 8.h),
          SizedBox(
            width: 220.w,
            child: CommonText(
              text: 'Manage your roster moves and negotiations.',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs(TransferRequestController controller) {
    return Obx(() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        height: 48.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => controller.setIncoming(true),
                child: Container(
                  decoration: BoxDecoration(
                    color: controller.isIncoming ? Colors.black : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  alignment: Alignment.center,
                  child: CommonText(
                    text: 'Incoming',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: controller.isIncoming ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => controller.setIncoming(false),
                child: Container(
                  decoration: BoxDecoration(
                    color: !controller.isIncoming ? Colors.black : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  alignment: Alignment.center,
                  child: CommonText(
                    text: 'Outgoing',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: !controller.isIncoming ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildTransferCard(TransferRequestController controller, int index) {
    const String playerName = 'Marcus Rashford';
    final String status = controller.getActionStatus(index);
    final bool actionTaken = controller.isActionTaken(index);

    Color statusColor;
    if (status == 'Accepted' || status == 'Active') {
      statusColor = const Color(0xFF19CA77);
    } else if (status == 'Rejected' || status == 'Withdrawn') {
      statusColor = const Color(0xFFEF5350);
    } else {
      statusColor = const Color(0xFF424242);
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(
                  TempImage.player,
                  width: 60.w,
                  height: 60.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(
                          text: playerName,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: CommonText(
                            text: status,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        const Icon(Icons.shield, size: 14, color: Colors.grey),
                        SizedBox(width: 4.w),
                        CommonText(
                          text: controller.isIncoming ? 'United FC' : 'To: Madrid Kings',
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F1FF),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: 'MARCUS VANE',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black54,
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        CommonText(
                          text: '12,000,000',
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(width: 4.w),
                        CommonText(
                          text: 'ENG Coins',
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    const Icon(Icons.wallet, color: Color(0xFF0056D2), size: 20),
                  ],
                ),
              ],
            ),
          ),
          if (!actionTaken) ...[
            SizedBox(height: 16.h),
            if (controller.isIncoming)
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.acceptTransfer(index, playerName),
                      child: _buildActionButton(
                        'Accept',
                        Colors.black,
                        Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.rejectTransfer(index, playerName),
                      child: _buildActionButton(
                        'Reject',
                        const Color(0xFFFFEBEE),
                        const Color(0xFFEF5350),
                      ),
                    ),
                  ),
                ],
              )
            else
              GestureDetector(
                onTap: () => controller.withdrawOffer(index, playerName),
                child: _buildActionButton(
                  'Withdraw Offer',
                  Colors.white,
                  const Color(0xFFEF5350),
                  borderColor: const Color(0xFFEF5350),
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, Color bgColor, Color textColor, {Color? borderColor}) {
    return Container(
      height: 48.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.r),
        border: borderColor != null ? Border.all(color: borderColor) : null,
      ),
      alignment: Alignment.center,
      child: CommonText(
        text: text,
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),
    );
  }
}
