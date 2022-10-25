import 'package:json_annotation/json_annotation.dart';
part 'rfq.g.dart';
@JsonSerializable()
class RFQ {
  String id, investorId, farmerId, cropId,inquiryId,inquiryresponseId;
  String? cropRequiredQuantity,cropRequiredTime,needTransportService,mentionPreference;

  factory RFQ.fromJson(Map<String, dynamic> json) => _$RFQFromJson(json);
  toJson() => _$RFQToJson(this);

  RFQ ({
    this.id='0',
    this.cropId='0',
    this.farmerId='0',
    this.investorId='0',
    this.inquiryId='0',
    this.inquiryresponseId='0',
    this.cropRequiredQuantity,
    this.cropRequiredTime,
    this.needTransportService,
    this.mentionPreference,
  });
}