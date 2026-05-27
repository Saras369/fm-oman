import 'package:code_setup/modules/data/models/behalf_of_user_model.dart';
import 'package:code_setup/modules/data/models/diplomatic_services/country_model.dart';
import 'package:code_setup/modules/data/models/file_upload_data_model.dart';
import 'package:code_setup/modules/data/models/get_user_by_id_model.dart';
import 'package:code_setup/repository/data/auth_repositpry_impl.dart';
import 'package:dio/dio.dart';

abstract class AuthRepository {
  factory AuthRepository() => AuthRepositpryImpl();

  Future<Map<String, dynamic>?> getAuthTokenWithSSOAccessToken(
    String accessToken,
  );
  Future<UserData?> getUserDataById({int? userId});
  Future<FileUploadDataModel?> uploadFile(FormData formData);
  Future<List<BehalfOfUserItem>?> fetchBehalfOfUsers(
    Map<String, dynamic> queryParams,
  );
  Future<List<CountryItem>?> fetchCountries();
}
