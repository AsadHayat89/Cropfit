import 'package:json_annotation/json_annotation.dart';
part 'rfq_response.g.dart';
@JsonSerializable()
class RFQResponse {
  String id, investorId, farmerId, cropId,inquiryId,inquiryresponseId,rfqId;
  String? cropQuantityLimit,cropTimeLimit,acceptedStatus;

  factory RFQResponse.fromJson(Map<String, dynamic> json) => _$RFQResponseFromJson(json);
  toJson() => _$RFQResponseToJson(this);

  RFQResponse ({
    this.id='0',
    this.cropId='0',
    this.farmerId='0',
    this.investorId='0',
    this.inquiryId='0',
    this.inquiryresponseId='0',
    this.rfqId='0',
    this.acceptedStatus,
    this.cropQuantityLimit,
    this.cropTimeLimit,
  });
}