import 'package:hive/hive.dart';

part 'result_model.g.dart';

@HiveType(typeId: 0)
class ResultModel extends HiveObject {
  @HiveField(0)
  late int result;

  ResultModel(this.result);
}
