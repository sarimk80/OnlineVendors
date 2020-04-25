import 'package:json_annotation/json_annotation.dart';

part 'VendorData.g.dart';

@JsonSerializable()
class VendorData {
  final String name;
  final String description;
  final String price;
  final String type;
  final String imageUrl;

  VendorData(
      {this.name, this.description, this.price, this.type, this.imageUrl});

  factory VendorData.fromJson(Map<String, dynamic> json) =>
      _$VendorDataFromJson(json);

  Map<String, dynamic> toJson() => _$VendorDataToJson(this);
}
