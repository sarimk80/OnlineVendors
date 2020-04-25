// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VendorData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VendorData _$VendorDataFromJson(Map<String, dynamic> json) {
  return VendorData(
    name: json['name'] as String,
    description: json['description'] as String,
    price: json['price'] as String,
    type: json['type'] as String,
    imageUrl: json['imageUrl'] as String,
    uuid: json['uuid'] as String,
    senderImage: json['senderImage'] as String,
    senderName: json['senderName'] as String,
  );
}

Map<String, dynamic> _$VendorDataToJson(VendorData instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'type': instance.type,
      'imageUrl': instance.imageUrl,
      'senderName': instance.senderName,
      'senderImage': instance.senderImage,
    };
