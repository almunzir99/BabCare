class Customer {
  String? location;
  String? username;
  String? email;
  String? phone;
  String? photo;
  String? token;
  String? password;
  List? notifications;
  int? id;
  String? createdAt;
  String? lastUpdate;

  Customer(
      {this.location,
      this.username,
      this.email,
      this.phone,
      this.photo,
      this.token,
      this.notifications,
      this.id,
      this.createdAt,
      this.lastUpdate,
      this.password});

  Customer.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    photo = json['photo'];
    token = json['token'];
    if (json['notifications'] != null) {
      notifications = [];
    }
    id = json['id'];
    createdAt = json['createdAt'];
    lastUpdate = json['lastUpdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['location'] = location;
    data['username'] = username;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    if (notifications != null) {
      // data['notifications'] = notifications.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
