import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  UserModel({
    required this.id,
    required this.name,
  });

  String get initial =>
      name.isNotEmpty ? name[0].toUpperCase() : '';
}
