import 'dart:developer';

import 'package:code_setup/presentation/screens/holidays_list/models/holiday_model.dart';
import 'package:code_setup/repository/data/attendance_repository_impl.dart';
import 'package:code_setup/repository/domain/holidays_repo.dart';
import 'package:code_setup/utils/api_end_points.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:dio/dio.dart';

class HolidaysRepoImpl implements HolidaysRepo {
  @override
  Future<HolidayModel?> fetchHolidayList() async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(ApiEndPoint.holidaysList);
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final holidayData = HolidayModel.fromJson(jsonMap);
          return holidayData;
        } else {
          final errorMessage =
              response.data?['message'] ?? 'Unexpected error occurred';
          throw ApiException(errorMessage);
        }
      }
      return null;
    } on DioException catch (error) {
      log('caught error');
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error fetching attendance records $e');
      throw ApiException(e.toString());
    }
  }
}
