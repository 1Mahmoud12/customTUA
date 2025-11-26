class CheckoutAsVisitorParms {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  CheckoutAsVisitorParms({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
    };
  }

  factory CheckoutAsVisitorParms.fromJson(Map<String, dynamic> json) {
    return CheckoutAsVisitorParms(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
    );
  }
}
