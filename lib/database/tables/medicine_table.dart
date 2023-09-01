import 'dart:convert';

class MedicineTable {
  int? mId;
  String? mName;
  String? mDosage;
  String? mColorPhotoType;
  String? mColorPhoto;
  String? mSoundType;
  String? mStartDate;
  String? mEndDate;
  String? mFrequencyType;
  String? mDayOfWeek;
  String? mTime;
  int? mIsActive;
  String? mCurrentTime;
  int? mIsFromDevice;
  String? mDeviceSoundUri;
  String? mSoundTitle;

  MedicineTable({
    this.mId,
    this.mName,
    this.mDosage,
    this.mColorPhotoType,
    this.mColorPhoto,
    this.mSoundType,
    this.mStartDate,
    this.mEndDate,
    this.mFrequencyType,
    this.mDayOfWeek,
    this.mTime,
    this.mIsActive,
    this.mCurrentTime,
    this.mIsFromDevice,
    this.mDeviceSoundUri,
    this.mSoundTitle,
  });

  factory MedicineTable.fromRawJson(String str) =>
      MedicineTable.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MedicineTable.fromJson(Map<String, dynamic> json) => MedicineTable(
        mId: json["mId"],
        mName: json["mName"],
        mDosage: json["mDosage"],
        mColorPhotoType: json["mColorPhotoType"],
        mColorPhoto: json["mColorPhoto"],
        mSoundType: json["mSoundType"],
        mStartDate: json["mStartDate"],
        mEndDate: json["mEndDate"],
        mFrequencyType: json["mFrequencyType"],
        mDayOfWeek: json["mDayOfWeek"],
        mTime: json["mTime"],
        mIsActive: json["mIsActive"],
        mCurrentTime: json["mCurrentTime"],
        mIsFromDevice: json["mIsFromDevice"],
        mDeviceSoundUri: json["mDeviceSoundUri"],
        mSoundTitle: json["mSoundTitle"],
      );

  Map<String, dynamic> toJson() => {
        "mId": mId,
        "mName": mName,
        "mDosage": mDosage,
        "mColorPhotoType": mColorPhotoType,
        "mColorPhoto": mColorPhoto,
        "mSoundType": mSoundType,
        "mStartDate": mStartDate,
        "mEndDate": mEndDate,
        "mFrequencyType": mFrequencyType,
        "mDayOfWeek": mDayOfWeek,
        "mTime": mTime,
        "mIsActive": mIsActive,
        "mCurrentTime": mCurrentTime,
        "mIsFromDevice": mIsFromDevice,
        "mDeviceSoundUri": mDeviceSoundUri,
        "mSoundTitle": mSoundTitle,
      };
  factory MedicineTable.fromMap(Map<String, dynamic> map) {
    return MedicineTable(
      mId: map["mId"],
      mName: map["mName"],
      mDosage: map["mDosage"],
      mColorPhotoType: map["mColorPhotoType"],
      mColorPhoto: map["mColorPhoto"],
      mSoundType: map["mSoundType"],
      mStartDate: map["mStartDate"],
      mEndDate: map["mEndDate"],
      mFrequencyType: map["mFrequencyType"],
      mDayOfWeek: map["mDayOfWeek"],
      mTime: map["mTime"],
      mIsActive: map["mIsActive"],
      mCurrentTime: map["mCurrentTime"],
      mIsFromDevice: map["mIsFromDevice"],
      mDeviceSoundUri: map["mDeviceSoundUri"],
      mSoundTitle: map["mSoundTitle"],
    );
  }
}
