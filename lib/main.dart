import 'package:flutter/material.dart';
import 'package:habit_tracker/habitclass.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Raleway'),
      home: Home(),
      routes: {
        // '/details': (context) => Details(),
      },
    );
  }
}

class Home extends StatelessWidget {
  final int day = DateTime.now().day;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(backgroundColor: Colors.black, body: HabitsPage()),
    );
  }
}

class HabitsPage extends StatefulWidget {
  @override
  _HabitsPageState createState() => _HabitsPageState();
}

class _HabitsPageState extends State<HabitsPage> {
  List<Habit> habitlist = [];
  int temp = 0;

  String habitName;
  int habitType = 0;
  TextEditingController _habitNameController = TextEditingController();
  // TextEditingController _habitGoalController = TextEditingController();

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Build a New Habit'),
            // backgroundColor: Color(0xff1b232e),
            content: Container(
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    onChanged: (valueName) {
                      setState(() {
                        habitName = valueName;
                      });
                    },
                    // autofocus: true,
                    controller: _habitNameController,
                    decoration: InputDecoration(
                      labelText: "Habit Name:",
                      hintText: "e.g. - Sleep Early",
                      labelStyle: new TextStyle(color: Colors.black),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Type:",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Spacer(),
                      DropdownButton(
                        value: habitType,
                        items: [
                          DropdownMenuItem(
                            child: Text("Normal"),
                            value: 0,
                          ),
                          DropdownMenuItem(
                            child: Text("Counter"),
                            value: 1,
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            habitType = value;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Row(
                  //   children: [
                  //     Text(
                  //       "Goal:",
                  //       style: TextStyle(
                  //         color: Colors.black,
                  //       ),
                  //     ),
                  //     Spacer(),
                  //     TextField(
                  //       onChanged: (valueGoal) {
                  //         setState(() {
                  //           habitName = valueGoal;
                  //         });
                  //       },
                  //       controller: _habitGoalController,
                  //       decoration: InputDecoration(
                  //         labelText: "Goal:",
                  //         labelStyle: new TextStyle(color: Colors.black),
                  //         enabledBorder: UnderlineInputBorder(
                  //           borderSide: BorderSide(color: Colors.black),
                  //         ),
                  //         focusedBorder: UnderlineInputBorder(
                  //           borderSide: BorderSide(color: Colors.black),
                  //         ),
                  //         border: UnderlineInputBorder(
                  //           borderSide: BorderSide(color: Colors.black),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  _habitNameController.clear();
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  _habitNameController.clear();
                  setState(() {
                    Habit newHabit = new Habit();
                    newHabit.name = habitName;
                    newHabit.strength = 0;
                    newHabit.week = [0, 0, 0, 0, 0];
                    newHabit.type = habitType;
                    newHabit.goal = 2;
                    habitlist.add(newHabit);
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  String codeDialog;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          // Header and Add button
          Container(
            padding: EdgeInsets.all(25),
            child: Row(
              children: <Widget>[
                // Header
                Expanded(
                  child: Text(
                    "Habit Tracker",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
                // Button
                ClipOval(
                  child: Material(
                    color: Colors.greenAccent,
                    child: InkWell(
                      // todo: Add new habit pop-up ui
                      onTap: () {
                        _displayTextInputDialog(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Day List
          Row(
            children: <Widget>[
              // Outer container
              Spacer(),
              Container(
                height: 70,
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  color: Color(0xff1b232e),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(
                    0,
                    MediaQuery.of(context).size.width * 0.02,
                    MediaQuery.of(context).size.width * 0.02,
                    MediaQuery.of(context).size.width * 0.02),
                child: Row(
                  children: [
                    // Custom widget for day box
                    DayBox(
                      date: DateTime.now().subtract(Duration(days: 0)),
                      spacer: 0.02,
                    ),
                    DayBox(
                      date: DateTime.now().subtract(Duration(days: 1)),
                    ),
                    DayBox(
                      date: DateTime.now().subtract(Duration(days: 2)),
                    ),
                    DayBox(
                      date: DateTime.now().subtract(Duration(days: 3)),
                    ),
                    DayBox(
                      date: DateTime.now().subtract(Duration(days: 4)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          // List of Habits
          Container(
            height: MediaQuery.of(context).size.height - 200,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: habitlist.length,
              itemBuilder: (ctx, id) {
                return Row(
                  children: [
                    // Name of Habit
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.3,
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.02),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${habitlist[id].name}',
                        // habits[id]['name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Row(
                        children: [
                          if (habitlist[id].type == 0) ...[
                            BooleanElement(habit: habitlist[id], daynum: 0),
                            BooleanElement(habit: habitlist[id], daynum: 1),
                            BooleanElement(habit: habitlist[id], daynum: 2),
                            BooleanElement(habit: habitlist[id], daynum: 3),
                            BooleanElement(habit: habitlist[id], daynum: 4),
                          ],
                          if (habitlist[id].type == 1) ...[
                            CounterElement(habit: habitlist[id], daynum: 0),
                            CounterElement(habit: habitlist[id], daynum: 1),
                            CounterElement(habit: habitlist[id], daynum: 2),
                            CounterElement(habit: habitlist[id], daynum: 3),
                            CounterElement(habit: habitlist[id], daynum: 4),
                          ],
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DayBox extends StatelessWidget {
  const DayBox({
    Key key,
    @required this.date,
    this.spacer,
  }) : super(key: key);

  final DateTime date;
  final double spacer;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: spacer != null
                ? MediaQuery.of(context).size.width * spacer
                : MediaQuery.of(context).size.width * 0.015),
        Container(
          width: MediaQuery.of(context).size.width * 0.12,
          height: MediaQuery.of(context).size.width * 0.12,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xff131b26),
            borderRadius: BorderRadius.circular(5.0),
          ),
          padding: EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat('EE').format(
                  date,
                ),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Text(
                "${date.day}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BooleanElement extends StatefulWidget {
  const BooleanElement({
    Key key,
    @required this.habit,
    @required this.daynum,
  }) : super(key: key);

  final Habit habit;
  final int daynum;

  @override
  _BooleanElementState createState() => _BooleanElementState();
}

class _BooleanElementState extends State<BooleanElement> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: MediaQuery.of(context).size.width * 0.015),
        Container(
          width: MediaQuery.of(context).size.width * 0.12,
          height: MediaQuery.of(context).size.width * 0.12,
          child: IconButton(
            icon: Icon(
              widget.habit.week[widget.daynum] == 0 ? Icons.close : Icons.check,
              color: widget.habit.week[widget.daynum] == 0
                  ? Colors.red
                  : Colors.green,
              size: 30.0,
            ),
            onPressed: () {
              int currentValue = widget.habit.week[widget.daynum];

              if (currentValue == 0) {
                widget.habit.week[widget.daynum] = 1;
              } else {
                widget.habit.week[widget.daynum] = 0;
              }
              setState(() {});
            },
            splashColor: Colors.transparent,
          ),
        ),
      ],
    );
  }
}

class CounterElement extends StatefulWidget {
  const CounterElement({
    Key key,
    @required this.habit,
    @required this.daynum,
  }) : super(key: key);

  final Habit habit;
  final int daynum;

  @override
  _CounterElementState createState() => _CounterElementState();
}

class _CounterElementState extends State<CounterElement> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: MediaQuery.of(context).size.width * 0.015),
        Container(
          width: MediaQuery.of(context).size.width * 0.12,
          height: MediaQuery.of(context).size.width * 0.12,
          child: FlatButton(
            child: Text(
              "${widget.habit.week[widget.daynum]}",
              style: TextStyle(
                color: widget.habit.week[widget.daynum] < widget.habit.goal
                    ? Colors.red
                    : Colors.green,
                // color: Colors.green,
                fontSize: 24,
              ),
            ),
            onPressed: () {
              widget.habit.week[widget.daynum] += 1;
              setState(() {});
            },
            onLongPress: () {
              widget.habit.week[widget.daynum] = 0;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
