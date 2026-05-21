import 'dart:convert';
import 'dart:developer';

import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/models/leave_request/leave_count_model.dart';
import 'package:code_setup/modules/data/models/leave_request/leave_type_model.dart';
import 'package:code_setup/modules/data/models/leave_request/mourning_leave_relation_model.dart';
import 'package:code_setup/modules/data/models/leave_request/my_leave_request_model.dart';
import 'package:code_setup/modules/data/models/leave_request/unpaid_leave_category_model.dart';
import 'package:code_setup/presentation/common_widgets/show_toast.dart';
import 'package:code_setup/repository/data/attendance_repository_impl.dart';
import 'package:code_setup/repository/domain/leave_repo.dart';
import 'package:code_setup/utils/api_end_points.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:dio/dio.dart';

class LeaveRepoImpl implements LeaveRepo {
  @override
  Future<LeaveTypeModel?> fetchLeaveTypes(String leaveType) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(ApiEndPoint.leaveTypes(leaveType));
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final leaveTypeModel = LeaveTypeModel.fromJson(jsonMap);
          return leaveTypeModel;
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

  @override
  Future<LeaveCountModel?> fetchLeaveCount() async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.leaveCountAsPerFinancialGradeAndEmpType,
        );
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final leaveCountData = LeaveCountModel.fromJson(jsonMap);
          return leaveCountData;
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

  @override
  Future<void> createLeaveRequest(Map<String, dynamic> data) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.post(
          ApiEndPoint.createLeaveRequest,
          data: jsonEncode(data),
        );
        if ((response.statusCode == 200 || response.statusCode == 201) &&
            response.data != null) {
          ShowFlutterToast().showFlutterToastSuccess(response.data['message']);
        } else {
          final errorMessage =
              response.data?['message'] ?? 'Unexpected error occurred';
          throw ApiException(errorMessage);
        }
      }
    } on DioException catch (error) {
      log('caught error');
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error creating leave request $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<List<MyLeaveRequestItem>?> fetchMyLeaveRequests() async {
    final user = KAppX.globalProvider.read(userProvider);
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.leaveMyRequests(user?.userId ?? 0),
        );
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final leaveRequest = MyLeaveRequestsModel.fromJson(jsonMap).data;
          return leaveRequest;
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
      log('error fetching my leave requests $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<List<UnpaidLeaveCategoryItem>?> fetchUnpaidLeaveCategories() async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(ApiEndPoint.unpaidLeavecategories);
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final unpaidLeave = UnpaidLeaveCategoryModel.fromJson(jsonMap).data;
          return unpaidLeave;
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
      log('error fetching unpaid leave categories $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<List<MourningLeaveRelationItem>?> fetchMourningLeaveRelation() async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(ApiEndPoint.mourningLeaveRelation);
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final leaveRelation = MourningLeaveRelationModel.fromJson(
            jsonMap,
          ).data;
          return leaveRelation;
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
      log('error fetching mourning leave relation $e');
      throw ApiException(e.toString());
    }
  }
}
