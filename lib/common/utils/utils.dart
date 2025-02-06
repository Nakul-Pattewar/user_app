String getUserNameInitials(String name) {
  List<String> nameParts = name.trim().split(RegExp(r'\s+'));
  String initials = '';

  for (int i = 0; i < nameParts.length && initials.length < 2; i++) {
    String part = nameParts[i].replaceAll(RegExp(r'[^A-Za-z]'), '');
    if (part.isNotEmpty) {
      initials += part[0].toUpperCase();
    }
  }

  return initials;
}

String? validateEmail(String value) {
  final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  if (value.isEmpty) {
    return "Email can't be empty";
  } else if (!emailRegex.hasMatch(value)) {
    return "Enter a valid email";
  }
  return null;
}

String? validateName(String value) {
  if (value.isEmpty) {
    return "Name can't be empty";
  }
  return null;
}
