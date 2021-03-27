final String tableHabits = "HabitsTable";
final String columnName = "name";
final String columnType = "type";
final String columnGoal = "goal";

class Habit {
  String name;
  List<int> week = [];
  String type;
  String reverse;
  int goal;

  Map<String, Object> toMap() {
    var map = <String, Object>{
      columnName: name,
      columnType: type,
      columnGoal: goal
    };
    return map;
  }

  Habit();
  Habit.fromMap(Map<String, Object> map) {
    name = map[columnName];
    type = map[columnType];
    goal = map[columnGoal];
  }
}

class HabitList {
  List<Habit> allHabits = [];
}
