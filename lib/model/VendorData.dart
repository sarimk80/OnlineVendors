import 'package:json_annotation/json_annotation.dart';

part 'VendorData.g.dart';

@JsonSerializable()
class VendorData {
  final String uuid;
  final String name;
  final String description;
  final String price;
  final String type;
  final String imageUrl;
  final String senderName;
  final String senderImage;

  VendorData(
      {this.name,
      this.description,
      this.price,
      this.type,
      this.imageUrl,
      this.uuid,
      this.senderImage,
      this.senderName});

  factory VendorData.fromJson(Map<String, dynamic> json) =>
      _$VendorDataFromJson(json);

  Map<String, dynamic> toJson() => _$VendorDataToJson(this);
}
