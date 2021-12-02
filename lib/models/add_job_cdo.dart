class JobCDOModel {
  String? jobType;
  String? jobDescription;
  DateTime? dateCreated;
  String? policeStation;
  String? uidCDO;
  bool? jobCompleted;
  String? assignedSolicitor;
  List? interestedSolicitors;

  JobCDOModel(
      {this.jobType,
      this.jobDescription,
      this.dateCreated,
      this.policeStation,
      this.uidCDO,
      this.jobCompleted,
      this.assignedSolicitor,
      this.interestedSolicitors});

  Map<String, dynamic> toMap() {
    return {
      'jobType': jobType,
      'jobDescription': jobDescription,
      'dateCreated': dateCreated,
      'policeStation': policeStation,
      'uidCDO': uidCDO,
      'jobCompleted': jobCompleted,
      'assignedSolicitor': assignedSolicitor,
      'interestedSolicitors': interestedSolicitors
    };
  }
}
