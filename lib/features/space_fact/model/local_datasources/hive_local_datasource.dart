import 'package:hive/hive.dart';
import 'package:stellar_secrets/features/space_fact/model/data_models/space_fact.dart';

class HiveLocalDatasource {
  final _dailyFactHive = Hive.box('dailyFact');

  Future<void> addDailyFact({
    required SpaceFact spaceFact,
  }) async {
    final Map<String, dynamic> dailyFactData = {
      'copyright': spaceFact.copyright,
      'date': spaceFact.date,
      'explanation': spaceFact.description,
      'hdurl': spaceFact.hdUrl,
      'title': spaceFact.title,
      'url': spaceFact.url,
    };

    await _dailyFactHive.put(
      spaceFact.date,
      dailyFactData,
    );
  }

  Map<String, dynamic> getDailyFact({
    required String date,
  }) {
    final Map<String, dynamic> dailyFactData = {};
    final data = _dailyFactHive.get(date) as Map;

    data.forEach((key, value) {
      dailyFactData.addAll({key as String: value as dynamic});
    });

    return dailyFactData;
  }

  bool checkIfDailyFactIsSaved({
    required String date,
  }) {
    return _dailyFactHive.containsKey(date);
  }
}
