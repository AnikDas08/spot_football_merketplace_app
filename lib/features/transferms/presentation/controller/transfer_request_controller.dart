import 'package:get/get.dart';
import 'package:untitled/utils/constants/app_colors.dart';

class TransferRequestController extends GetxController {
  final _isIncoming = true.obs;
  bool get isIncoming => _isIncoming.value;

  // Track actions locally
  final RxList<int> acceptedIndices = <int>[].obs;
  final RxList<int> rejectedIndices = <int>[].obs;
  final RxList<int> withdrawnIndices = <int>[].obs;

  void setIncoming(bool value) {
    _isIncoming.value = value;
  }

  void acceptTransfer(int index, String playerName) {
    if (acceptedIndices.contains(index) || rejectedIndices.contains(index)) return;
    
    acceptedIndices.add(index);
    Get.snackbar(
      'Success',
      'Transfer request for $playerName accepted.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.green,
      colorText: AppColors.white,
    );
  }

  void rejectTransfer(int index, String playerName) {
    if (acceptedIndices.contains(index) || rejectedIndices.contains(index)) return;

    rejectedIndices.add(index);
    Get.snackbar(
      'Rejected',
      'Transfer request for $playerName rejected.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.logoutRed,
      colorText: AppColors.white,
    );
  }

  void withdrawOffer(int index, String playerName) {
    if (withdrawnIndices.contains(index)) return;

    withdrawnIndices.add(index);
    Get.snackbar(
      'Withdrawn',
      'Offer for $playerName has been withdrawn.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.logoutRed,
      colorText: AppColors.white,
    );
  }

  bool isActionTaken(int index) {
    if (isIncoming) {
      return acceptedIndices.contains(index) || rejectedIndices.contains(index);
    } else {
      return withdrawnIndices.contains(index);
    }
  }

  String getActionStatus(int index) {
    if (acceptedIndices.contains(index)) return 'Accepted';
    if (rejectedIndices.contains(index)) return 'Rejected';
    if (withdrawnIndices.contains(index)) return 'Withdrawn';
    return isIncoming ? 'Active' : 'Pending';
  }
}
