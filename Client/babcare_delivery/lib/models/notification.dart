class Notification {
  String? title;
  String? message;
  String? action;
  String? module;
  String? url;
  bool? read;
  int? id;
  String? createdAt;
  String? lastUpdate;

  Notification({
    this.title,
    this.message,
    this.action,
    this.module,
    this.url,
    this.read,
    this.id,
    this.createdAt,
    this.lastUpdate,
  });

  Notification.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
    action = json['action'];
    module = json['module'];
    url = json['url'];
    read = json['read'];
    id = json['id'];
    createdAt = json['createdAt'];
    lastUpdate = json['lastUpdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['message'] = message;
    data['action'] = action;
    data['module'] = module;
    data['url'] = url;
    data['read'] = read;
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['lastUpdate'] = lastUpdate;
    return data;
  }
}
