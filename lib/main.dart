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
                ClipOval(
                  child: Material(
                    color: Colors.greenAccent,
                    child: InkWell(
                      // todo: Add new habit pop=up ui
                      onTap: () {
                        temp = temp + 1;

                        Habit newHabit = new Habit();
                        newHabit.name = "Adding new habit - $temp";
                        newHabit.strength = 0;
                        newHabit.week = [false, false, false, false, false];
                        habitlist.add(newHabit);

                        setState(() {});
                        print("Adding new habit - $temp");
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
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.020),
                child: Row(
                  children: [
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
                              DateTime.now().subtract(Duration(days: 0)),
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "${DateTime.now().subtract(Duration(days: 0)).day}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.015),
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
                              DateTime.now().subtract(Duration(days: 1)),
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "${DateTime.now().subtract(Duration(days: 1)).day}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.015),
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
                              DateTime.now().subtract(Duration(days: 2)),
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "${DateTime.now().subtract(Duration(days: 2)).day}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.015),
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
                              DateTime.now().subtract(Duration(days: 3)),
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "${DateTime.now().subtract(Duration(days: 3)).day}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.015),
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
                              DateTime.now().subtract(Duration(days: 4)),
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "${DateTime.now().subtract(Duration(days: 4)).day}",
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
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
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
                      alignment: Alignment.center,
                      child: Text(
                        '${habitlist[id].name}',
                        // habits[id]['name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.12,
                            height: MediaQuery.of(context).size.width * 0.12,
                            child: IconButton(
                              icon: Icon(
                                habitlist[id].week[0] == false
                                    ? Icons.close
                                    : Icons.check,
                                color: habitlist[id].week[0] == false
                                    ? Colors.red
                                    : Colors.green,
                                size: 30.0,
                              ),
                              onPressed: () {
                                habitlist[id].week[0] = !habitlist[id].week[0];
                                setState(() {});
                              },
                              splashColor: Colors.transparent,
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.015),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.12,
                            height: MediaQuery.of(context).size.width * 0.12,
                            child: IconButton(
                              icon: Icon(
                                habitlist[id].week[1] == false
                                    ? Icons.close
                                    : Icons.check,
                                color: habitlist[id].week[1] == false
                                    ? Colors.red
                                    : Colors.green,
                                size: 30.0,
                              ),
                              onPressed: () {
                                habitlist[id].week[1] = !habitlist[id].week[1];
                                setState(() {});
                              },
                              splashColor: Colors.transparent,
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.015),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.12,
                            height: MediaQuery.of(context).size.width * 0.12,
                            child: IconButton(
                              icon: Icon(
                                habitlist[id].week[2] == false
                                    ? Icons.close
                                    : Icons.check,
                                color: habitlist[id].week[2] == false
                                    ? Colors.red
                                    : Colors.green,
                                size: 30.0,
                              ),
                              onPressed: () {
                                habitlist[id].week[2] = !habitlist[id].week[2];
                                setState(() {});
                              },
                              splashColor: Colors.transparent,
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.015),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.12,
                            height: MediaQuery.of(context).size.width * 0.12,
                            child: IconButton(
                              icon: Icon(
                                habitlist[id].week[3] == false
                                    ? Icons.close
                                    : Icons.check,
                                color: habitlist[id].week[3] == false
                                    ? Colors.red
                                    : Colors.green,
                                size: 30.0,
                              ),
                              onPressed: () {
                                habitlist[id].week[3] = !habitlist[id].week[3];
                                setState(() {});
                              },
                              splashColor: Colors.transparent,
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.015),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.12,
                            height: MediaQuery.of(context).size.width * 0.12,
                            child: IconButton(
                              icon: Icon(
                                habitlist[id].week[4] == false
                                    ? Icons.close
                                    : Icons.check,
                                color: habitlist[id].week[4] == false
                                    ? Colors.red
                                    : Colors.green,
                                size: 30.0,
                              ),
                              onPressed: () {
                                habitlist[id].week[4] = !habitlist[id].week[4];
                                setState(() {});
                              },
                              splashColor: Colors.transparent,
                            ),
                          ),
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
