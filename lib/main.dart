import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fteamdeneme/contact.dart';

void main() => runApp(MaterialApp(home: HomePage()));

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
  int selectedMonth = 3;


    List <String> unitytasks = [
    """Ocak-Şubat""",
    """Oryantasyon buluşmasına katıl.""",
    """Unity Giriş Eğitimini %100 tamamla.(ZORUNLU)	""",
    """Yazılımcılar için İngilizce derslerinin 2 modülünü tamamla. (SEÇENLER İÇİN ZORUNLU)""",
    """Teknoloji Girişimciliği Eğitimlerinin %50’sini tamamla. Tüm eğitimler toplamda 12 saat, 6 saatini tamamla.(ZORUNLU)""",
    """Google Proje Yönetimi Eğitimlerinin 1. kursunu  tamamla.(ZORUNLU)""",
    """Networking atölyesini tamamla. 1'ine katılım yeterli.""",
    """Sosyal Beceri Eğitimlerine katıl.""",
    """Kariyer Buluşması’na katıl.""",
    """Zaman Yönetimi etkinliğine katıl.""",
    """Github BTK Akademi derslerine göz at ve Akademi Github görevlerini tamamla.""",
    """Şubat""",
    """Deprem nedeniyle topluluk iletişimi odağa alındı, görevler Temmuz ayına dek uzatıldı. Depremden etkilenen arkadaşlarımıza 2023 yılı bursiyeri olma hakkı verildi. Bu hakkı kullanmak isteyen arkadaşlarımız sistemlerden çıkarılacak ve seneye sıfırdan tüm eğitimleri alacaklar, Slack kanalında kalmaya devam edebilecekler.""",
    """Mart""",
    """Unity Uzmanlık Eğitimlerinin 1-10 arası modüllerini (%34) tamamla.(ZORUNLU)""",
    """Google Proje Yönetimi Eğitimlerinin 2. kursunu tamamla. (ZORUNLU)""",
    """Yazılımcılar için İngilizce derslerinin ilk 4 modülünü tamamla.(SEÇENLER İÇİN ZORUNLU)""",
    """Teknoloji Girişimciliği Eğitimlerini %100 tamamla.(ZORUNLU)""",
    """Ideathon’a katıl.""",
    """Ayın Github görevlerini tamamla.""",
    """Canlı yayınlara katıl.""",
    """Nisan""",
    """Unity Uzmanlık Eğitimlerinin 11-19 arası modüllerini (%70) tamamla.(ZORUNLU)""",
    """Google Proje Yönetimi Eğitimlerinin 3.kursunu tamamla.(ZORUNLU)""",
    """Yazılımcılar için İngilizce derslerinin ilk 6 modülünü tamamla.(SEÇENLER İÇİN ZORUNLU) """,
    """Game & App Jam’e katıl.(ZORUNLU)""",
    """Canlı yayınlara katıl.""",
    """Mayıs""",
    """Unity Uzmanlık Eğitimini %100 tamamla.(ZORUNLU)""",
    """Google Proje Yönetimi Eğitimlerinin 4. ve 5.kursunu tamamla.(ZORUNLU)""",
    """Yazılımcılar için İngilizce derslerini %100(8 modül) tamamla.(SEÇENLER İÇİN ZORUNLU)""",
    """Kariyer Zirvesine Katıl. (ZORUNLU)""",
    """Canlı yayınlara katıl.""",
    """Haziran""",
    """Eksik kalan tüm eğitimlerini tamamla! Rozetlerini al""",
    """Google Proje Yönetimi Eğitimlerinin 6.kursunu tamamla.(ZORUNLU)""",
    """Kariyer Buluşması’na Katıl.""",
    """Mezuniyet BOOTCAMP’ine Odaklan.""",
    """Canlı yayınlara katıl.""",
    """Temmuz""",
    """BOOTCAMP’i tamamla.""",
    """Mezuniyet Törenine katıl.""",
    """Sertifikalarını al.""",
    """Mezunlar ağına dahil ol """,
    ];



bool isChecked =true;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(initialScrollOffset: (360) * (selectedMonth-1));
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
                padding: const EdgeInsets.all(8.0),
                child: Text('Merhaba Gökhan',textScaleFactor: 2,),
              ),
            ],
          ),
          Container(
            height: 200,
            child: ListView.builder(
              controller: scrollController,
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return SafeArea(
                  child: Container(
                    margin: EdgeInsets.all(5),
                    width: 360,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text('Kutu ${index + 1}'),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: unitytasks.length,
              itemBuilder: (BuildContext context, int index) {
                return
                  Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: ListTile(
                      leading: InkWell(
                        onTap: () {
                          setState(() {
                            isChecked = !isChecked;
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
                        unitytasks[index],
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Task Details Here",
                        style: TextStyle(fontSize: 14),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // delete task
                        },
                      ),
                    ),
                  );
              },
            ),
          ),


        ],
      ),
    );
  }
}



