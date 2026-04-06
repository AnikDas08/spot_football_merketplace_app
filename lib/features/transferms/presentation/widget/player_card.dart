import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/utils/constants/app_colors.dart';

class PlayerCard extends StatelessWidget {
  final String imageUrl;
  final String status;
  final String position;
  final int age;
  final String playerName;
  final String academyName;
  final String price;
  final VoidCallback? onTap;

  const PlayerCard({
    super.key,
    required this.imageUrl,
    required this.status,
    required this.position,
    required this.age,
    required this.playerName,
    required this.academyName,
    required this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280.w,
        height: 195.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.fill,
            alignment: Alignment.center,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),

              ),
            ),

            // Card Content
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: AppColors.yellow, // Yellow color
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                    child: CommonText(
                     text:  status,

                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,

                    ),
                  ),
                  const Spacer(),

                  // Position and Age
                  Text(
                   '${position.toUpperCase()} • $age YRS',
                   style:TextStyle (
                      color: AppColors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.6,

                   )  ),


                  // Player Name
                  CommonText(
                    text:  playerName.toUpperCase(),

                      color: AppColors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,


                  ),
                  SizedBox(height: 8.h),

                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color:  AppColors.green, // Green color
                          borderRadius: BorderRadius.circular(40.r),
                        ),
                        child:  CommonText(
                          text:
                          academyName.toUpperCase(),
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,

                        ),
                      ),

                      SizedBox(width: 20.w,),
                      Expanded(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: CommonText(
                            text: '$price COINS',
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}