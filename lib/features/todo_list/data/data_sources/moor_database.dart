import 'package:moor_flutter/moor_flutter.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_project.dart';

part 'moor_database.g.dart';

class Tasks extends Table {
  //Task Id
  IntColumn get id => integer().autoIncrement()();

  //Task name or title
  TextColumn get taskName => text().withLength(min: 1, max: 50)();

  //The task due date
  DateTimeColumn get dueDate => dateTime().nullable()();

  //If the task is completed or not
  BoolColumn get completed => boolean().withDefault(Constant(false))();

  //The tag name of the tag that is associated with the task
  TextColumn get tagName =>
      text().nullable().customConstraint('NULL REFERENCES tags(tag_name)')();

  //The project name of the project that the task is part of
  TextColumn get projectName => text()
      .nullable()
      .customConstraint('NULL REFERENCES projects(project_name)')();
}

class Tags extends Table {
  //The name of the tag
  TextColumn get tagName => text().withLength(min: 1, max: 50)();

  //The color of the tag which will be a 32bit integer representing the color
  IntColumn get color => integer()();

  @override
  Set<Column> get primaryKey => {tagName};
}

class Projects extends Table {
  //The project name
  TextColumn get projectName => text().withLength(min: 1, max: 50)();

  //The project parent name
  TextColumn get parentName => text()
      .nullable()
      .customConstraint('NULL REFERENCES projects(project_name)')();

  @override
  Set<Column> get primaryKey => {projectName};
}

@UseMoor(tables: [
  Tasks,
  Tags,
  Projects
], daos: [
  TaskDao,
  TagDao,
  ProjectDao,
])
class AppDatabase extends _$AppDatabase {
  /// When you need to intialise AppDatbase use FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite', logStatements: true)
  AppDatabase({QueryExecutor executor})
      : super((executor == null)
            ? FlutterQueryExecutor.inDatabaseFolder(
                path: 'db.sqlite', logStatements: true)
            : executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration =>
      MigrationStrategy(beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON ');
      });
}

@UseDao(tables: [Tasks, Tags, Projects])
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  final AppDatabase db;

  TaskDao(this.db) : super(db);

  //*Getters
  //Get task with id
  Future<List<Task>> getTaskWithId(int id) =>
      (select(tasks)..where((tbl) => tbl.id.equals(id))).get();

  //Get all the unfinished tasks
  Future<List<Task>> getAllUnfinishedTasks() => (select(tasks)
        ..where((tbl) => tbl.completed.equals(false))
        ..orderBy([
          (t) => OrderingTerm(expression: t.dueDate),
          (t) => OrderingTerm(expression: t.taskName),
        ]))
      .get();

  //Get all the completed tasks
  Future<List<Task>> getAllCompletedTasks() => (select(tasks)
        ..where((tbl) => tbl.completed.equals(true))
        ..orderBy([
          (t) => OrderingTerm(expression: t.dueDate),
          (t) => OrderingTerm(expression: t.taskName),
        ]))
      .get();

  //Get the unfinished tasks for a specific project
  Future<List<Task>> getProjectsUnfinishedTasks(TodoProject project) =>
      (select(tasks)
            ..where((t) => t.projectName.equals(project.projectName))
            ..where((tbl) => tbl.completed.equals(false))
            ..orderBy([
              (t) => OrderingTerm(expression: t.dueDate),
              (t) => OrderingTerm(expression: t.taskName),
            ]))
          .get();

  //Get the completed tasks for a specific project
  Future<List<Task>> getProjectsCompletedTasks(TodoProject project) =>
      (select(tasks)
            ..where((task) => task.projectName.equals(project.projectName))
            ..where((task) => task.completed.equals(true))
            ..orderBy([
              (t) => OrderingTerm(expression: t.dueDate),
              (t) => OrderingTerm(expression: t.taskName),
            ]))
          .get();
  //
  //
  //Get the tasks that are due today
  Future<List<Task>> getTodaysTasks() {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    return (select(tasks)
          ..where((t) => t.dueDate.equals(today))
          ..orderBy([
            (t) => OrderingTerm(expression: t.taskName),
          ]))
        .get();
  }

  //* Insertion
  Future<int> insertTask(Insertable<Task> task) => into(tasks).insert(task);

  //* Updating
  Future updateTask(Insertable<Task> task) => update(tasks).replace(task);

  //*Deletion
  Future deleteTask(Insertable<Task> task) => delete(tasks).delete(task);

  //* For testing mainly but can be used for other things
  //Get the task that has a specific id
  Stream<Task> watchTaskWithId(int id) =>
      (select(tasks)..where((tbl) => tbl.id.equals(id))).watchSingle();
  //return (select(users)..where((u) => u.id.equals(id))).watchSingle();
}

@UseDao(tables: [Tags])
class TagDao extends DatabaseAccessor<AppDatabase> with _$TagDaoMixin {
  final AppDatabase db;

  TagDao(this.db) : super(db);

  //*Insertion
  Future insertTag(Tag tag) => into(tags).insert(tag);

  //*Getter
  Future<List<Tag>> getAllTags() => select(tags).get();

  Future<Tag> getTagByName(String tagName) {
    return (select(tags)..where((tbl) => tbl.tagName.equals(tagName)))
        .getSingle();
  }

  //*Deletion
  Future deleteTag(Tag tag) => delete(tags).delete(tag);

  //*Modification
  Future updateTag(Tag tag) => update(tags).replace(tag);

  //* For testing mainly but can be used for other things
  //Get the task that has a specific id
  Stream<Tag> watchTagWithTagName(String tagName) =>
      (select(tags)..where((tbl) => tbl.tagName.equals(tagName))).watchSingle();
}

@UseDao(tables: [Projects])
class ProjectDao extends DatabaseAccessor<AppDatabase> with _$ProjectDaoMixin {
  final AppDatabase db;

  ProjectDao(this.db) : super(db);

  //*Insertion
  Future insertProject(Project project) => into(projects).insert(project);

  //*Getter
  Future<List<Project>> getAllProjects() => select(projects).get();

  Future<Project> getProjectByName(String projectName) {
    return (select(projects)
          ..where((tbl) => tbl.projectName.equals(projectName)))
        .getSingle();
  }

  //*Deletion
  Future deleteProject(Project project) => delete(projects).delete(project);

  //* For testing mainly but can be used for other things
  //Get the task that has a specific id
  Stream<Project> watchProjectWithProjectName(String projectName) =>
      (select(projects)..where((tbl) => tbl.projectName.equals(projectName)))
          .watchSingle();
}
