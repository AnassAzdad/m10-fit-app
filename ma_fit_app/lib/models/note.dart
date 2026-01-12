class Note {
  final String id;
  final String userId;
  final String text;
  final DateTime createdAt;

  Note({
    required this.id,
    required this.userId,
    required this.text,
    required this.createdAt,
  });

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      userId: map['user_id'],
      text: map['text'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}
