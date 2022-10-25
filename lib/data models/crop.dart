import 'package:json_annotation/json_annotation.dart';
part 'crop.g.dart';

@JsonSerializable()
class Crop {
  String name, farmerId,quantity;
  String? picUrl,type, id,deal;
  int?price;

  factory Crop.fromJson(Map<String, dynamic> json) => _$CropFromJson(json);
  toJson() => _$CropToJson(this);

  Crop({
    this.deal='',
    this.quantity='',
    this.id='0',
    this.type='',
    this.picUrl,
    this.name='',
    this.price=0,
    this.farmerId='0'
  });
}