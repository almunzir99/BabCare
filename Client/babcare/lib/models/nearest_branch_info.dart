import 'package:babcare/models/branch.dart';

class NearestBranchInfo {
  Branch? nearestBranch;
  double? distance;
  NearestBranchInfo({this.nearestBranch, this.distance});
  NearestBranchInfo.fromJson(Map<String, dynamic> json) {
    nearestBranch = (json['nearestBranch'] == null)
        ? null
        : Branch.fromJson(json['nearestBranch']);
    distance = json['distance'];
  }
}
