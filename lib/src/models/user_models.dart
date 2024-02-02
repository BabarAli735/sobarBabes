class UserModel {

  
  String? userBio;
  int? userBirthDay;
  int? userBirthMonth;
  int? userBirthYear;
  String? userCountry;
  String? userDeviceToken;
  String? userEmail;
  String? userFullname;
  String? userGender;
  Map<String, dynamic>? userGeoPoint;
  String? geohash;
  List<double>? geopoint;
  String? userId;
  String? userJobTitle;
  DateTime? userLastLogin;
  String? userLevel;
  String? userLocality;
  String? userPhoneNumber;
  String? userPhotoLink;
  DateTime? userRegDate;
  String? userSchool;
  String? userStatus;
  int? userTotalDisliked;
  int? userTotalLikes;

  UserModel({
     this.userBio,
     this.userBirthDay,
     this.userBirthMonth,
     this.userBirthYear,
     this.userCountry,
     this.userDeviceToken,
     this.userEmail,
     this.userFullname,
     this.userGender,
     this.userGeoPoint,
     this.geohash,
     this.geopoint,
     this.userId,
     this.userJobTitle,
     this.userLastLogin,
     this.userLevel,
     this.userLocality,
     this.userPhoneNumber,
     this.userPhotoLink,
     this.userRegDate,
     this.userSchool,
     this.userStatus,
     this.userTotalDisliked,
     this.userTotalLikes,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userBio: json['user_bio'] ?? '',
      userBirthDay: json['user_birth_day'] ?? 0,
      userBirthMonth: json['user_birth_month'] ?? 0,
      userBirthYear: json['user_birth_year'] ?? 0,
      userCountry: json['user_country'] ?? '',
      userDeviceToken: json['user_device_token'] ?? '',
      userEmail: json['user_email'] ?? '',
      userFullname: json['user_fullname'] ?? '',
      userGender: json['user_gender'] ?? '',
      userGeoPoint: json['user_geo_point'] ?? {},
      geohash: json['geohash'] ?? '',
      geopoint: json['geopoint']?.cast<double>() ?? [],
      userId: json['user_id'] ?? '',
      userJobTitle: json['user_job_title'] ?? '',
      userLastLogin: DateTime.parse(json['user_last_login'] ?? ''),
      userLevel: json['user_level'] ?? '',
      userLocality: json['user_locality'] ?? '',
      userPhoneNumber: json['user_phone_number'] ?? '',
      userPhotoLink: json['user_photo_link'] ?? '',
      userRegDate: DateTime.parse(json['user_reg_date'] ?? ''),
      userSchool: json['user_school'] ?? '',
      userStatus: json['user_status'] ?? '',
      userTotalDisliked: json['user_total_disliked'] ?? 0,
      userTotalLikes: json['user_total_likes'] ?? 0,
    );
  }

Map<String, dynamic> toJson() {
    return {
      'user_bio': userBio,
      'user_birth_day': userBirthDay,
      'user_birth_month': userBirthMonth,
      'user_birth_year': userBirthYear,
      'user_country': userCountry,
      'user_device_token': userDeviceToken,
      'user_email': userEmail,
      'user_fullname': userFullname,
      'user_gender': userGender,
      'user_geo_point': userGeoPoint,
      'geohash': geohash,
      'geopoint': geopoint,
      'user_id': userId,
      'user_job_title': userJobTitle,
      'user_last_login': userLastLogin!.toIso8601String(),
      'user_level': userLevel,
      'user_locality': userLocality,
      'user_phone_number': userPhoneNumber,
      'user_photo_link': userPhotoLink,
      'user_reg_date': userRegDate!.toIso8601String(),
      'user_school': userSchool,
      'user_status': userStatus,
      'user_total_disliked': userTotalDisliked,
      'user_total_likes': userTotalLikes,
    };
  }
}
