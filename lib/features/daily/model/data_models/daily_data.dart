import 'package:equatable/equatable.dart';

class DailyData extends Equatable {
  final String copyright;
  final String explanation;
  final String hdurl;
  final String title;
  final String url;

  DailyData({
    required this.copyright,
    required this.explanation,
    required this.hdurl,
    required this.title,
    required this.url,
  });

  factory DailyData.fromJson(Map<String, dynamic> json) {
    return DailyData(
      copyright: json['copyright'] as String,
      explanation: json['explanation'] as String,
      hdurl: json['hdurl'] as String,
      title: json['title'] as String,
      url: json['url'] as String,
    );
  }

  @override
  List<Object?> get props => [
        copyright,
        explanation,
        hdurl,
        title,
        url,
      ];
}
