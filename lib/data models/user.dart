import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  String email, contact, password, type, cnic;
  String? picUrl, name, gender, dob, bio, cnicUrl, loc, coverUrl,
      appSatisfaction, valuableFeedback;
  double appRating;
  List<String> ChatIds;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  toJson() => _$UserToJson(this);

  User({
    this.email = '',
    this.contact = '',
    this.password = '',
    this.type = '',
    this.picUrl,
    this.coverUrl,
    this.name,
    this.gender,
    this.dob,
    this.bio,
    this.cnicUrl,
    this.loc,
    this.cnic = '',
    this.appRating = 0,
    this.appSatisfaction,
    this.valuableFeedback,
    required this.ChatIds,
  });
}