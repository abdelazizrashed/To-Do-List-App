import 'package:todo_list/features/todo_list/domain/entities/todo_project.dart';
import 'package:meta/meta.dart';

List<ProjectTree> buildParentsTree(
    {@required List<TodoProject> parentsList,
    @required List<TodoProject> projectsList}) {
  List<ProjectTree> projectTrees = [];
  parentsList.forEach((parent) {
    ProjectTree projectTree = ProjectTree(parent);
    List<TodoProject> childrenList = projectsList
        .where((project) => project.parentProject == parent)
        .toList();
    if (childrenList?.isNotEmpty ?? false) {
      projectTree.children = buildParentsTree(
          parentsList: childrenList, projectsList: projectsList);
    }
    projectTrees.add(projectTree);
  });
  return projectTrees;
}

void printProjectTree(List<ProjectTree> projectTrees) {
  projectTrees.forEach((projectTree) {
    print(projectTree.parent.projectName);
    if (projectTree.children?.isNotEmpty ?? false) {
      printProjectTree(projectTree.children);
    }
  });
}

class ProjectTree {
  final TodoProject parent;
  List<ProjectTree> children;

  ProjectTree(this.parent);
}

//!For testing just remove the space between to do
// To doProject parent1 = TodoProject(projectName: 'parent 1');
//   To doProject parent2 = TodoProject(projectName: 'parent 2');
//   To doProject child11 =
//       To doProject(projectName: 'child 11', parentProject: parent1);
//   To doProject child12 =
//       To doProject(projectName: 'child 12', parentProject: parent1);
//   To doProject grandChild111 =
//       To doProject(projectName: 'grandChild111', parentProject: child11);
//   To doProject grandChild121 =
//       To doProject(projectName: 'grandChild121', parentProject: child12);
//   To doProject child21 =
//       To doProject(projectName: 'child 21', parentProject: parent2);
//   To doProject child22 =
//       To doProject(projectName: 'child 22', parentProject: parent2);
//   To doProject grandChild211 =
//       To doProject(projectName: 'grandChild211', parentProject: child21);
//   To doProject grandChild221 =
//       To doProject(projectName: 'grandChild121', parentProject: child22);

//   List<TodoProject> projectsList = [
//     parent1,
//     parent2,
//     child11,
//     child12,
//     child21,
//     child22,
//     grandChild111,
//     grandChild121,
//     grandChild211,
//     grandChild221
//   ];
//   List<TodoProject> parentsList =
//       projectsList.where((element) => element.parentProject == null).toList();
//   List<ProjectTree> projectTrees =
//       buildParentsTree(parentsList: parentsList, projectsList: projectsList);
//   printProjectTree(projectTrees);