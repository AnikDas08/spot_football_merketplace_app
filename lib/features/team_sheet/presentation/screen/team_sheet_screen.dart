import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:untitled/component/common_appbar/secondary_appbar.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_images.dart';
import 'package:untitled/utils/constants/temp_image.dart';

class TeamSheetScreen extends StatefulWidget {
  const TeamSheetScreen({super.key});

  @override
  State<TeamSheetScreen> createState() => _TeamSheetScreenState();
}

class _TeamSheetScreenState extends State<TeamSheetScreen> {
  String selectedTeam = 'United FC';
  String selectedFormation = '4-3-3 Attacking';

  final List<String> teams = ['United FC', 'Madrid Kings', 'London Lions'];
  final List<String> formations = ['4-3-3 Attacking', '3-3-4 Formation', '4-4-2 Defensive'];

  // Mock player data for roster
  final List<Map<String, String>> roster = [
    {'name': 'James', 'initial': 'J', 'pos': 'ST'},
    {'name': 'David', 'initial': 'D', 'pos': 'ST'},
    {'name': 'Tom', 'initial': 'T', 'pos': 'CM'},
    {'name': 'Chris', 'initial': 'C', 'pos': 'CM'},
    {'name': 'Marcus', 'initial': 'M', 'pos': 'ST'},
    {'name': 'Ryan', 'initial': 'R', 'pos': 'CM'},
    {'name': 'Ben', 'initial': 'B', 'pos': 'CB'},
    {'name': 'Jake', 'initial': 'J', 'pos': 'CB'},
    {'name': 'Mike', 'initial': 'M', 'pos': 'GK'},
    {'name': 'Alex', 'initial': 'A', 'pos': 'CM'},
    {'name': 'Leo', 'initial': 'L', 'pos': 'ST'},
  ];

  // Current lineup: formationKey -> slotIndex -> PlayerData
  // We'll simplify: just one lineup for the current screen state
  Map<int, Map<String, String>?> currentLineup = {};

  // Substitutes: slotIndex -> PlayerData
  Map<int, Map<String, String>?> substitutes = {
    0: null,
    1: null,
    2: null,
    3: null,
  };

  @override
  void initState() {
    super.initState();
    // Initialize with some dummy assignments matching the visual from previous state
    currentLineup = {
      1: {'name': 'James', 'initial': 'J', 'pos': 'ST'},
      2: {'name': 'David', 'initial': 'D', 'pos': 'ST'},
      6: {'name': 'Tom', 'initial': 'T', 'pos': 'CM'},
      7: {'name': 'Tom', 'initial': 'T', 'pos': 'CB'},
    };
  }

