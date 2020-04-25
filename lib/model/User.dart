import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  final String name;
  final String email;
  final String imageUrl;
  final bool isVendor;
  final String phoneNumber;
  final String address;

  User(
      {this.name,
      this.email,
      this.imageUrl,
      this.isVendor,
      this.phoneNumber,
      this.address});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
