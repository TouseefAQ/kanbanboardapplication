import 'package:kanbanboard/application/core/logger/app_logging.dart';

class CommentEntity {
  String? projectId;
  String? taskId;
  String? comment ;

  CommentEntity({
    this.projectId,
    this.taskId,
    this.comment,
    t
  });

  toMap(){
    final Map<String, dynamic> data = <String, dynamic>{};
    if(projectId != null) data['project_id'] = projectId;
    if(taskId != null) data['task_id'] = taskId;
    if(comment != null) data['content'] = comment;


    D.info(data);
    return data ;
  }
}
