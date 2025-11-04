/*--form 'email="a@a.com"' \
--form 'password="asd"' \
--form 'confirm_password="asd"' \
--form 'first_name="ascasd"' \
--form 'last_name="dasdad"' \
--form 'nationality_id="261"' \
--form 'residency_id="261"' \
--form 'gender="Male"' \
--form 'phone="+962788888822"'*/

class RegisterParams {
  final String email;
  final String password;
  final String confirmPassword;
  final String firstName;
  final String lastName;
  final int nationalityId;
  final int residencyId;
  final String gender;
  final String phone;

  RegisterParams(
    this.email,
    this.password,
    this.confirmPassword,
    this.firstName,
    this.lastName,
    this.nationalityId,
    this.residencyId,
    this.gender,
    this.phone,
  );

  Map<String, Object> toJson() => {
    'email': email,
    'password': password,
    'confirm_password': confirmPassword,
    'first_name': firstName,
    'last_name': lastName,
    'nationality_id': nationalityId,
    'residency_id': residencyId,
    'gender': gender,
    'phone': phone,
  };
}
