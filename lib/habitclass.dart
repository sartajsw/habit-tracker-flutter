import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

final String tableHabits = "HabitsTable";
final String tableDetails = "DetailsTable";
final String columnName = "name";
final String columnType = "type";
final String columnGoal = "goal";
final String columnDate = "date";

class Habit {
  String name;
  List<int> week = [];
  String type;
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

class HabitsDB {
  static final HabitsDB instance = HabitsDB._init();
  static Database db;

  var newFormat = DateFormat("yyyy-MM-dd");

  Future<Database> get database async {
    if (db != null) return db!;

    db = await _initDB('HabitTrackerDB.db');
    return db!;
  }

  // Future open() async {
  //   final databasesPath = await getDatabasesPath();
  //   final path = join(databasesPath, 'HabitTrackerDB.db');
  //   db = await openDatabase(path, version: 1,
  //       onCreate: (Database db, int version) async {
  //     await db.execute('''
  //     create table IF NOT EXISTS $tableHabits ( $columnDate INT primary key )
  //     ''');
  //     await db.execute('''
  //     create table IF NOT EXISTS $tableDetails ( $columnName TEXT primary key, $columnType TEXT, $columnGoal INT );
  //     ''');
  //   });
  //   print("After open - $path");
  // }

  Future insertHabit(String day, List<Habit> habitlist) async {
    String dateString = newFormat.format(DateTime.now());
    int today = DateTime.tryParse(dateString).millisecondsSinceEpoch;

    var toMap = {columnDate: today};

    for (Habit habit in habitlist) {
      toMap[habit.name] = habit.week[0];
    }

    List<Map> maps = await db
        .query(tableHabits, where: '$columnDate = ?', whereArgs: [today]);

    if (maps.length > 0) {
      await db.update(tableHabits, toMap,
          where: '$columnDate = ?', whereArgs: [today]);
    } else {
      await db.insert(tableHabits, toMap);
    }
  }

  Future addHabit(Habit newHabit) async {
    await db.insert(tableDetails, newHabit.toMap());
    await db
        .execute("ALTER TABLE $tableHabits ADD COLUMN ${newHabit.name} TEXT;");
  }
}
