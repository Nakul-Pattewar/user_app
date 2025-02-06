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
