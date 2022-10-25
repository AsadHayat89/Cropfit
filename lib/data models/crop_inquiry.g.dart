// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crop_inquiry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CropInquiry _$CropInquiryFromJson(Map<String, dynamic> json) => CropInquiry(
      id: json['id'] as String? ?? '0',
      cropId: json['cropId'] as String? ?? '0',
      farmerId: json['farmerId'] as String? ?? '0',
      investorId: json['investorId'] as String? ?? '0',
      acceptedStatus: json['acceptedStatus'] as bool? ?? false,
    );

Map<String, dynamic> _$CropInquiryToJson(CropInquiry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'investorId': instance.investorId,
      'farmerId': instance.farmerId,
      'cropId': instance.cropId,
      'acceptedStatus': instance.acceptedStatus,
    };
