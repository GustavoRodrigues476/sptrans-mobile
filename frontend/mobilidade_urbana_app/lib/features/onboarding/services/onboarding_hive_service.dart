import 'package:hive/hive.dart';
import '../models/onboarding_model.dart';
import '../../../utils/local_storage/hive_boxes.dart';

class OnboardingHiveService {
  static Box<OnboardingModel> get _box =>
      Hive.box<OnboardingModel>(HiveBoxes.onboarding);

  static Future<void> save(OnboardingModel data) async {
    await _box.put('data', data);
  }

  static OnboardingModel? load() {
    return _box.get('data');
  }

  static Future<void> markAsSynced() async {
    final data = _box.get('data');
    if (data == null) return;
    data.isSynced = true;
    await data.save();
  }

  static bool get isCompleted => _box.get('data')?.isCompleted ?? false;
  static bool get isSynced => _box.get('data')?.isSynced ?? false;
}