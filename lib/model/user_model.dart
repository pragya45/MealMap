class UserModel {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String gender;
  final String bio;
  final String location;

  UserModel({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.bio,
    required this.location,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      gender: json['gender'] ?? '',
      bio: json['bio'] ?? '',
      location: json['location'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'bio': bio,
      'location': location,
    };
  }

  UserModel copyWith({
    String? fullName,
    String? email,
    String? phoneNumber,
    String? gender,
    String? bio,
    String? location,
  }) {
    return UserModel(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      bio: bio ?? this.bio,
      location: location ?? this.location,
    );
  }
}
