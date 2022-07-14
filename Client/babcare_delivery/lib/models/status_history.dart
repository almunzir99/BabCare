class StatusHistory {
  int? status;
  String? comment;
  int? id;
  String? createdAt;
  String? lastUpdate;
  String? formattedDate;

  StatusHistory(
      {this.status,
      this.comment,
      this.id,
      this.createdAt,
      this.lastUpdate,
      this.formattedDate});

  StatusHistory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    comment = json['comment'];
    id = json['id'];
    createdAt = json['createdAt'];
    lastUpdate = json['lastUpdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['comment'] = comment;
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['lastUpdate'] = lastUpdate;
    return data;
  }
}
