// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Task extends DataClass implements Insertable<Task> {
  final int id;
  final String taskName;
  final DateTime dueDate;
  final bool completed;
  final String tagName;
  final String projectName;
  Task(
      {@required this.id,
      @required this.taskName,
      this.dueDate,
      @required this.completed,
      this.tagName,
      this.projectName});
  factory Task.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Task(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      taskName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}task_name']),
      dueDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}due_date']),
      completed:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}completed']),
      tagName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}tag_name']),
      projectName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}project_name']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || taskName != null) {
      map['task_name'] = Variable<String>(taskName);
    }
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    if (!nullToAbsent || completed != null) {
      map['completed'] = Variable<bool>(completed);
    }
    if (!nullToAbsent || tagName != null) {
      map['tag_name'] = Variable<String>(tagName);
    }
    if (!nullToAbsent || projectName != null) {
      map['project_name'] = Variable<String>(projectName);
    }
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      taskName: taskName == null && nullToAbsent
          ? const Value.absent()
          : Value(taskName),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      completed: completed == null && nullToAbsent
          ? const Value.absent()
          : Value(completed),
      tagName: tagName == null && nullToAbsent
          ? const Value.absent()
          : Value(tagName),
      projectName: projectName == null && nullToAbsent
          ? const Value.absent()
          : Value(projectName),
    );
  }

  factory Task.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      taskName: serializer.fromJson<String>(json['taskName']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      completed: serializer.fromJson<bool>(json['completed']),
      tagName: serializer.fromJson<String>(json['tagName']),
      projectName: serializer.fromJson<String>(json['projectName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'taskName': serializer.toJson<String>(taskName),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'completed': serializer.toJson<bool>(completed),
      'tagName': serializer.toJson<String>(tagName),
      'projectName': serializer.toJson<String>(projectName),
    };
  }

  Task copyWith(
          {int id,
          String taskName,
          DateTime dueDate,
          bool completed,
          String tagName,
          String projectName}) =>
      Task(
        id: id ?? this.id,
        taskName: taskName ?? this.taskName,
        dueDate: dueDate ?? this.dueDate,
        completed: completed ?? this.completed,
        tagName: tagName ?? this.tagName,
        projectName: projectName ?? this.projectName,
      );
  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('taskName: $taskName, ')
          ..write('dueDate: $dueDate, ')
          ..write('completed: $completed, ')
          ..write('tagName: $tagName, ')
          ..write('projectName: $projectName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          taskName.hashCode,
          $mrjc(
              dueDate.hashCode,
              $mrjc(completed.hashCode,
                  $mrjc(tagName.hashCode, projectName.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.taskName == this.taskName &&
          other.dueDate == this.dueDate &&
          other.completed == this.completed &&
          other.tagName == this.tagName &&
          other.projectName == this.projectName);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<String> taskName;
  final Value<DateTime> dueDate;
  final Value<bool> completed;
  final Value<String> tagName;
  final Value<String> projectName;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.taskName = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.completed = const Value.absent(),
    this.tagName = const Value.absent(),
    this.projectName = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    @required String taskName,
    this.dueDate = const Value.absent(),
    this.completed = const Value.absent(),
    this.tagName = const Value.absent(),
    this.projectName = const Value.absent(),
  }) : taskName = Value(taskName);
  static Insertable<Task> custom({
    Expression<int> id,
    Expression<String> taskName,
    Expression<DateTime> dueDate,
    Expression<bool> completed,
    Expression<String> tagName,
    Expression<String> projectName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskName != null) 'task_name': taskName,
      if (dueDate != null) 'due_date': dueDate,
      if (completed != null) 'completed': completed,
      if (tagName != null) 'tag_name': tagName,
      if (projectName != null) 'project_name': projectName,
    });
  }

  TasksCompanion copyWith(
      {Value<int> id,
      Value<String> taskName,
      Value<DateTime> dueDate,
      Value<bool> completed,
      Value<String> tagName,
      Value<String> projectName}) {
    return TasksCompanion(
      id: id ?? this.id,
      taskName: taskName ?? this.taskName,
      dueDate: dueDate ?? this.dueDate,
      completed: completed ?? this.completed,
      tagName: tagName ?? this.tagName,
      projectName: projectName ?? this.projectName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (taskName.present) {
      map['task_name'] = Variable<String>(taskName.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (tagName.present) {
      map['tag_name'] = Variable<String>(tagName.value);
    }
    if (projectName.present) {
      map['project_name'] = Variable<String>(projectName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('taskName: $taskName, ')
          ..write('dueDate: $dueDate, ')
          ..write('completed: $completed, ')
          ..write('tagName: $tagName, ')
          ..write('projectName: $projectName')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  final GeneratedDatabase _db;
  final String _alias;
  $TasksTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _taskNameMeta = const VerificationMeta('taskName');
  GeneratedTextColumn _taskName;
  @override
  GeneratedTextColumn get taskName => _taskName ??= _constructTaskName();
  GeneratedTextColumn _constructTaskName() {
    return GeneratedTextColumn('task_name', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _dueDateMeta = const VerificationMeta('dueDate');
  GeneratedDateTimeColumn _dueDate;
  @override
  GeneratedDateTimeColumn get dueDate => _dueDate ??= _constructDueDate();
  GeneratedDateTimeColumn _constructDueDate() {
    return GeneratedDateTimeColumn(
      'due_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _completedMeta = const VerificationMeta('completed');
  GeneratedBoolColumn _completed;
  @override
  GeneratedBoolColumn get completed => _completed ??= _constructCompleted();
  GeneratedBoolColumn _constructCompleted() {
    return GeneratedBoolColumn('completed', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _tagNameMeta = const VerificationMeta('tagName');
  GeneratedTextColumn _tagName;
  @override
  GeneratedTextColumn get tagName => _tagName ??= _constructTagName();
  GeneratedTextColumn _constructTagName() {
    return GeneratedTextColumn('tag_name', $tableName, true,
        $customConstraints: 'NULL REFERENCES tags(tag_name)');
  }

  final VerificationMeta _projectNameMeta =
      const VerificationMeta('projectName');
  GeneratedTextColumn _projectName;
  @override
  GeneratedTextColumn get projectName =>
      _projectName ??= _constructProjectName();
  GeneratedTextColumn _constructProjectName() {
    return GeneratedTextColumn('project_name', $tableName, true,
        $customConstraints: 'NULL REFERENCES projects(project_name)');
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, taskName, dueDate, completed, tagName, projectName];
  @override
  $TasksTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tasks';
  @override
  final String actualTableName = 'tasks';
  @override
  VerificationContext validateIntegrity(Insertable<Task> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('task_name')) {
      context.handle(_taskNameMeta,
          taskName.isAcceptableOrUnknown(data['task_name'], _taskNameMeta));
    } else if (isInserting) {
      context.missing(_taskNameMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date'], _dueDateMeta));
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed'], _completedMeta));
    }
    if (data.containsKey('tag_name')) {
      context.handle(_tagNameMeta,
          tagName.isAcceptableOrUnknown(data['tag_name'], _tagNameMeta));
    }
    if (data.containsKey('project_name')) {
      context.handle(
          _projectNameMeta,
          projectName.isAcceptableOrUnknown(
              data['project_name'], _projectNameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Task.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(_db, alias);
  }
}

class Tag extends DataClass implements Insertable<Tag> {
  final String tagName;
  final int color;
  Tag({@required this.tagName, @required this.color});
  factory Tag.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return Tag(
      tagName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}tag_name']),
      color: intType.mapFromDatabaseResponse(data['${effectivePrefix}color']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || tagName != null) {
      map['tag_name'] = Variable<String>(tagName);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<int>(color);
    }
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      tagName: tagName == null && nullToAbsent
          ? const Value.absent()
          : Value(tagName),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
    );
  }

  factory Tag.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Tag(
      tagName: serializer.fromJson<String>(json['tagName']),
      color: serializer.fromJson<int>(json['color']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'tagName': serializer.toJson<String>(tagName),
      'color': serializer.toJson<int>(color),
    };
  }

  Tag copyWith({String tagName, int color}) => Tag(
        tagName: tagName ?? this.tagName,
        color: color ?? this.color,
      );
  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('tagName: $tagName, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(tagName.hashCode, color.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Tag &&
          other.tagName == this.tagName &&
          other.color == this.color);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<String> tagName;
  final Value<int> color;
  const TagsCompanion({
    this.tagName = const Value.absent(),
    this.color = const Value.absent(),
  });
  TagsCompanion.insert({
    @required String tagName,
    @required int color,
  })  : tagName = Value(tagName),
        color = Value(color);
  static Insertable<Tag> custom({
    Expression<String> tagName,
    Expression<int> color,
  }) {
    return RawValuesInsertable({
      if (tagName != null) 'tag_name': tagName,
      if (color != null) 'color': color,
    });
  }

  TagsCompanion copyWith({Value<String> tagName, Value<int> color}) {
    return TagsCompanion(
      tagName: tagName ?? this.tagName,
      color: color ?? this.color,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (tagName.present) {
      map['tag_name'] = Variable<String>(tagName.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('tagName: $tagName, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  final GeneratedDatabase _db;
  final String _alias;
  $TagsTable(this._db, [this._alias]);
  final VerificationMeta _tagNameMeta = const VerificationMeta('tagName');
  GeneratedTextColumn _tagName;
  @override
  GeneratedTextColumn get tagName => _tagName ??= _constructTagName();
  GeneratedTextColumn _constructTagName() {
    return GeneratedTextColumn('tag_name', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _colorMeta = const VerificationMeta('color');
  GeneratedIntColumn _color;
  @override
  GeneratedIntColumn get color => _color ??= _constructColor();
  GeneratedIntColumn _constructColor() {
    return GeneratedIntColumn(
      'color',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [tagName, color];
  @override
  $TagsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tags';
  @override
  final String actualTableName = 'tags';
  @override
  VerificationContext validateIntegrity(Insertable<Tag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('tag_name')) {
      context.handle(_tagNameMeta,
          tagName.isAcceptableOrUnknown(data['tag_name'], _tagNameMeta));
    } else if (isInserting) {
      context.missing(_tagNameMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color'], _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {tagName};
  @override
  Tag map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Tag.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(_db, alias);
  }
}

class Project extends DataClass implements Insertable<Project> {
  final String projectName;
  final String parentName;
  Project({@required this.projectName, this.parentName});
  factory Project.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return Project(
      projectName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}project_name']),
      parentName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}parent_name']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || projectName != null) {
      map['project_name'] = Variable<String>(projectName);
    }
    if (!nullToAbsent || parentName != null) {
      map['parent_name'] = Variable<String>(parentName);
    }
    return map;
  }

  ProjectsCompanion toCompanion(bool nullToAbsent) {
    return ProjectsCompanion(
      projectName: projectName == null && nullToAbsent
          ? const Value.absent()
          : Value(projectName),
      parentName: parentName == null && nullToAbsent
          ? const Value.absent()
          : Value(parentName),
    );
  }

  factory Project.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Project(
      projectName: serializer.fromJson<String>(json['projectName']),
      parentName: serializer.fromJson<String>(json['parentName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'projectName': serializer.toJson<String>(projectName),
      'parentName': serializer.toJson<String>(parentName),
    };
  }

  Project copyWith({String projectName, String parentName}) => Project(
        projectName: projectName ?? this.projectName,
        parentName: parentName ?? this.parentName,
      );
  @override
  String toString() {
    return (StringBuffer('Project(')
          ..write('projectName: $projectName, ')
          ..write('parentName: $parentName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(projectName.hashCode, parentName.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Project &&
          other.projectName == this.projectName &&
          other.parentName == this.parentName);
}

class ProjectsCompanion extends UpdateCompanion<Project> {
  final Value<String> projectName;
  final Value<String> parentName;
  const ProjectsCompanion({
    this.projectName = const Value.absent(),
    this.parentName = const Value.absent(),
  });
  ProjectsCompanion.insert({
    @required String projectName,
    this.parentName = const Value.absent(),
  }) : projectName = Value(projectName);
  static Insertable<Project> custom({
    Expression<String> projectName,
    Expression<String> parentName,
  }) {
    return RawValuesInsertable({
      if (projectName != null) 'project_name': projectName,
      if (parentName != null) 'parent_name': parentName,
    });
  }

  ProjectsCompanion copyWith(
      {Value<String> projectName, Value<String> parentName}) {
    return ProjectsCompanion(
      projectName: projectName ?? this.projectName,
      parentName: parentName ?? this.parentName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (projectName.present) {
      map['project_name'] = Variable<String>(projectName.value);
    }
    if (parentName.present) {
      map['parent_name'] = Variable<String>(parentName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectsCompanion(')
          ..write('projectName: $projectName, ')
          ..write('parentName: $parentName')
          ..write(')'))
        .toString();
  }
}

class $ProjectsTable extends Projects with TableInfo<$ProjectsTable, Project> {
  final GeneratedDatabase _db;
  final String _alias;
  $ProjectsTable(this._db, [this._alias]);
  final VerificationMeta _projectNameMeta =
      const VerificationMeta('projectName');
  GeneratedTextColumn _projectName;
  @override
  GeneratedTextColumn get projectName =>
      _projectName ??= _constructProjectName();
  GeneratedTextColumn _constructProjectName() {
    return GeneratedTextColumn('project_name', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _parentNameMeta = const VerificationMeta('parentName');
  GeneratedTextColumn _parentName;
  @override
  GeneratedTextColumn get parentName => _parentName ??= _constructParentName();
  GeneratedTextColumn _constructParentName() {
    return GeneratedTextColumn('parent_name', $tableName, true,
        $customConstraints: 'NULL REFERENCES projects(project_name)');
  }

  @override
  List<GeneratedColumn> get $columns => [projectName, parentName];
  @override
  $ProjectsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'projects';
  @override
  final String actualTableName = 'projects';
  @override
  VerificationContext validateIntegrity(Insertable<Project> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('project_name')) {
      context.handle(
          _projectNameMeta,
          projectName.isAcceptableOrUnknown(
              data['project_name'], _projectNameMeta));
    } else if (isInserting) {
      context.missing(_projectNameMeta);
    }
    if (data.containsKey('parent_name')) {
      context.handle(
          _parentNameMeta,
          parentName.isAcceptableOrUnknown(
              data['parent_name'], _parentNameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {projectName};
  @override
  Project map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Project.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ProjectsTable createAlias(String alias) {
    return $ProjectsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $TasksTable _tasks;
  $TasksTable get tasks => _tasks ??= $TasksTable(this);
  $TagsTable _tags;
  $TagsTable get tags => _tags ??= $TagsTable(this);
  $ProjectsTable _projects;
  $ProjectsTable get projects => _projects ??= $ProjectsTable(this);
  TaskDao _taskDao;
  TaskDao get taskDao => _taskDao ??= TaskDao(this as AppDatabase);
  TagDao _tagDao;
  TagDao get tagDao => _tagDao ??= TagDao(this as AppDatabase);
  ProjectDao _projectDao;
  ProjectDao get projectDao => _projectDao ??= ProjectDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tasks, tags, projects];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$TaskDaoMixin on DatabaseAccessor<AppDatabase> {
  $TasksTable get tasks => attachedDatabase.tasks;
  $TagsTable get tags => attachedDatabase.tags;
  $ProjectsTable get projects => attachedDatabase.projects;
}
mixin _$TagDaoMixin on DatabaseAccessor<AppDatabase> {
  $TagsTable get tags => attachedDatabase.tags;
}
mixin _$ProjectDaoMixin on DatabaseAccessor<AppDatabase> {
  $ProjectsTable get projects => attachedDatabase.projects;
}
