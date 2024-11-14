class RegistrationModal {
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNumber;
  String? callingMobileNumber;
  String? streetAddress;
  String? state;
  String? city;
  String? pinCode;
  String? fullAddress;
  String? workingLevel1;
  String? workingLevel2;
  String? latitude;
  String? longitude;

  RegistrationModal({
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNumber,
    this.callingMobileNumber,
    this.streetAddress,
    this.state,
    this.city,
    this.pinCode,
    this.fullAddress,
    this.workingLevel1,
    this.workingLevel2,
    this.latitude,
    this.longitude,
  });

  factory RegistrationModal.fromJson(Map<String, dynamic> json) {
    return RegistrationModal(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      callingMobileNumber: json['callingMobileNumber'] as String?,
      streetAddress: json['streetAddress'] as String?,
      state: json['state'] as String?,
      city: json['city'] as String?,
      pinCode: json['pinCode'] as String?,
      fullAddress: json['fullAddress'] as String?,
      workingLevel1: json['workingLevel1'] as String?,
      workingLevel2: json['workingLevel2'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'mobileNumber': mobileNumber,
        'email': email,
        'callingMobileNumber': callingMobileNumber,
        'streetAddress': streetAddress,
        'state': state,
        'city': city,
        'pinCode': pinCode,
        'fullAddress':
            "$streetAddress $city $state $pinCode",
        'workingLevel1': workingLevel1,
        'workingLevel2': workingLevel2,
        'latitude': latitude,
        'longitude': longitude,
      };

  RegistrationModal copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? mobileNumber,
    String? callingMobileNumber,
    String? streetAddress,
    String? state,
    String? city,
    String? pinCode,
    String? fullAddress,
    String? workingLevel1,
    String? workingLevel2,
    String? latitude,
    String? longitude,
  }) {
    return RegistrationModal(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      callingMobileNumber: callingMobileNumber ?? this.callingMobileNumber,
      streetAddress: streetAddress ?? this.streetAddress,
      state: state ?? this.state,
      city: city ?? this.city,
      pinCode: pinCode ?? this.pinCode,
      fullAddress: fullAddress ?? this.fullAddress,
      workingLevel1: workingLevel1 ?? this.workingLevel1,
      workingLevel2: workingLevel2 ?? this.workingLevel2,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
