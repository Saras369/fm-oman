import 'package:code_setup/modules/data/models/all_services_model.dart';
import 'package:code_setup/modules/data/models/bookmarks_model.dart';
import 'package:code_setup/repository/data/all_services_repo_impl.dart';

abstract class AllServicesRepo {
  factory AllServicesRepo() => AllServicesRepoImpl();

  Future<List<AllServicesData>?> fetchAllServices();
  Future<List<Bookmarks>?> fetchBookmarks();
  Future<void> updateBookmark(Map<String, dynamic> data);
  Future<List<RoleDetails>?> getUserRoles();
}
