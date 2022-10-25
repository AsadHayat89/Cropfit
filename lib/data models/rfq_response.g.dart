// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rfq_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RFQResponse _$RFQResponseFromJson(Map<String, dynamic> json) => RFQResponse(
      id: json['id'] as String? ?? '0',
      cropId: json['cropId'] as String? ?? '0',
      farmerId: json['farmerId'] as String? ?? '0',
      investorId: json['investorId'] as String? ?? '0',
      inquiryId: json['inquiryId'] as String? ?? '0',
      inquiryresponseId: json['inquiryresponseId'] as String? ?? '0',
      rfqId: json['rfqId'] as String? ?? '0',
      acceptedStatus: json['acceptedStatus'] as String?,
      cropQuantityLimit: json['cropQuantityLimit'] as String?,
      cropTimeLimit: json['cropTimeLimit'] as String?,
    );

Map<String, dynamic> _$RFQResponseToJson(RFQResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'investorId': instance.investorId,
      'farmerId': instance.farmerId,
      'cropId': instance.cropId,
      'inquiryId': instance.inquiryId,
      'inquiryresponseId': instance.inquiryresponseId,
      'rfqId': instance.rfqId,
      'cropQuantityLimit': instance.cropQuantityLimit,
      'cropTimeLimit': instance.cropTimeLimit,
      'acceptedStatus': instance.acceptedStatus,
    };
