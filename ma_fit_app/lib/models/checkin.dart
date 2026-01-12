class CheckIn {
  final String id;
  final String userId;
  final int mood;
  final String note;
  final DateTime date; // we noemen hem 'date' in de app
  final String opleiding;
  final String klas;

  CheckIn({
    required this.id,
    required this.userId,
    required this.mood,
    required this.note,
    required this.date,
    required this.opleiding,
    required this.klas,
  });

  factory CheckIn.fromMap(Map<String, dynamic> map) {
    return CheckIn(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      mood: (map['mood'] as num).toInt(),
      note: (map['note'] ?? '') as String,
      date: DateTime.parse(map['created_at'] as String),
      opleiding: (map['opleiding'] ?? '') as String,
      klas: (map['klas'] ?? '') as String,
    );
  }
}
