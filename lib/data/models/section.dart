import 'package:kanbanboard/application/core/base/base_model.dart';

class Section extends BaseModel {
  String? id;
  String? projectId;
  int? order;
  String? name;
  bool? isCompleted ;

  Section.fromJson(Map<String, dynamic> json) {
    id = stringFromJson(json, "id");
    projectId = stringFromJson(json, "project_id");
    order = intFromJson(json, "order");
    name = stringFromJson(json, "name");
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['project_id'] = projectId;
    data['order'] = order;
    data['name'] = name;
    return data;
  }

  Section({
    this.projectId,
    this.order,
    this.name,
    this.id,
    this.isCompleted = false,
  });
}
