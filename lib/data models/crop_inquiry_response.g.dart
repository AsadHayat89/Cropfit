// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crop_inquiry_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CropInquiryResponse _$CropInquiryResponseFromJson(Map<String, dynamic> json) =>
    CropInquiryResponse(
      id: json['id'] as String? ?? '0',
      cropId: json['cropId'] as String? ?? '0',
      inquiryId: json['inquiryId'] as String? ?? '0',
      farmerId: json['farmerId'] as String? ?? '0',
      investorId: json['investorId'] as String? ?? '0',
      acceptedStatus: json['acceptedStatus'] as bool? ?? true,
    );

Map<String, dynamic> _$CropInquiryResponseToJson(
        CropInquiryResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'investorId': instance.investorId,
      'farmerId': instance.farmerId,
      'inquiryId': instance.inquiryId,
      'cropId': instance.cropId,
      'acceptedStatus': instance.acceptedStatus,
    };
