// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Crop _$CropFromJson(Map<String, dynamic> json) => Crop(
      deal: json['deal'] as String? ?? '',
      quantity: json['quantity'] as String? ?? '',
      id: json['id'] as String? ?? '0',
      type: json['type'] as String? ?? '',
      picUrl: json['picUrl'] as String?,
      name: json['name'] as String? ?? '',
      price: json['price'] as int? ?? 0,
      farmerId: json['farmerId'] as String? ?? '0',
    );

Map<String, dynamic> _$CropToJson(Crop instance) => <String, dynamic>{
      'name': instance.name,
      'farmerId': instance.farmerId,
      'quantity': instance.quantity,
      'picUrl': instance.picUrl,
      'type': instance.type,
      'id': instance.id,
      'deal': instance.deal,
      'price': instance.price,
    };
