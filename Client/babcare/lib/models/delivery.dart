import 'base_user.dart';

class Delivery extends BaseUser {
  Delivery(
      {location,
      username,
      email,
      phone,
      photo,
      token,
      notifications,
      id,
      createdAt,
      lastUpdate,
      password});
  @override
  Delivery fromJson(Map<String, dynamic> json) {
    return super.fromJson(json) as Delivery;
  }
}
