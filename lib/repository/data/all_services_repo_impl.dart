import 'dart:developer';

import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/models/all_services_model.dart';
import 'package:code_setup/modules/data/models/bookmarks_model.dart';
import 'package:code_setup/presentation/screens/holidays_list/models/holiday_model.dart';
import 'package:code_setup/repository/data/attendance_repository_impl.dart';
import 'package:code_setup/repository/domain/all_services_repo.dart';
import 'package:code_setup/utils/api_end_points.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:dio/dio.dart';

class AllServicesRepoImpl implements AllServicesRepo {
  @override
  Future<List<AllServicesData>?> fetchAllServices() async {
    try {
      final client = await KAppX.network.secureClient();
      final user = KAppX.globalProvider.read(userProvider);
      final authCred = await KAuthCred().getUserMeta();
      ;
      final roleId = authCred?['role'] ?? 0;
      final departmentId = user?.department ?? 0;
      final sectionId = user?.section ?? 0;
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.allServices(
            user?.userId ?? 0,
            roleId,
            departmentId,
            sectionId,
          ),
        );
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final allServices = AllServicesModel.fromJson(jsonMap);
          return allServices.data;
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
  Future<List<Bookmarks>?> fetchBookmarks() async {
    try {
      final client = await KAppX.network.secureClient();
      final userData = KAppX.globalProvider.read(userProvider);
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.bookmarks(userData?.userId ?? 0),
        );
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final bookmarks = BookmarksModel.fromJson(jsonMap);
          return bookmarks.data;
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
  Future<void> updateBookmark(Map<String, dynamic> data) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.post(
          ApiEndPoint.createBookmarks,
          data: data,
        );
        if (response.statusCode == 200 && response.data != null) {
          // Construct AttendanceData from JSON
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
  Future<List<RoleDetails>?> getUserRoles() async {
    try {
      final client = await KAppX.network.secureClient();
      final userData = KAppX.globalProvider.read(userProvider);
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.userRoles(userData?.userId ?? 0),
        );
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final List<RoleDetails> userRoles =
              (jsonMap['data']['role_details'] as List?)
                  ?.map(
                    (item) =>
                        RoleDetails.fromJson(item as Map<String, dynamic>),
                  )
                  .toList() ??
              [];
          return userRoles;
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
