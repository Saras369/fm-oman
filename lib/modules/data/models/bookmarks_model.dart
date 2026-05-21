import 'package:code_setup/modules/data/models/all_services_model.dart';
import 'package:code_setup/modules/data/models/attendance_management/my_attendance_request_model.dart';

class BookmarksModel {
  final List<Bookmarks>? data;

  BookmarksModel({this.data});

  factory BookmarksModel.fromJson(Map<String, dynamic> json) {
    return BookmarksModel(
      data: json['data'] != null
          ? (json['data'] as List).map((e) => Bookmarks.fromJson(e)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data?.map((e) => e.toJson()).toList(),
  };
}

class Bookmarks {
  final int? id;
  final String? userId;
  final String? serviceId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? serviceTableId;
  final String? serviceName;
  final String? serviceDescription;
  final String? serviceLogoUrl;
  final String? serviceCode;
  final List<SubServices>? subServices;

  Bookmarks({
    this.id,
    this.userId,
    this.serviceId,
    this.createdAt,
    this.updatedAt,
    this.serviceTableId,
    this.serviceName,
    this.serviceDescription,
    this.serviceLogoUrl,
    this.serviceCode,
    this.subServices,
  });

  factory Bookmarks.fromJson(Map<String, dynamic> json) {
    return Bookmarks(
      id: json['id'] is int ? json['id'] as int : int.tryParse('${json['id']}'),
      userId: json['user_id']?.toString(),
      serviceId: json['service_id']?.toString(),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      serviceTableId: json['service_table_id'] as int?,
      serviceName: json['service_name'] as String?,
      serviceDescription: json['service_description'] as String?,
      serviceLogoUrl: json['service_logo_url'] as String?,
      serviceCode: json['service_code'] as String?,
      subServices: json['sub_services'] != null
          ? (json['sub_services'] as List)
                .map((e) => SubServices.fromJson(e))
                .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'service_id': serviceId,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'service_table_id': serviceTableId,
    'service_name': serviceName,
    'service_description': serviceDescription,
    'service_logo_url': serviceLogoUrl,
    'service_code': serviceCode,
    'sub_services': subServices?.map((e) => e.toJson()).toList(),
  };
}
