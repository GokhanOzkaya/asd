import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fteamdeneme/a.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fteamdeneme/noti.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main()  {runApp(MaterialApp(home: HomePage()));}
//void main() => runApp(MaterialApp(home: HomePage()));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page=0;
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

  GorevVeri gorevveri1 = GorevVeri();
  int selectedMonth = 5;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(initialScrollOffset: (360) * (selectedMonth - 1));
    Noti.initialize(flutterLocalNotificationsPlugin);
  }

  Card buildCard(int index, int month) {
    bool isChecked = gorevveri1.getGorevForMonth(month, index).tamamlandiMi;

    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: InkWell(
          onTap: () {
            setState(() {
              isChecked = !isChecked;
              gorevveri1.getGorevForMonth(month, index).tamamlandiMi = isChecked;
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
          '${gorevveri1.getGorevForMonth(month, index).ad}',
          style: TextStyle(
            fontSize: 18,
            decoration: isChecked ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        trailing: GestureDetector(
            child: Icon(Icons.alarm_add,)
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Text(
                  'Merhaba Gökhan',
                  textScaleFactor: 2,
                ),
              ),
            ],
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
                      onTap: (){
                        setState(() {
                          selectedMonth = index + 1; // ay indeksleri 0'dan başladığı için 1 eklemelisiniz
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
                                IconButton(
                                  iconSize: 50.0,
                                  color: Colors.white,
                                  icon: Icon(Icons.analytics),
                                  onPressed: () {
                                    // Icon'a tıklanınca yapılacak işlemler buraya yazılır
                                  },
                                )
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
              itemCount: gorevveri1.getGorevlerForMonth(selectedMonth).length,
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
                  List<Gorev> selectedGorevler = gorevveri1.getGorevlerForMonth(selectedMonth);
                  selectedGorevler.forEach((gorev) {
                    if (gorev.tamamlandiMi) checkedCount++;
                  });
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Seçili görev sayısı: $checkedCount / Toplam görev sayısı: ${selectedGorevler.length}"),
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
                child: Text('İstatistik'),
              ),
              ElevatedButton(onPressed: () {  
                Noti.showBigTextNotification(title: 'Ok hırrımı', body: 'takım gibi ananzı', fln: flutterLocalNotificationsPlugin);
              },
              child : Text('Bildirim yolla'))
            ],
          ),
        ],
      ),
    );
  }
}
