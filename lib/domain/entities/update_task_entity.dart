import 'package:kanbanboard/application/core/logger/app_logging.dart';

class UpdateTaskEntity {
  String? sectionId;
  String? taskId;
  String? title ;
  int? duration;

  UpdateTaskEntity({
    this.sectionId,
    this.taskId,
    this.duration,
    this.title
  });

  toMap(){
    final Map<String, dynamic> data = <String, dynamic>{};
    if(sectionId != null) data['content'] = sectionId;
    if(title != null) data['description'] = title;
    if(duration != null) data['duration'] = duration!<= 0 ? 1 : duration;
    if(duration != null) data['duration_unit'] = "minute";

    D.info(data);
    return data ;
  }
}
