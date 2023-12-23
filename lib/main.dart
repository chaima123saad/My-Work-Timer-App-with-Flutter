import 'package:flutter/material.dart';
import 'widgets.dart';
import 'model/timer.dart';
import 'settingScrean.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'model/timermodel.dart';

void main() => runApp(MyApp());
final double defaultPadding = 5.0;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Work Timer',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      routes: {
        '/settings': (context) => SettingScreen(),
      },
      home: TimerHomePage(),
    );
  }
}

class TimerHomePage extends StatelessWidget {
  final CountDownTimer timer = CountDownTimer();
  TimerHomePage() {
    timer.readSettings();
    timer.startWork();
  }
  @override
  Widget build(BuildContext context) {
    final List<PopupMenuItem<String>> menuItems = [];

    menuItems.add(PopupMenuItem(
      value: 'Settings',
      child: Text('Settings'),
    ));
    timer.startWork();
    return Scaffold(
      appBar: AppBar(title: Text('My work timer'), actions: [
        PopupMenuButton<String>(
          itemBuilder: (BuildContext context) {
            return menuItems.toList();
          },
          onSelected: (s) {
            if (s == 'Settings') {
              goToSettings(context);
            }
          },
        )
      ]),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        final double availableWidth = constraints.maxWidth;
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.all(defaultPadding),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                    child: ProductivityButton(
                        color: Color(0xff009688),
                        text: "Work",
                        onPressed: () => timer.startWork(),
                        size: 150)),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                    child: ProductivityButton(
                        color: Color(0xff607D8B),
                        text: "Short Break",
                        onPressed: () => timer.startBreak(true),
                        size: 150)),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                    child: ProductivityButton(
                  color: Color(0xff455A64),
                  text: "Long Break",
                  onPressed: () => timer.startBreak(false),
                  size: 150,
                )),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
              ],
            ),
            StreamBuilder(
                initialData: '00:00',
                stream: timer.stream(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  TimerModel timer = (snapshot.data == '00:00')
                      ? TimerModel('00:00', 1)
                      : snapshot.data;
                  return Expanded(
                      child: CircularPercentIndicator(
                    radius: availableWidth / 2,
                    lineWidth: 10.0,
                    percent: timer.percent,
                    center: Text(timer.time,
                        style: Theme.of(context).textTheme.headline4),
                    progressColor: Color(0xff009688),
                  ));
                }),
            Row(children: [
              Padding(
                padding: EdgeInsets.all(defaultPadding),
              ),
              Expanded(
                  child: ProductivityButton(
                color: Color(0xff212121),
                text: 'Stop',
                onPressed: () => timer.stopTimer(),
              )),
              Padding(
                padding: EdgeInsets.all(defaultPadding),
              ),
              Expanded(
                  child: ProductivityButton(
                      color: Color(0xff009688),
                      text: 'Restart',
                      onPressed: () => timer.startTimer())),
              Padding(
                padding: EdgeInsets.all(defaultPadding),
              ),
            ]),
            Padding(
              padding: EdgeInsets.all(defaultPadding),
            ),
          ],
        );
      }),
    );
  }

  void goToSettings(BuildContext context) {
    print("Context: $context");
    Navigator.pushNamed(context, '/settings');
  }

  void emptyMethod() {}
}
