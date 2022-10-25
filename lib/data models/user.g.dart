// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      email: json['email'] as String? ?? '',
      contact: json['contact'] as String? ?? '',
      password: json['password'] as String? ?? '',
      type: json['type'] as String? ?? '',
      picUrl: json['picUrl'] as String?,
      coverUrl: json['coverUrl'] as String?,
      name: json['name'] as String?,
      gender: json['gender'] as String?,
      dob: json['dob'] as String?,
      bio: json['bio'] as String?,
      cnicUrl: json['cnicUrl'] as String?,
      loc: json['loc'] as String?,
      cnic: json['cnic'] as String? ?? '',
      ChatIds: (json["ChatIds"] as List?)?.cast<String>().toList() ?? [],
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'contact': instance.contact,
      'password': instance.password,
      'type': instance.type,
      'cnic': instance.cnic,
      'picUrl': instance.picUrl,
      'name': instance.name,
      'gender': instance.gender,
      'dob': instance.dob,
      'bio': instance.bio,
      'cnicUrl': instance.cnicUrl,
      'loc': instance.loc,
      'coverUrl': instance.coverUrl,
    };
