import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../data/slider_model.dart';

class BannerController extends GetxController {
  late final PageController pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.9,
  );

  RxInt currentPage = 0.obs;

  final List<SliderModel> heroSlides = [
    SliderModel(
      imageUrl:
          'https://images.unsplash.com/photo-1551958219-acbc630e2914?w=600',
      title: 'ENC COMMUNITY HEROES: LEAGUE FINAL',
      subtitle: 'Community Cup Final vs, East End Juniors',
      countdown: '2 Days 04:31:18',
    ),
    SliderModel(
      imageUrl:
          'https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=600',
      title: 'SUMMER KNOCKOUT TOURNAMENT',
      subtitle: 'Quarter Final vs, Westside Warriors',
      countdown: '5 Days 12:00:00',
    ),
    SliderModel(
      imageUrl:
          'https://images.unsplash.com/photo-1560272564-c83b66b1ad12?w=600',
      title: 'YOUTH ACADEMY SHOWCASE',
      subtitle: 'U12 Finals vs, Northgate Athletic',
      countdown: '1 Day 08:45:30',
    ),
    SliderModel(
      imageUrl:
          'https://images.unsplash.com/photo-1517466787929-bc90951d0974?w=600',
      title: 'REGIONAL CHAMPIONS CUP',
      subtitle: 'Semi Final vs, Riverside Rovers',
      countdown: '3 Days 22:10:05',
    ),
    SliderModel(
      imageUrl:
          'https://images.unsplash.com/photo-1431324155629-1a6deb1dec8d?w=600',
      title: 'ENC DERBY DAY SPECIAL',
      subtitle: 'League Clash vs, Old Town United',
      countdown: '0 Days 18:59:59',
    ),
  ];

  @override
  void onInit() {
    pageController.addListener(() {
      final page = pageController.page?.round() ?? 0;
      if (page != currentPage.value) {
        currentPage.value = page;
      }
    });
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
