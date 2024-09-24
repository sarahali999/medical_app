import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Publicnotices extends StatefulWidget {
  @override
  _PublicnoticesState createState() => _PublicnoticesState();
}

class _PublicnoticesState extends State<Publicnotices> {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  final List<Map<String, dynamic>> notices = [
    {
      'title': 'إرشادات صحية هامة',
      'content': 'نرجو منكم الالتزام بارتداء الكمامة وتعقيم اليدين باستمرار. توجد محطات تعقيم في جميع أنحاء المبنى.',
      'icon': Icons.health_and_safety,
    },
    {
      'title': 'خدمات طبية متاحة',
      'content': 'يوجد فريق طبي متخصص متاح على مدار الساعة. إذا شعرت بتوعك، يرجى التوجه إلى مكتب الاستقبال للمساعدة الفورية.',
      'icon': Icons.local_hospital,
    },
    {
      'title': 'جدول أخذ الأدوية',
      'content': 'تذكير: يرجى الالتزام بجدول أخذ أدويتكم كما هو موصوف من قبل طبيبكم. إذا كنتم بحاجة إلى مساعدة، فريقنا الطبي مستعد لمساعدتكم.',
      'icon': Icons.medication,
    },
    {
      'title': 'نظام غذائي خاص',
      'content': 'نقدم وجبات تتناسب مع احتياجاتكم الغذائية الخاصة. يرجى إبلاغ موظفي الاستقبال بأي متطلبات غذائية محددة.',
      'icon': Icons.restaurant_menu,
    },
    {
      'title': 'راحتكم أولويتنا',
      'content': 'إذا كنتم بحاجة إلى أي مساعدة إضافية أو لديكم أي استفسارات، لا تترددوا في التواصل مع فريقنا. نحن هنا لضمان راحتكم وسلامتكم.',
      'icon': Icons.support_agent,
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  void _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification tap
        print('Notification tapped with payload: ${response.payload}');
      },
    );
  }

  Future<void> _showNotification(String title, String content) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      styleInformation: BigTextStyleInformation(''),
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      content,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF5BB9AE),
          elevation: 0,
          title: Text(
            'إشعارات صحية',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF5BB9AE)!,
                Color(0xFFBCE3F3)!],
            ),
          ),
          child: AnimationLimiter(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 16),
              itemCount: notices.length,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 500),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Card(
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.teal[100],
                                child: Icon(notices[index]['icon'] as IconData, color: Color(0xFF5BB9AE)),
                              ),
                              title: Text(
                                notices[index]['title']!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color(0xFF5BB9AE),
                                ),
                              ),
                              subtitle: Text(
                                notices[index]['content']!,
                                style: TextStyle(fontSize: 16, height: 1.5, color: Colors.black54),
                                textAlign: TextAlign.justify,
                              ),
                              trailing: Icon(Icons.arrow_drop_down, color: Color(0xFF5BB9AE)),
                              onTap: () {
                                // Handle expansion logic if needed
                                _showNotification(
                                  notices[index]['title']!,
                                  notices[index]['content']!,
                                );
                              },
                            ),
                            Divider(
                              color: Color(0xFF5BB9AE),
                              height: 1,
                              thickness: 1,
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
        ),
      ),
    );
  }
}
