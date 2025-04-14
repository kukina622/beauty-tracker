bool isEmailValid(String? email) {
  if (email == null || email.isEmpty) {
    return false;
  }
  const String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  final RegExp regex = RegExp(pattern);
  return regex.hasMatch(email);
}
