import 'package:code_setup/presentation/screens/holidays_list/models/holiday_model.dart';
import 'package:code_setup/repository/data/holidays_repo_impl.dart';

abstract class HolidaysRepo {
  factory HolidaysRepo() => HolidaysRepoImpl();

  Future<HolidayModel?> fetchHolidayList({required int year});
}
