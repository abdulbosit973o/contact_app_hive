import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'contact_data.g.dart';

@HiveType(typeId: 0)
class ContactData extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
   String name;

  @HiveField(2)
   String phone;

  @HiveField(3)
  final String image;

  ContactData({
    required this.id,
    required this.name,
    required this.phone,
    required this.image,
  });

  factory ContactData.fromJson(Map<String, dynamic> json) => ContactData(
    id: json['id'],
    name: json['name'],
    phone: json['phone'],
    image: json['image'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'image': image,
  };
}