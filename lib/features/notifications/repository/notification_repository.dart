import '../../../services/api/api_client.dart';
import '../../../services/api/api_service.dart';
import '../../../config/api/api_end_point.dart';
import '../data/model/notification_model.dart';
import '../../../services/storage/storage_services.dart';

Future<Map<String, dynamic>> notificationRepository(int page) async {
  try {
    final ApiClient apiClient = DioApiClient();
    final response = await apiClient.get(
      '${ApiEndPoint.notifications}?page=$page&limit=10',
      headers: {'Authorization': 'Bearer ${LocalStorage.token}'},
    );

    if (response.statusCode != 200) {
      throw Exception(response.message);
    }

    final List<dynamic> rawList = response.data['data'] ?? [];
    final pagination = response.data['pagination'] ?? {};

    return {
      'notifications': rawList.map((e) => NotificationModel.fromJson(e)).toList(),
      'totalPage': pagination['totalPage'] ?? 1,
    };
  } catch (e) {
    rethrow;
  }
}
