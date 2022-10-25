// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rfq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RFQ _$RFQFromJson(Map<String, dynamic> json) => RFQ(
      id: json['id'] as String? ?? '0',
      cropId: json['cropId'] as String? ?? '0',
      farmerId: json['farmerId'] as String? ?? '0',
      investorId: json['investorId'] as String? ?? '0',
      inquiryId: json['inquiryId'] as String? ?? '0',
      inquiryresponseId: json['inquiryresponseId'] as String? ?? '0',
      cropRequiredQuantity: json['cropRequiredQuantity'] as String?,
      cropRequiredTime: json['cropRequiredTime'] as String?,
      needTransportService: json['needTransportService'] as String?,
      mentionPreference: json['mentionPreference'] as String?,
    );

Map<String, dynamic> _$RFQToJson(RFQ instance) => <String, dynamic>{
      'id': instance.id,
      'investorId': instance.investorId,
      'farmerId': instance.farmerId,
      'cropId': instance.cropId,
      'inquiryId': instance.inquiryId,
      'inquiryresponseId': instance.inquiryresponseId,
      'cropRequiredQuantity': instance.cropRequiredQuantity,
      'cropRequiredTime': instance.cropRequiredTime,
      'needTransportService': instance.needTransportService,
      'mentionPreference': instance.mentionPreference,
    };
