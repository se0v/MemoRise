class Notes {
  final String title;
  final String subtitle;

  Notes({this.title = '', this.subtitle = ''});

  Notes copyWith({
    String? title,
    String? subtitle,
  }) {
    return Notes(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
    );
  }

  factory Notes.fromJson(Map<String, dynamic> json) {
    return Notes(
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
