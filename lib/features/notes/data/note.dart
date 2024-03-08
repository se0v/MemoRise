class Note {
  final String title;
  final String subtitle;

  Note({this.title = '', this.subtitle = ''});

  Note copyWith({
    String? title,
    String? subtitle,
  }) {
    return Note(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
    );
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      title: json['title'],
      subtitle: json['subtitle'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
    };
  }

  @override
  String toString() {
    return '''Note: {
      title: $title\n
      subtitle: $subtitle\n
    }''';
  }
}
