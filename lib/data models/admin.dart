import 'package:json_annotation/json_annotation.dart';
part 'admin.g.dart';

@JsonSerializable()
class Admin {
  String adminEmail,adminPassword;
  String? adminPicUrl, adminName,adminCoverUrl;


  factory Admin.fromJson(Map<String, dynamic> json) => _$AdminFromJson(json);
  toJson() => _$AdminToJson(this);

  Admin({
    this.adminEmail = '',
    this.adminPassword= '',
    this.adminPicUrl,
    this.adminName,
    this.adminCoverUrl,
  });
}