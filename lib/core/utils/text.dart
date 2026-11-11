String trimText(String value) {
  return value.trim();
}

String? trimNullableText(String? value) {
  if (value == null) return null;
  final trimmed = trimText(value);
  return trimmed.isEmpty ? null : trimmed;
}

String normalizeText(String value) => trimText(value);

String? normalizeNullableText(String? value) => trimNullableText(value);

String capitalizeText(String value) => trimText(value);
