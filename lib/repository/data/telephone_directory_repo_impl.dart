import 'dart:developer';

import 'package:code_setup/modules/data/models/telephone_directory/department_wise_directory_model.dart';
import 'package:code_setup/modules/data/models/telephone_directory/telephone_directory_by_department_model.dart';
import 'package:code_setup/presentation/common_widgets/show_toast.dart';
import 'package:code_setup/repository/domain/telephone_directory_repo.dart';
import 'package:code_setup/utils/api_end_points.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:dio/dio.dart';

class TelephoneDirectoryRepoImpl implements TelephoneDirectoryRepo {
  @override
  @override
  Future<void> createTelephoneDirectory(Map<String, dynamic> data) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.post(
          ApiEndPoint.createTelephoneDirectory,
          data: data,
        );
        if ((response.statusCode == 200 || response.statusCode == 201) &&
            response.data != null) {
          // Construct AttendanceData from JSON
          ShowFlutterToast().showFlutterToastSuccess(response.data['message']);
        } else {
          final errorMessage =
              response.data?['message'] ?? 'Unexpected error occurred';
          throw ApiException(errorMessage);
        }
      }
      return;
    } on DioException catch (error) {
      log('caught error');
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error creating telephone directory $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<List<TelephoneDirectoryItem>?> fetchContactsList(
    int departmentId,
    Map<String, dynamic> queryParams,
  ) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.telephoneDirectory(departmentId),
          queryParameters: queryParams,
        );
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final contactList = TelephoneDirectoryByDepartmentModel.fromJson(
            jsonMap,
          ).data;
          return contactList;
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
      log('error fetching helpdesk issue types $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<DepartmentCategoryItem?> fetchDepartemntCategoriesNList() async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(ApiEndPoint.departmentCategoryNList);
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final contactList = DepartmentWiseDirectoryModel.fromJson(
            jsonMap,
          ).data;
          return contactList;
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
      log('error fetching helpdesk issue types $e');
      throw ApiException(e.toString());
    }
  }
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);
  @override
  String toString() => message;
}
