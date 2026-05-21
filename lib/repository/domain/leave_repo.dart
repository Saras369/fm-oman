import 'package:code_setup/modules/data/models/leave_request/leave_count_model.dart';
import 'package:code_setup/modules/data/models/leave_request/leave_type_model.dart';
import 'package:code_setup/modules/data/models/leave_request/mourning_leave_relation_model.dart';
import 'package:code_setup/modules/data/models/leave_request/my_leave_request_model.dart';
import 'package:code_setup/modules/data/models/leave_request/unpaid_leave_category_model.dart';
import 'package:code_setup/repository/data/leave_repo_impl.dart';

abstract class LeaveRepo {
  factory LeaveRepo() => LeaveRepoImpl();

  Future<LeaveTypeModel?> fetchLeaveTypes(String leaveType);
  Future<LeaveCountModel?> fetchLeaveCount();
  Future<void> createLeaveRequest(Map<String, dynamic> data);
  Future<List<MyLeaveRequestItem>?> fetchMyLeaveRequests();
  Future<List<UnpaidLeaveCategoryItem>?> fetchUnpaidLeaveCategories();
  Future<List<MourningLeaveRelationItem>?> fetchMourningLeaveRelation();
}
