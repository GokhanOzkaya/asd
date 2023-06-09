import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fteamdeneme/a.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fteamdeneme/noti.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() {
  runApp(MaterialApp(home: HomePage()));
}
//void main() => runApp(MaterialApp(home: HomePage()));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  @override
  void initState() {
    super.initState();
    _page = 2;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _bottomNavigationKey.currentState!.setPage(_page);
    });
  }

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  Widget _buildPage(int page) {
    switch (page) {
      case 0:
        return FirstPage();
      case 1:
        return SecondPage();
      case 2:
        return ThirdPage();
      case 3:
        return ThirdPage();
      case 4:
        return ThirdPage();
      // Diğer sayfalar...
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: <Widget>[
            Icon(Icons.add, size: 30),
            Icon(Icons.list, size: 30),
            Icon(Icons.compare_arrows, size: 30),
            Icon(Icons.call_split, size: 30),
            Icon(Icons.perm_identity, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 400),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: _buildPage(_page),
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text('First Page'),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      child: Center(
        child: Text('Second Page'),
      ),
    );
  }
}

class ThirdPage extends StatefulWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  late ScrollController scrollController;
  Timer? _timer;
  GorevVeri gorevveri1 = GorevVeri();
  int selectedMonth = 5;
  List<Map<String, dynamic>> alarms = [];


  @override
  void initState() {
    super.initState();
    scrollController =
        ScrollController(initialScrollOffset: (360) * (selectedMonth - 1));
    Noti.initialize(flutterLocalNotificationsPlugin);
    _startTimer();
  }

  Card buildCard(int index, int month) {
    bool isChecked = gorevveri1
        .getGorevForMonth(month, index)
        .tamamlandiMi;

    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: InkWell(
          onTap: () {
            setState(() {
              isChecked = !isChecked;
              gorevveri1
                  .getGorevForMonth(month, index)
                  .tamamlandiMi =
                  isChecked;
            });
          },
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 2,
                color: isChecked ? Colors.blue : Colors.grey.shade400,
              ),
              color: isChecked ? Colors.blue : Colors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: isChecked
                  ? Icon(
                Icons.check,
                size: 16.0,
                color: Colors.white,
              )
                  : null,
            ),
          ),
        ),
        title: Text(
          '${gorevveri1
              .getGorevForMonth(month, index)
              .ad}',
          style: TextStyle(
            fontSize: 18,
            decoration:
            isChecked ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        trailing: GestureDetector(
            child: IconButton(
              onPressed: () {
                _showAlarmPopup();
              },
              icon: Icon(Icons.add_alarm),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 20, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.ac_unit_outlined),
                Text(
                  'Merhaba Gökhan',
                  textScaleFactor: 2,
                ),
              ],
            ),
          ),
          Container(
            height: 200,
            child: ListView.builder(
              controller: scrollController,
              itemCount: 7,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedMonth = index +
                              1;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        width: 360,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue,
                              Colors.white10,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 5), // vertical shadow
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              '${gorevveri1.aylar[index]}',
                              style: TextStyle(
                                fontSize: 35,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: istatistikBuild(context),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 30.0),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ListView.builder(
                                              itemCount: alarms.length,
                                              itemBuilder: (BuildContext context, int index) {
                                                // Alarmların listelenmesi
                                                return ListTile(
                                                  title: Text(alarms[index]['name']),
                                                  subtitle: Text('${alarms[index]['time']} ${alarms[index]['date']}'),
                                                );
                                              },
                                            );
                                          },
                                        );
                                      });
                                    },
                                    icon: Icon(Icons.alarm),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: gorevveri1
                  .getGorevlerForMonth(selectedMonth)
                  .length,
              itemBuilder: (BuildContext context, int index) {
                return buildCard(index, selectedMonth);
              },
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  int checkedCount = 0;
                  List<Gorev> selectedGorevler = gorevveri1.getGorevlerForMonth(
                      selectedMonth);
                  selectedGorevler.forEach((gorev) {
                    if (gorev.tamamlandiMi) checkedCount++;
                  });

                  DateTime now = DateTime.now();
                  DateTime endOfMonth = DateTime(now.year, now.month + 1, 0);
                  DateTime tenDaysBeforeEndOfMonth = endOfMonth.subtract(
                      Duration(days: 10));
                  DateTime fiveDaysBeforeEndOfMonth = endOfMonth.subtract(
                      Duration(days: 5));

                  if (now.isBefore(tenDaysBeforeEndOfMonth)) {
                    Noti.showBigTextNotification(
                        title: 'HEY BURSİYER',
                        body:
                        '${gorevveri1.aylar[now
                            .month]} aynın $checkedCount tanesini tamamladın, geriye ${selectedGorevler
                            .length} görevin kaldı\nHaydi rehavete kapılam ve devam et',
                        fln: flutterLocalNotificationsPlugin);
                  }
                  if (now.isBefore(fiveDaysBeforeEndOfMonth)) {
                    Noti.showBigTextNotification(
                        title: 'HEY BURSİYER',
                        body:
                        '${gorevveri1.aylar[now
                            .month]} aynın $checkedCount tanesini tamamladın, geriye ${selectedGorevler
                            .length} görevin kaldı\nHaydi rehavete kapılam ve devam et',
                        fln: flutterLocalNotificationsPlugin);
                  }
                },
                child: Text('Bildirim yolla'),
              ),
              ElevatedButton(onPressed: (){
                alarms.clear();
              }, child:Text('Listes Sil') ),
            ],
          ),
        ],
      ),
    );
  }

  IconButton istatistikBuild(BuildContext context) {
    return IconButton(
      onPressed: () {
        int checkedCount = 0;
        List<Gorev> selectedGorevler =
        gorevveri1.getGorevlerForMonth(selectedMonth);
        selectedGorevler.forEach((gorev) {
          if (gorev.tamamlandiMi) checkedCount++;

        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                  "Tamamlanan görev sayısı: $checkedCount \nToplam görev sayısı: ${selectedGorevler.length}\nGörev Durumu: ${gorevDurumu(checkedCount,selectedGorevler.length)}"
              ),
              actions: [
                TextButton(
                  child: Text("Tamam"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      icon: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Icon(Icons.analytics_outlined, size: 50,),
      ),
    );
  }

  void _startTimer() {
    // Set up a timer to run onPressed every hour
    _timer = Timer.periodic(Duration(hours: 1), (timer) {
      int checkedCount = 0;
      List<Gorev> selectedGorevler = gorevveri1.getGorevlerForMonth(
          selectedMonth);
      selectedGorevler.forEach((gorev) {
        if (gorev.tamamlandiMi) checkedCount++;
      });

      DateTime now = DateTime.now();
      DateTime endOfMonth = DateTime(now.year, now.month + 1, 0);
      DateTime tenDaysBeforeEndOfMonth = endOfMonth.subtract(
          Duration(days: 10));
      DateTime fiveDaysBeforeEndOfMonth = endOfMonth.subtract(
          Duration(days: 5));

      if (now.isBefore(tenDaysBeforeEndOfMonth)) {
        Noti.showBigTextNotification(
            title: 'HEY BURSİYER',
            body:
            '${gorevveri1.aylar[now
                .month]} aynı görevlerinin $checkedCount tanesini tamamladın, geriye ${(selectedGorevler
                .length)-checkedCount} görevin kaldı.',
            fln: flutterLocalNotificationsPlugin);
      }
      if (now.isBefore(fiveDaysBeforeEndOfMonth)) {
        Noti.showBigTextNotification(
            title: 'HEY BURSİYER!!!',
            body:
            '${gorevveri1.aylar[now
                .month]} aynın $checkedCount tanesini tamamladın, geriye ${selectedGorevler
                .length} görevin kaldı\nHaydi rehavete kapılam ve devam et',
            fln: flutterLocalNotificationsPlugin);
      }
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget buildSecond(BuildContext context) {
    return ElevatedButton(
      onPressed: null,
      child: Text('Bildirim yolla'),
    );
  }

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  String alarmName = '';

  void _showAlarmPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Alarm Kur"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Alarm İsmi',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    alarmName = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              ListTile(
                title: Text("Tarih"),
                subtitle: Text("${selectedDate.toLocal()}".split(' ')[0]),
                trailing: Icon(Icons.keyboard_arrow_down),
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null && pickedDate != selectedDate) {
                    setState(() {
                      selectedDate = pickedDate;
                    });
                  }
                },
              ),
              ListTile(
                title: Text("Saat"),
                subtitle: Text("${selectedTime.format(context)}"),
                trailing: Icon(Icons.keyboard_arrow_down),
                onTap: () async {
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                  );
                  if (pickedTime != null && pickedTime != selectedTime) {
                    setState(() {
                      selectedTime = pickedTime;
                    });
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("İptal"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Kaydet"),
              onPressed: () {
                final alarm = {
                  'name': alarmName,
                  'date': selectedDate.toString().substring(0, 10),
                  'time': selectedTime.format(context),
                };
                setState(() {
                  alarms.add(alarm);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String  gorevDurumu(int gorevSayisi,int tamamlananGorevSayisi) {
    if(tamamlananGorevSayisi==gorevSayisi){
      return 'Tamamlandı';
    }
    else{
      return 'Tamamlanmadı';
    }
  }
}