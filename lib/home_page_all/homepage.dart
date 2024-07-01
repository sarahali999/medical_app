import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'news_detail_page.dart';
import 'news_model.dart';
import 'map.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUserCard(context),
            _buildExaminationCards(context),
            _buildSectionTitle('اخر الاخبار'),
            _buildClinicNews(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF5CBBE3),
            Color(0xFFE9ECEC),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'معلومات المستخدم',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16.0),
            _buildInfoRow(Icons.person, 'الاسم ', 'أحمد محمد'),
            _buildInfoRow(Icons.phone, 'رقم الهاتف', '+1234567890'),
            _buildInfoRow(Icons.location_on, 'العنوان', 'شارع النصر، مدينة نصر، القاهرة'),
            _buildInfoRow(Icons.opacity, 'فصيلة الدم', 'O+'),
          ],
        ),
      ),
    );
  }
  Widget _buildExaminationCards(BuildContext context) {
    return Container(

      height: 100,

      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildExaminationCard(
            context,
            'العلاج المستمر',
            'الفحوصات والادوية التي تلقاها الزائر',
            Color(0xffdff19e),
                () => _navigateToExaminationDetails(context, 'أزمة ارتفاع ضغط الدم'),
          ),
          _buildExaminationCard(
            context,
            'الحالة المرضية الكاملة',
            'تقريره الطبي',
            Color(0xfff5d8b7),
                () => _navigateToExaminationDetails(context, 'هشاشة العظام'),
          ),
          _buildExaminationCard(
            context,
            'دليلك الى المفارز الطبية',
            'الخريطة',
            Color(0xFFa3d0c6),
                () => _navigateToExaminationDetails(context, 'الخريطة'),
          ),
          _buildExaminationCard(
            context,
            '21 يوليو, 2023',
            'أزمة ارتفاع ضغط الدم',
            Colors.green.shade100,
                () => _navigateToExaminationDetails(context, 'أزمة ارتفاع ضغط الدم'),
          ),
        ],
      ),
    );
  }

  Widget _buildExaminationCard(
      BuildContext context,
      String date,
      String title,
      Color color,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        width: 250,
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Changa-VariableFont_wght',
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontFamily: 'Changa-VariableFont_wght',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToExaminationDetails(BuildContext context, String examinationType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyApp(), // Update this to the actual page you want to navigate to
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(

      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.black, size: 20),
          SizedBox(width: 8),
          Text(
            '$label: ',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Text(value, style: TextStyle(fontSize: 16.0, fontFamily: 'Changa-VariableFont_wght')),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'Changa-VariableFont_wght',
        ),
      ),
    );
  }

  Widget _buildClinicNews() {
    return FutureBuilder<List<Article>>(
      future: NewsService().fetchArticles(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'فشل في تحميل الأخبار',
              style: TextStyle(color: Colors.red, fontFamily: 'Changa-VariableFont_wght'),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'لا توجد أخبار متاحة',
              style: TextStyle(color: Colors.grey, fontFamily: 'Changa-VariableFont_wght'),
            ),
          );
        } else {
          return CarouselSlider(
            options: CarouselOptions(
              height: 250,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
            ),
            items: snapshot.data!.map((article) {
              return Builder(
                builder: (BuildContext context) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetailPage(article: article),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              article.imageUrl,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                                  ),
                                ),
                                child: Text(
                                  article.title,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          );
        }
      },
    );
  }
}
