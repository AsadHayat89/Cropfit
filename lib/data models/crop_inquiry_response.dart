import 'package:json_annotation/json_annotation.dart';
part 'crop_inquiry_response.g.dart';

@JsonSerializable()
class CropInquiryResponse {
  String id, investorId, farmerId, inquiryId,cropId;
  bool acceptedStatus;

  factory CropInquiryResponse.fromJson(Map<String, dynamic> json) => _$CropInquiryResponseFromJson(json);
  toJson() => _$CropInquiryResponseToJson(this);

  CropInquiryResponse({
    this.id='0',
    this.cropId='0',
    this.inquiryId='0',
    this.farmerId='0',
    this.investorId='0',
    this.acceptedStatus = true,
  });
}
