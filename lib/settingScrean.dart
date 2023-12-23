import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widgets.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Settings(),
    );
  }
}

class Settings extends StatefulWidget {
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Settings> {
  TextEditingController? txtWork;
  TextEditingController? txtShort;
  TextEditingController? txtLong;
  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";
  int workTime = 0;
  int shortBreak = 0;
  int longBreak = 0;

  late SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();
    readSettings();
  }

  readSettings() async {
    prefs = await SharedPreferences.getInstance();
    int? workTime = prefs.getInt(WORKTIME);
    if (workTime == null) {
      await prefs.setInt(WORKTIME, int.parse('30'));
    }
    int? shortBreak = prefs.getInt(SHORTBREAK);
    if (shortBreak == null) {
      await prefs.setInt(SHORTBREAK, int.parse('5'));
    }
    int? longBreak = prefs.getInt(LONGBREAK);
    if (longBreak == null) {
      await prefs.setInt(LONGBREAK, int.parse('20'));
    }
    setState(() {
      txtWork?.text = workTime.toString();
      txtShort?.text = shortBreak.toString();
      txtLong?.text = longBreak.toString();
    });
  }

  void updateSetting(String key, int value) {
    switch (key) {
      case WORKTIME:
        {
          int? workTime = prefs.getInt(WORKTIME);
          if (workTime != null) {
            workTime += value;
          } else {
            workTime = value; // Ou une valeur par défaut, selon votre logique
          }
          if (workTime >= 1 && workTime <= 180) {
            prefs.setInt(WORKTIME, workTime);
            setState(() {
              txtWork?.text = workTime.toString();
            });
          }
        }
        break;
      case SHORTBREAK:
        {
          int? short = prefs.getInt(SHORTBREAK);
          if (short != null) {
            short += value;
          } else {
            short = value;
          }
          if (short >= 1 && short <= 120) {
            prefs.setInt(SHORTBREAK, short);
            setState(() {
              txtShort?.text = short.toString();
            });
          }
        }
        break;
      case LONGBREAK:
        {
          int? long = prefs.getInt(LONGBREAK);
          if (long != null) {
            long += value;
          } else {
            long = value;
          }
          if (long >= 1 && long <= 180) {
            prefs.setInt(LONGBREAK, long);
            setState(() {
              txtLong?.text = long.toString();
            });
          }
        }
        break;
    }
  }

  TextStyle textStyle = TextStyle(fontSize: 24);
  double buttonSize = 150;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: GridView.count(
      scrollDirection: Axis.vertical,
      crossAxisCount: 3,
      childAspectRatio: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: <Widget>[
        Text("Work", style: textStyle),
        Text(""),
        Text(""),
        SettingsButton(
          color: Color(0xff455A64),
          text: "-",
          value: -1,
          size: buttonSize,
          setting: WORKTIME,
          callback: updateSetting,
        ),
        TextField(
          style: textStyle,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          controller: txtWork,
        ),
        SettingsButton(
            color: Color(0xff009688),
            text: "+",
            size: buttonSize,
            value: 1,
            setting: WORKTIME,
            callback: updateSetting),
        Text("Short", style: textStyle),
        Text(""),
        Text(""),
        SettingsButton(
            color: Color(0xff455A64),
            text: "-",
            size: buttonSize,
            value: -1,
            setting: SHORTBREAK,
            callback: updateSetting),
        TextField(
          style: textStyle,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          controller: txtShort,
        ),
        SettingsButton(
          color: Color(0xff009688),
          text: "+",
          value: 1,
          setting: SHORTBREAK,
          callback: updateSetting,
          size: buttonSize,
        ),
        Text(
          "Long",
          style: textStyle,
        ),
        Text(""),
        Text(""),
        SettingsButton(
          color: Color(0xff455A64),
          text: "-",
          value: -1,
          setting: LONGBREAK,
          callback: updateSetting,
          size: buttonSize,
        ),
        TextField(
          style: textStyle,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          controller: txtLong,
        ),
        SettingsButton(
          color: Color(0xff009688),
          text: "+",
          value: 1,
          setting: LONGBREAK,
          callback: updateSetting,
          size: buttonSize,
        ),
      ],
      padding: const EdgeInsets.all(20.0),
    ));
  }
}
