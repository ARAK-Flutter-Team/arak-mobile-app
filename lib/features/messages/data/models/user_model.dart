class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? address;
  final String? role;
  final bool isActive;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.address,
    this.role,
    required this.isActive,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Unknown',
      email: json['email']?.toString() ?? '',
      phoneNumber: json['phoneNumber']?.toString(),
      address: json['address']?.toString(),
      role: json['role']?.toString(),
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'role': role,
      'isActive': isActive,
    };
  }
}