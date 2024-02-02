import 'package:equatable/equatable.dart';

class SpaceFact extends Equatable {
  final String copyright;
  final String date;
  final String description;
  final String hdUrl;
  final String title;
  final String url;

  SpaceFact({
    required this.copyright,
    required this.date,
    required this.description,
    required this.hdUrl,
    required this.title,
    required this.url,
  });

  factory SpaceFact.fromJson(Map<String, dynamic> json) {
    return SpaceFact(
      copyright: (json['copyright'] as String?) ?? '',
      date: json['date'] as String,
      description: json['explanation'] as String,
      hdUrl: (json['hdurl'] as String?) ?? '',
      title: json['title'] as String,
      url: (json['url'] as String?) ?? '',
    );
  }

  @override
  List<Object?> get props => [
        copyright,
        date,
        description,
        hdUrl,
        title,
        url,
      ];
}
