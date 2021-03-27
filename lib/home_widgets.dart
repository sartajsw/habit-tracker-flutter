import 'package:flutter/material.dart';
import 'package:habit_tracker/habitclass.dart';
import 'package:intl/intl.dart';

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
                color: (() {
                  // your code here
                  if (widget.habit.goal == 0) {
                    return Colors.white;
                  } else {
                    return widget.habit.week[widget.daynum] < widget.habit.goal
                        ? Colors.red
                        : Colors.green;
                  }
                }()),
                fontSize: widget.habit.week[widget.daynum] < 10 ? 24 : 14,
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

class ReverseElement extends StatefulWidget {
  const ReverseElement({
    Key key,
    @required this.habit,
    @required this.daynum,
  }) : super(key: key);

  final Habit habit;
  final int daynum;

  @override
  _ReverseElementState createState() => _ReverseElementState();
}

class _ReverseElementState extends State<ReverseElement> {
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
                color: (() {
                  // your code here
                  if (widget.habit.goal == 0) {
                    return Colors.white;
                  } else {
                    return widget.habit.week[widget.daynum] < widget.habit.goal
                        ? Colors.green
                        : Colors.red;
                  }
                }()),
                fontSize: widget.habit.week[widget.daynum] < 10 ? 24 : 14,
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
