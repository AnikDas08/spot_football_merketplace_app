import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../component/common_appbar/secondary_appbar.dart';
import '../../../../component/custom_shimmer/custom_shimmer.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/temp_image.dart';
import '../../data/transfer_request_model.dart';
import '../controller/transfer_request_controller.dart';

class TransferRequestScreen extends StatelessWidget {
  const TransferRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransferRequestController());

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: const SecondaryAppBar(title: 'Transfers request'),
      body: Column(
        children: [
          _buildTransferPortalBanner(),
          SizedBox(height: 16.h),
          _buildTabs(controller),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value &&
                  (controller.isIncoming
                      ? controller.incomingRequests.isEmpty
                      : controller.outgoingRequests.isEmpty)) {
                return const TransferRequestShimmer();
              }

              final requests = controller.isIncoming
                  ? controller.incomingRequests
                  : controller.outgoingRequests;

              return RefreshIndicator(
                onRefresh: () => controller.fetchRequests(),
                child: requests.isEmpty
                    ? const Center(child: Text("No transfer requests found"))
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.h),
                        itemCount: requests.length,
                        itemBuilder: (context, index) {
                          return _buildTransferCard(controller, requests[index]);
                        },
                      ),
              );
            }),
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
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontFamily: 'PlayfairDisplay',
          ),
          SizedBox(height: 8.h),
          SizedBox(
            width: 220.w,
            child: CommonText(
              text: 'Manage your roster moves and negotiations.',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black.withValues(alpha: 0.8),
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
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
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
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
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

  Widget _buildTransferCard(TransferRequestController controller, TransferRequestModel request) {
    final String playerName = (request.player.firstName != null || request.player.lastName != null)
        ? "${request.player.firstName ?? ""} ${request.player.lastName ?? ""}".trim()
        : request.player.userName;
    final String status = request.status;
    final bool actionTaken = status != 'PENDING';

    Color statusColor;
    if (status == 'APPROVED' || status == 'ACCEPTED') {
      statusColor = const Color(0xFF19CA77);
    } else if (status == 'REJECTED' || status == 'WITHDRAWN') {
      statusColor = const Color(0xFFEF5350);
    } else {
      statusColor = const Color(0xFFFBC02D); // Pending yellow
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
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.playerProfile, arguments: request.player.userId ?? request.player.id);
            },
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: CommonImage(
                    imageSrc: request.player.profile ?? "",
                    width: 60.w,
                    height: 60.w,
                    fill: BoxFit.cover,
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
                          Expanded(
                            child: CommonText(
                              text: playerName,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: statusColor,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: CommonText(
                              text: status,
                              fontSize: 12,
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
                            text: controller.isIncoming 
                              ? (request.fromTeam?.teamName ?? 'Free Agent') 
                              : 'To: ${request.toTeam?.teamName ?? 'N/A'}',
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
                  text: request.transferType.replaceAll('_', ' '),
                  fontSize: 12,
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
                          text: request.toTeam?.teamName ?? "",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(width: 4.w),
                        CommonText(
                          text: 'Requested Team',
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    const Icon(Icons.compare_arrows, color: Color(0xFF0056D2), size: 20),
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
                      onTap: () => (controller.acceptingId.value.isEmpty && controller.rejectingId.value.isEmpty)
                          ? controller.acceptTransfer(request.id, playerName)
                          : null,
                      child: Obx(() => _buildActionButton(
                        'Accept',
                        Colors.black,
                        Colors.white,
                        isLoading: controller.acceptingId.value == request.id,
                      )),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => (controller.acceptingId.value.isEmpty && controller.rejectingId.value.isEmpty)
                          ? controller.rejectTransfer(request.id, playerName)
                          : null,
                      child: Obx(() => _buildActionButton(
                        'Reject',
                        const Color(0xFFFFEBEE),
                        const Color(0xFFEF5350),
                        isLoading: controller.rejectingId.value == request.id,
                      )),
                    ),
                  ),
                ],
              )
            else
              GestureDetector(
                onTap: () => controller.withdrawingId.value.isEmpty 
                    ? controller.withdrawOffer(request.id, playerName) 
                    : null,
                child: Obx(() => _buildActionButton(
                  'Withdraw Offer',
                  Colors.white,
                  const Color(0xFFEF5350),
                  borderColor: const Color(0xFFEF5350),
                  isLoading: controller.withdrawingId.value == request.id,
                )),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, Color bgColor, Color textColor, {Color? borderColor, bool isLoading = false}) {
    return Container(
      height: 48.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.r),
        border: borderColor != null ? Border.all(color: borderColor) : null,
      ),
      alignment: Alignment.center,
      child: isLoading 
        ? SizedBox(
            height: 20.r,
            width: 20.r,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: textColor,
            ),
          )
        : CommonText(
            text: text,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
    );
  }
}
