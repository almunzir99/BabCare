import 'package:babcare/models/base_user.dart';

class Customer extends BaseUser {
  Customer(
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
      password})
      : super(
            location: location,
            username: username,
            email: email,
            password: password,
            phone: phone,
            photo: phone,
            token: token,
            id: id,
            createdAt: createdAt,
            lastUpdate: lastUpdate);
  @override
  Customer fromJson(Map<String, dynamic> json) {
    return super.fromJson(json) as Customer;
  }
}
