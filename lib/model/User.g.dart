// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    name: json['name'] as String,
    email: json['email'] as String,
    imageUrl: json['imageUrl'] as String,
    isVendor: json['isVendor'] as bool,
    phoneNumber: json['phoneNumber'] as String,
    address: json['address'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'imageUrl': instance.imageUrl,
      'isVendor': instance.isVendor,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
    };
