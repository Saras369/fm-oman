import 'package:code_setup/modules/data/models/telephone_directory/department_wise_directory_model.dart';
import 'package:code_setup/modules/data/models/telephone_directory/telephone_directory_by_department_model.dart';
import 'package:code_setup/repository/data/telephone_directory_repo_impl.dart';

abstract class TelephoneDirectoryRepo {
  factory TelephoneDirectoryRepo() => TelephoneDirectoryRepoImpl();

  Future<DepartmentCategoryItem?> fetchDepartemntCategoriesNList();

  Future<List<TelephoneDirectoryItem>?> fetchContactsList(
    int departmentId,
    Map<String, dynamic> queryParams,
  );

  Future<void> createTelephoneDirectory(Map<String, dynamic> data);
}
