import 'dart:convert';
import 'dart:developer';

import 'package:code_setup/modules/domain/core/storage/persistent_storage/persistent_storage.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// --- USER MODEL ---

class User {
  final int userId;
  final bool isAdmin;
  final String employeeId;
  final String employeeName;
  final String employeeArabicName;
  final int section;
  final String sectionName;
  final int designation;
  final String designationName;
  final int department;
  final String departmentName;
  final String email;
  final String accessToken;

  User({
    required this.userId,
    required this.isAdmin,
    required this.employeeId,
    required this.employeeName,
    required this.employeeArabicName,
    required this.section,
    required this.sectionName,
    required this.designation,
    required this.designationName,
    required this.department,
    required this.departmentName,
    required this.email,
    required this.accessToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'] as int,
      isAdmin: json['is_admin'] as bool,
      employeeId: json['employee_id'] as String,
      employeeName: json['employee_name'] as String,
      employeeArabicName: json['employee_arabic_name'] as String,
      section: json['section'] as int,
      sectionName: json['section_name'] as String,
      designation: json['designation'] as int,
      designationName: json['designation_name'] as String,
      department: json['department'] as int,
      departmentName: json['department_name'] as String,
      email: json['email'] as String,
      accessToken: json['accessToken'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'is_admin': isAdmin,
      'employee_id': employeeId,
      'employee_name': employeeName,
      'employee_arabic_name': employeeArabicName,
      'section': section,
      'section_name': sectionName,
      'designation': designation,
      'designation_name': designationName,
      'department': department,
      'department_name': departmentName,
      'email': email,
      'accessToken': accessToken,
    };
  }
}

// --- RIVERPOD PROVIDER for User ---

final userProvider = StateProvider<User?>((ref) => null);

// --- KAUTHCRED CLASS ---

class KAuthCred {
  static const storageKey = 'fm';
  static const metaKey = 'user_meta';

  final KPersistentStorage _persistentStorage;

  KAuthCred({KPersistentStorage? persistentStorage})
    : _persistentStorage = persistentStorage ?? KPersistentStorage();

  /// Store User profile in persistent storage and update Riverpod state
  Future<void> storeProfileData(User user) async {
    try {
      KAppX.globalProvider.read(userProvider.notifier).state = user;
      await _persistentStorage.store(
        key: storageKey,
        data: user.toJson(),
        encoder: jsonEncode,
        overwrite: true,
      );
      log('Successfully saved profile data to persistent storage.');
    } catch (e, st) {
      log('Error saving profile data to persistent storage: $e\n$st');
    }
  }

  /// Retrieve User profile from persistent storage and update Riverpod state
  Future<User?> getProfileData() async {
    try {
      final jsonData = await _persistentStorage.retrieve(
        key: storageKey,
        decoder: jsonDecode,
      );

      if (jsonData != null) {
        final user = User.fromJson(Map<String, dynamic>.from(jsonData));
        KAppX.globalProvider.read(userProvider.notifier).state = user;
        return user;
      }
    } catch (e, st) {
      log('Error retrieving profile data from persistent storage: $e\n$st');
    }
    return null;
  }

  /// Delete User profile from persistent storage and clear Riverpod state
  Future<void> deleteProfileData(WidgetRef ref) async {
    try {
      await _persistentStorage.delete(key: storageKey);
      ref.read(userProvider.notifier).state = null;
      log('Successfully deleted profile data from persistent storage.');
    } catch (e, st) {
      log('Error deleting profile data from persistent storage: $e\n$st');
    }
  }

  Future<void> storeUserMeta({
    required int role,
    required int departmentId,
    required int sectionId,
  }) async {
    final data = {
      'role': role,
      'department_id': departmentId,
      'section_id': sectionId,
    };

    await _persistentStorage.store(
      key: metaKey,
      data: data,
      encoder: jsonEncode,
      overwrite: true,
    );

    log('User meta stored: $data');
  }

  Future<Map<String, dynamic>?> getUserMeta() async {
    try {
      final jsonData = await _persistentStorage.retrieve(
        key: metaKey,
        decoder: jsonDecode,
      );

      if (jsonData != null) {
        return Map<String, dynamic>.from(jsonData);
      }
    } catch (e, st) {
      log('Error retrieving user meta: $e\n$st');
    }
    return null;
  }

  Future<void> deleteUserMeta() async {
    try {
      await _persistentStorage.delete(key: metaKey);
      log('User meta deleted');
    } catch (e, st) {
      log('Error deleting user meta: $e\n$st');
    }
  }

  /// Clears stored credentials and in-memory auth state (logout).
  Future<void> clearSession() async {
    try {
      await _persistentStorage.delete(key: storageKey);
      await deleteUserMeta();
      KAppX.globalProvider.read(userProvider.notifier).state = null;
      log('Session cleared.');
    } catch (e, st) {
      log('Error clearing session: $e\n$st');
      rethrow;
    }
  }
}
