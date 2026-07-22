import '../../utils/constants/app_string.dart';

class ApiResponseModel {
  final int? _statusCode;
  final Map<String, dynamic>? _data;

  ApiResponseModel(this._statusCode, this._data);

  bool get isSuccess => _statusCode == 200 || _statusCode == 201;
  int get statusCode => _statusCode ?? 400;

  String get message {
    if (_statusCode == 502) {
      return AppString.startServer;
    }
    
    // Check various common message fields in the response data
    if (_data != null) {
      if (_data!['message'] != null && _data!['message'].toString().isNotEmpty) {
        return _data!['message'].toString();
      }
      if (_data!['msg'] != null && _data!['msg'].toString().isNotEmpty) {
        return _data!['msg'].toString();
      }
      if (_data!['error'] != null && _data!['error'].toString().isNotEmpty) {
        return _data!['error'].toString();
      }
      if (_data!['error_description'] != null && _data!['error_description'].toString().isNotEmpty) {
        return _data!['error_description'].toString();
      }
    }

    return AppString.someThingWrong;
  }

  Map<String, dynamic> get data => _data ?? {};
}
