import 'dart:convert';

class NotificationTable {
  int? nId;
  int? notificationMid;
  String? nCurrentTime;
  String? nName;
  String? nDosage;
  String? nColorPhotoType;
  String? nColorPhoto;
  String? nSoundType;
  String? nStartDate;
  String? nEndDate;
  String? nFrequencyType;
  String? nDayOfWeek;
  String? nTime;
  int? nIsActive;
  String? nNotificationTime;
  int? nIsFromDevice;
  String? nDeviceSoundUri;

  NotificationTable({
    this.nId,
    this.notificationMid,
    this.nCurrentTime,
    this.nName,
    this.nDosage,
    this.nColorPhotoType,
    this.nColorPhoto,
    this.nSoundType,
    this.nStartDate,
    this.nEndDate,
    this.nFrequencyType,
    this.nDayOfWeek,
    this.nTime,
    this.nIsActive,
    this.nNotificationTime,
    this.nIsFromDevice,
    this.nDeviceSoundUri,
  });

  factory NotificationTable.fromRawJson(String str) =>
      NotificationTable.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationTable.fromJson(Map<String, dynamic> json) => NotificationTable(
       nId: json["nId"],
       notificationMid: json["notificationMid"],
       nCurrentTime: json["nCurrentTime"],
       nName: json["nName"],
       nDosage: json["nDosage"],
       nColorPhotoType: json["nColorPhotoType"],
       nColorPhoto: json["nColorPhoto"],
       nSoundType: json["nSoundType"],
       nStartDate: json["nStartDate"],
       nEndDate: json["nEndDate"],
       nFrequencyType: json["nFrequencyType"],
       nDayOfWeek: json["nDayOfWeek"],
       nTime: json["nTime"],
       nIsActive: json["nIsActive"],
       nNotificationTime: json["nNotificationTime"],
       nIsFromDevice: json["nIsFromDevice"],
       nDeviceSoundUri: json["nDeviceSoundUri"],

      );

  Map<String, dynamic> toJson() => {
        "nId": nId,
        "notificationMid": notificationMid,
        "nCurrentTime": nCurrentTime,
        "nName": nName,
        "nDosage": nDosage,
        "nColorPhotoType": nColorPhotoType,
        "nColorPhoto": nColorPhoto,
        "nSoundType": nSoundType,
        "nStartDate": nStartDate,
        "nEndDate": nEndDate,
        "nFrequencyType": nFrequencyType,
        "nDayOfWeek": nDayOfWeek,
        "nTime": nTime,
        "nIsActive": nIsActive,
        "nNotificationTime": nNotificationTime,
        "nIsFromDevice": nIsFromDevice,
        "nDeviceSoundUri": nDeviceSoundUri,
      };
  factory NotificationTable.fromMap(Map<String, dynamic> map) {
    return NotificationTable(
      nId: map['nId'],
      notificationMid: map['notificationMid'],
      nCurrentTime: map['nCurrentTime'],
      nName: map['nName'],
      nDosage: map['nDosage'],
      nColorPhotoType: map['nColorPhotoType'],
      nColorPhoto: map['nColorPhoto'],
      nSoundType: map['nSoundType'],
      nStartDate: map['nStartDate'],
      nEndDate: map['nEndDate'],
      nFrequencyType: map['nFrequencyType'],
      nDayOfWeek: map['nDayOfWeek'],
      nTime: map['nTime'],
      nIsActive: map['nIsActive'],
      nNotificationTime: map['nNotificationTime'],
      nIsFromDevice: map['nIsFromDevice'],
      nDeviceSoundUri: map['nDeviceSoundUri'],
    );
  }
}


























