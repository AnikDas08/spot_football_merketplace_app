import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeassonStatsController extends GetxController{
  var selectedSeason = "2024/25".obs;

  Future<void> chooseSeason(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDatePickerMode: DatePickerMode.year,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF083E4B),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {String nextYearShort = (pickedDate.year + 1).toString().substring(2);
      selectedSeason.value = "${pickedDate.year}/$nextYearShort";

      updateDataForSeason(selectedSeason.value);
    }
  }

  void updateDataForSeason(String season) {
    print("Data loading for: $season");
  }

}