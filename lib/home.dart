import 'package:flutter/material.dart';
import 'package:habit_tracker/habitclass.dart';
import 'package:habit_tracker/home_widgets.dart';

class Home extends StatelessWidget {
  final int day = DateTime.now().day;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: HabitsPage(),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}

class HabitsPage extends StatefulWidget {
  @override
  _HabitsPageState createState() => _HabitsPageState();
}

class _HabitsPageState extends State<HabitsPage> {
  List<Habit> habitlist = [];
  //HabitDBHelper habitDBHelper = HabitDBHelper();

  void asyncMethod() async {
    //await habitDBHelper.open();
  }

  @override
  void initState() {
    super.initState();
    asyncMethod();
  }

  int habitGoal;
  String habitName;
  bool habitType = false;
  String reverse = "More than";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _habitNameController = TextEditingController();
  final TextEditingController _habitGoalController = TextEditingController();

  bool _isNumeric(String result) {
    if (result == null) {
      return false;
    }
    return int.tryParse(result) != null;
  }

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: Text("Habit Name: "),
                        title: TextFormField(
                          controller: _habitNameController,
                          validator: (value) {
                            return value.isNotEmpty
                                ? null
                                : "Should not be empty!";
                          },
                          decoration:
                              InputDecoration(hintText: "e.g. - Sleep early"),
                          onChanged: (value) {
                            setState(() {
                              habitName = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        leading: Text("Counter:    "),
                        title: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Checkbox(
                                value: habitType,
                                onChanged: (checked) {
                                  setState(() {
                                    habitType = checked;
                                  });
                                })
                          ],
                        ),
                      ),
                      habitType
                          ? ListTile(
                              leading: Text("Goal:              "),
                              title: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  DropdownButton<String>(
                                    value: reverse,
                                    //elevation: 5,
                                    items: <String>['More than', 'Less than']
                                        .map<DropdownMenuItem<String>>(
                                            (String reverseValue) {
                                      return DropdownMenuItem<String>(
                                        value: reverseValue,
                                        child: Text(
                                          reverseValue,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String reverseValue) {
                                      setState(() {
                                        reverse = reverseValue;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      habitType
                          ? ListTile(
                              leading: Text("                       "),
                              title: TextFormField(
                                controller: _habitGoalController,
                                validator: (goalvalue) {
                                  if (goalvalue.isEmpty) {
                                    goalvalue = "0";
                                  }
                                  return _isNumeric(goalvalue)
                                      ? null
                                      : "Should be a number!";
                                },
                                decoration:
                                    InputDecoration(hintText: "Enter Goal"),
                                onChanged: (goalvalue) {
                                  setState(
                                    () {
                                      habitGoal = int.parse(goalvalue);
                                    },
                                  );
                                },
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
              title: Text('New Habit'),
              actions: <Widget>[
                RaisedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Create",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      // Create new habit
                      Habit newHabit = new Habit();
                      newHabit.name = habitName;
                      newHabit.week = [0, 0, 0, 0, 0];
                      if (!habitType) {
                        newHabit.type = "boolean";
                      } else {
                        newHabit.type =
                            reverse == "Less than" ? "reverse" : "counter";
                      }
                      newHabit.goal = habitGoal;
                      //habitDBHelper.addHabit(newHabit);
                      habitlist.add(newHabit);
                      print("Adding habit - " + newHabit.type);

                      // Clear inputs
                      _habitNameController.clear();
                      _habitGoalController.clear();
                      habitType = false;

                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          });
        });
  }

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
                      onTap: () async {
                        await showInformationDialog(context);
                        setState(() {});
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
                    GestureDetector(
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                title: Text("Delete habit ? 🗑"),
                                content: Container(
                                  child: Row(
                                    children: [
                                      RaisedButton(
                                          child: Text("No"),
                                          color: Colors.red,
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          }),
                                      Spacer(),
                                      RaisedButton(
                                          child: Text("Yes"),
                                          color: Colors.green,
                                          onPressed: () {
                                            setState(
                                              () {
                                                habitlist.remove(habitlist[id]);
                                              },
                                            );
                                            Navigator.of(context).pop();
                                          }),
                                    ],
                                  ),
                                ));
                          },
                        );
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.3,
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.02),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${habitlist[id].name}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Row(
                        children: [
                          if (habitlist[id].type == "boolean") ...[
                            BooleanElement(habit: habitlist[id], daynum: 0),
                            BooleanElement(habit: habitlist[id], daynum: 1),
                            BooleanElement(habit: habitlist[id], daynum: 2),
                            BooleanElement(habit: habitlist[id], daynum: 3),
                            BooleanElement(habit: habitlist[id], daynum: 4),
                          ],
                          if (habitlist[id].type == "counter") ...[
                            CounterElement(habit: habitlist[id], daynum: 0),
                            CounterElement(habit: habitlist[id], daynum: 1),
                            CounterElement(habit: habitlist[id], daynum: 2),
                            CounterElement(habit: habitlist[id], daynum: 3),
                            CounterElement(habit: habitlist[id], daynum: 4),
                          ],
                          if (habitlist[id].type == "reverse") ...[
                            ReverseElement(habit: habitlist[id], daynum: 0),
                            ReverseElement(habit: habitlist[id], daynum: 1),
                            ReverseElement(habit: habitlist[id], daynum: 2),
                            ReverseElement(habit: habitlist[id], daynum: 3),
                            ReverseElement(habit: habitlist[id], daynum: 4),
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
