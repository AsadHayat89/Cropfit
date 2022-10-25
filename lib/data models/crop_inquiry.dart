import 'package:json_annotation/json_annotation.dart';
part 'crop_inquiry.g.dart';

@JsonSerializable()
class CropInquiry {
  String id, investorId, farmerId, cropId;
  bool acceptedStatus;

  factory CropInquiry.fromJson(Map<String, dynamic> json) => _$CropInquiryFromJson(json);
  toJson() => _$CropInquiryToJson(this);

  CropInquiry({
    this.id='0',
    this.cropId='0',
    this.farmerId='0',
    this.investorId='0',
    this.acceptedStatus = false,
  });
}
