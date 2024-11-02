import 'package:handyman_provider_flutter/models/pagination_model.dart';

class UserTypeResponse {
  List<UserTypeData>? userTypeData;
  Pagination? pagination;

  UserTypeResponse({this.userTypeData, this.pagination});

  factory UserTypeResponse.fromJson(Map<String, dynamic> json) {
    return UserTypeResponse(
      userTypeData: json['data'] != null ? (json['data'] as List).map((i) => UserTypeData.fromJson(i)).toList() : null,
      pagination: json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userTypeData != null) {
      data['data'] = this.userTypeData!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class UserTypeData {
  String? createdAt;
  int? id;
  String? name;
  num? commission;
  int? status;
  String? type;
  String? updatedAt;
  String? deletedAt;
  int? createdBy;
  int? updatedBy;

  UserTypeData({
    this.createdAt,
    this.id,
    this.name,
    this.commission,
    this.status,
    this.type,
    this.updatedAt,
    this.deletedAt,
    this.createdBy,
    this.updatedBy,
  });

  factory UserTypeData.fromJson(Map<String, dynamic> json) {
    return UserTypeData(
      createdAt: json['created_at'],
      id: json['id'],
      name: json['name'],
      commission: json['commission'],
      status: json['status'],
      type: json['type'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['name'] = this.name;
    data['commission'] = this.commission;
    data['status'] = this.status;
    data['type'] = this.type;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}