  List<List<String>> getFormationLayout(String formation) {
    switch (formation) {
      case '3-3-4 Formation':
        return [
          ['ST', 'ST', 'ST', 'ST'],
          ['CM', 'CM', 'CM'],
          ['CB', 'CB', 'CB'],
          ['GK'],
        ];
      case '4-4-2 Defensive':
        return [
          ['ST', 'ST'],
          ['CM', 'CM', 'CM', 'CM'],
          ['CB', 'CB', 'CB', 'CB'],
          ['GK'],
        ];
      case '4-3-3 Attacking':
      default:
        return [
          ['ST', 'ST', 'ST'],
          ['CM', 'CM', 'CM'],
          ['CB', 'CB', 'CB', 'CB'],
          ['GK'],
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: const SecondaryAppBar(title: 'TEAM SHEET'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroBanner(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              text: 'SELECT TEAM',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                            SizedBox(height: 8.h),
                            _buildDropdown(selectedTeam, teams, (val) {
                              setState(() => selectedTeam = val!);
                            }),
                          ],
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              text: 'FORMATION SETUP',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                            SizedBox(height: 8.h),
                            _buildDropdown(selectedFormation, formations, (val) {
                              setState(() {
                                selectedFormation = val!;
                                // Reset lineup on formation change to avoid index mismatches
                                currentLineup.clear();
                              });
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  _buildFormationCard(),
                  SizedBox(height: 24.h),
                  CommonText(
                    text: 'SUBSTITUTES',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 16.h),
                  _buildSubstitutesList(),
                  SizedBox(height: 32.h),
                  _buildConfirmButton(),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      width: double.infinity,
      height: 180.h,
      margin: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        image: DecorationImage(
          image: AssetImage(TempImage.football),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
          ),
        ),
        padding: EdgeInsets.all(16.w),
        alignment: Alignment.bottomLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              text: 'Team Sheet',
              fontSize: 14.sp,
              color: Colors.white70,
            ),
            CommonText(
              text: selectedFormation,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String value, List<String> items, ValueChanged<String?> onChanged) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: CommonText(text: item, fontSize: 14.sp, color: Colors.black),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildFormationCard() {
    final layout = getFormationLayout(selectedFormation);
    int globalIndex = 0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: 'Formation Setup',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                CommonText(
                  text: selectedFormation,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(12.r),
            child: AspectRatio(
              aspectRatio: 335 / 440,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: SvgPicture.asset(
                        AppImages.stadium,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: layout.map((row) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: row.map((pos) {
                          final currentIndex = globalIndex++;
                          final playerData = currentLineup[currentIndex];
                          return _buildPlayerNode(
                            playerData?['initial'],
                            pos,
                            name: playerData?['name'],
                            onTap: () => _showPlayerSelection(pos, index: currentIndex),
                          );
                        }).toList(),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerNode(String? initial, String position, {String? name, required VoidCallback onTap}) {
    bool isEmpty = initial == null;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isEmpty ? Colors.white.withOpacity(0.2) : const Color(0xFFF57C00),
              border: Border.all(
                color: Colors.white,
                width: 1.5,
              ),
            ),
            child: isEmpty
                ? const Icon(Icons.add, color: Colors.white, size: 22)
                : Center(
                    child: CommonText(
                      text: initial,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
          ),
          SizedBox(height: 4.h),
          CommonText(
            text: name ?? '',
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            maxLines: 1,
          ),
          CommonText(
            text: position,
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.9),
          ),
        ],
      ),
    );
  }

  Widget _buildSubstitutesList() {
    final List<String> subPos = ['ST', 'CM', 'CB', 'GK'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(subPos.length, (index) {
          final playerData = substitutes[index];
          return GestureDetector(
            onTap: () => _showPlayerSelection(subPos[index], isSub: true, index: index),
            child: Container(
              margin: EdgeInsets.only(right: 12.w),
              width: 80.w,
              height: 90.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (playerData == null) ...[
                    const Icon(Icons.add, color: Colors.black54, size: 24),
                    SizedBox(height: 4.h),
                    CommonText(text: subPos[index], fontSize: 13.sp, fontWeight: FontWeight.w700),
                  ] else ...[
                    CircleAvatar(
                      radius: 18.r,
                      backgroundColor: const Color(0xFFF57C00),
                      child: CommonText(
                        text: playerData['initial']!,
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    CommonText(
                      text: playerData['name']!,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      maxLines: 1,
                    ),
                    CommonText(text: playerData['pos']!, fontSize: 10.sp, color: Colors.grey),
                  ],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Container(
      width: double.infinity,
      height: 54.h,
      margin: EdgeInsets.only(bottom: 20.h),
      child: ElevatedButton(
        onPressed: () {
          Get.snackbar(
            'Success',
            'Lineup confirmed successfully!',
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.green,
            colorText: Colors.white,
            margin: EdgeInsets.all(15.w),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          elevation: 0,
        ),
        child: CommonText(
          text: 'Confirm Lineup',
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showPlayerSelection(String position, {bool isSub = false, required int index}) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: 'Select Player for $position',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: roster.length,
                separatorBuilder: (context, i) => Divider(height: 1.h, color: Colors.grey.withOpacity(0.2)),
                itemBuilder: (context, i) {
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 4.h),
                    leading: CircleAvatar(
                      backgroundColor: AppColors.iconBgYellow,
                      child: CommonText(
                        text: roster[i]['initial']!,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    title: CommonText(
                      text: roster[i]['name']!,
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                    ),
                    subtitle: CommonText(
                      text: 'Position: ${roster[i]['pos']}',
                      textAlign: TextAlign.start,
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      setState(() {
                        if (isSub) {
                          substitutes[index] = roster[i];
                        } else {
                          currentLineup[index] = roster[i];
                        }
                      });
                      Get.back();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
