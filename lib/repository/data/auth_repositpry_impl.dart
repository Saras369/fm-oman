import 'dart:developer';

import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/models/behalf_of_user_model.dart';
import 'package:code_setup/modules/data/models/diplomatic_services/country_model.dart';
import 'package:code_setup/modules/data/models/file_upload_data_model.dart';
import 'package:code_setup/modules/data/models/get_user_by_id_model.dart';
import 'package:code_setup/repository/data/attendance_repository_impl.dart';
import 'package:code_setup/repository/domain/auth_repository.dart';
import 'package:code_setup/utils/api_end_points.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:dio/dio.dart';

class AuthRepositpryImpl implements AuthRepository {
  @override
  Future<Map<String, dynamic>?> getAuthTokenWithSSOAccessToken(
    String accessToken,
  ) async {
    try {
      final client = await KAppX.network.unsecureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.authMobileSignin,
          queryParameters: {'accessToken': accessToken},
        );
        if (response.statusCode == 200 && response.data != null) {
          return Map<String, dynamic>.from(response.data);
        } else {
          return null;
        }
      }
      return null;
    } catch (e) {}
    return null;
  }

  @override
  Future<UserData?> getUserDataById() async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.getUserById(
            '${KAppX.globalProvider.read(userProvider)?.userId ?? 0}',
          ),
        );
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final breakdownData = UserData.fromJson(jsonMap['data'] ?? {});
          return breakdownData;
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
      log('error fetching status breakdown $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<FileUploadDataModel?> uploadFile(FormData formData) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.post(
          ApiEndPoint.uploadFile,
          data: formData,
          options: Options(headers: {'Content-Type': 'multipart/form-data'}),
        );
        if ((response.statusCode == 200 || response.statusCode == 201) &&
            response.data != null) {
          final data = FileUploadDataModel.fromJson(response.data);
          return data;
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
      log('error fetching status breakdown $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<List<BehalfOfUserItem>?> fetchBehalfOfUsers(
    Map<String, dynamic> queryParams,
  ) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.getUserById(
            '${KAppX.globalProvider.read(userProvider)?.userId ?? 0}',
          ),
        );
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final usersList = BehalfOfUserModel.fromJson(jsonMap).data;
          return usersList;
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
      log('error fetching behalf of users $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<List<CountryItem>?> fetchCountries() async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(ApiEndPoint.fetchCountries);
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final countries = CountryModel.fromJson(jsonMap).data;
          return countries;
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
      log('error fetching countries $e');
      throw ApiException(e.toString());
    }
  }
}
