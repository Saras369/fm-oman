/// Tolerant decoding for financial APIs that sometimes return bare ids and
/// sometimes nested `{ "id": ... }` objects.
int? readJsonInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value);
  if (value is Map) {
    final id = value['id'];
    if (id is int) return id;
    if (id is double) return id.toInt();
    if (id is String) return int.tryParse(id);
  }
  return null;
}

Map<String, dynamic>? readJsonMap(dynamic value) {
  if (value is Map<String, dynamic>) return value;
  if (value is Map) return Map<String, dynamic>.from(value);
  return null;
}

num? readJsonNum(dynamic value) {
  if (value == null) return null;
  if (value is num) return value;
  if (value is String) return num.tryParse(value);
  return null;
}

String? readJsonString(dynamic value) {
  if (value == null) return null;
  if (value is String) return value;
  return value.toString();
}

bool? readJsonBool(dynamic value) {
  if (value == null) return null;
  if (value is bool) return value;
  if (value is String) {
    final s = value.toLowerCase();
    if (s == 'true' || s == '1') return true;
    if (s == 'false' || s == '0') return false;
  }
  if (value is num) return value != 0;
  return null;
}
