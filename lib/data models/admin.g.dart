// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Admin _$AdminFromJson(Map<String, dynamic> json) => Admin(
      adminEmail: json['adminEmail'] as String? ?? '',
      adminPassword: json['adminPassword'] as String? ?? '',
      adminPicUrl: json['adminPicUrl'] as String?,
      adminName: json['adminName'] as String?,
      adminCoverUrl: json['adminCoverUrl'] as String?,
    );

Map<String, dynamic> _$AdminToJson(Admin instance) => <String, dynamic>{
      'adminEmail': instance.adminEmail,
      'adminPassword': instance.adminPassword,
      'adminPicUrl': instance.adminPicUrl,
      'adminName': instance.adminName,
      'adminCoverUrl': instance.adminCoverUrl,
    };
