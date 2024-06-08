import 'package:kanbanboard/application/core/base/base_model.dart';

class Task extends BaseModel {
  String? creatorId;
  String? createdAt;
  String? assigneeId;
  String? assignerId;
  int? commentCount;
  bool? isCompleted;
  String? content;
  String? description;
  Due? due;
  Duration? duration;
  String? id;
  List<String>? labels;
  int? order;
  int? priority;
  String? projectId;
  String? sectionId;
  String? parentId;
  bool? editMode ;
  String? url;

  Task.fromJson(Map<String, dynamic> json) {
    creatorId = stringFromJson(json, "creator_id");
    createdAt = stringFromJson(json, "created_at");
    assigneeId = stringFromJson(json, "assignee_id");
    assignerId = stringFromJson(json, "assigner_id");
    commentCount = intFromJson(json, "comment_count");
    isCompleted = boolFromJson(json, "is_completed");
    content = stringFromJson(json, "content");
    description = stringFromJson(json, "description");
    due = json['due'] != null ? Due.fromJson(json['due']) : null;
    id = stringFromJson(json, "id");
    duration =
        objectFromJson(json, "duration", (obj) => Duration.fromJson(obj!));
    labels = listFromJson(json, "labels", (obj) => obj.toString());
    order = intFromJson(json, "order");
    priority = intFromJson(json, "priority");
    projectId = stringFromJson(json, "project_id");
    sectionId = stringFromJson(json, "content");
    parentId = stringFromJson(json, "parent_id");
    url = stringFromJson(json, "url");
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['creator_id'] = creatorId;
    data['created_at'] = createdAt;
    data['assignee_id'] = assigneeId;
    data['assigner_id'] = assignerId;
    data['comment_count'] = commentCount;
    data['is_completed'] = isCompleted;
    data['content'] = content;
    data['description'] = description;
    if (due != null) {
      data['due'] = due!.toJson();
    }
    if (duration != null) {
      data['duration'] = duration!.toJson();
    }
    data['id'] = id;
    data['labels'] = labels;
    data['order'] = order;
    data['priority'] = priority;
    data['project_id'] = projectId;
    data['section_id'] = sectionId;
    data['parent_id'] = parentId;
    data['url'] = url;
    return data;
  }

  Task({
    this.creatorId,
    this.createdAt,
    this.editMode= false,
    this.assigneeId,
    this.assignerId,
    this.commentCount,
    this.isCompleted,
    this.content,
    this.description,
    this.due,
    this.duration,
    this.labels,
    this.order,
    this.priority,
    this.projectId,
    this.sectionId,
    this.parentId,
    this.url,
    this.id,
  }) {
    // D.info("Task ID: $_id");
  }

  Task copyWith({
    String? creatorId,
    String? createdAt,
    String? assigneeId,
    String? assignerId,
    int? commentCount,
    bool? isCompleted,
    String? content,
    String? description,
    Due? due,
    Duration? duration,
    String? id,
    List<String>? labels,
    int? order,
    int? priority,
    String? projectId,
    String? sectionId,
    String? parentId,
    String? url,
    bool? editMode,
  }) {
    return Task(
      creatorId: creatorId ?? this.creatorId,
      createdAt: createdAt ?? this.createdAt,
      editMode: editMode ?? this.editMode,
      assigneeId: assigneeId ?? this.assigneeId,
      assignerId: assignerId ?? this.assignerId,
      commentCount: commentCount ?? this.commentCount,
      isCompleted: isCompleted ?? this.isCompleted,
      content: content ?? this.content,
      description: description ?? this.description,
      due: due ?? this.due,
      duration: duration ?? this.duration,
      id: id ?? this.id,
      labels: labels ?? this.labels,
      order: order ?? this.order,
      priority: priority ?? this.priority,
      projectId: projectId ?? this.projectId,
      sectionId: sectionId ?? this.sectionId,
      parentId: parentId ?? this.parentId,
      url: url ?? this.url,
    );
  }
}

class Due extends BaseModel {
  String? date;
  bool? isRecurring;
  String? datetime;
  String? string;
  String? timezone;

  Due({this.date, this.isRecurring, this.datetime, this.string, this.timezone});

  Due.fromJson(Map<String, dynamic> json) {
    date = stringFromJson(json, "date");
    isRecurring = boolFromJson(json, "is_recurring");
    datetime = stringFromJson(json, "datetime");
    string = stringFromJson(json, "string");
    timezone = stringFromJson(json, "timezone");
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['is_recurring'] = isRecurring;
    data['datetime'] = datetime;
    data['string'] = string;
    data['timezone'] = timezone;
    return data;
  }
}

class Duration extends BaseModel {
  int? amount;
  String? unit;

  Duration({this.amount, this.unit});

  Duration.fromJson(Map<String, dynamic> json) {
    amount = intFromJson(json, "amount");
    unit = stringFromJson(json, "unit");
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['unit'] = unit;
    return data;
  }
}
