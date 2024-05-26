import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';
import 'category_card.dart';
import 'map.dart';
import 'news_service.dart';
import 'news_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'lang.dart';

class HomeScreen extends StatefulWidget {
  final Language selectedLanguage;

  HomeScreen({required this.selectedLanguage});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = ProductService().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(20, 50, 20, 30),
            height: size.height * .32,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
              gradient: LinearGradient(
                colors: [
                  Color(0xFF00897B),
                  Color(0xFF80CBC4),
                ],
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: CircleAvatar(
              radius: 35.0,
              backgroundImage: AssetImage('assets/images/i.jpg'),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 60),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        widget.selectedLanguage == Language.Arabic
                            ? "دليل طبي "
                            : widget.selectedLanguage == Language.Persian
                            ? "راهنمای پزشکی"
                            : widget.selectedLanguage == Language.English
                            ? "Medical Guide"
                            : widget.selectedLanguage == Language.Kurdish
                            ? "راهنمای پزیشکی"
                            : "",
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Changa-VariableFont_wght',
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        widget.selectedLanguage == Language.Arabic
                            ? "رفيقك الصحي "
                            : widget.selectedLanguage == Language.Persian
                            ? "همراه سلامت شما"
                            : widget.selectedLanguage == Language.English
                            ? "Your Health Companion"
                            : widget.selectedLanguage == Language.Kurdish
                            ? "هاوڕێی سلامەتیت"
                            : "",
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Changa-VariableFont_wght',
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ClipRRect(child: SizedBox(height: 150)),
                    ClipRRect(
                      child: SizedBox(
                        height: 250,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.all(10),
                          children: <Widget>[
                            CategoryCard(
                              key: Key('1'),
                              title: widget.selectedLanguage == Language.Arabic
                                  ? "الخريطة"
                                  : widget.selectedLanguage == Language.Persian
                                  ? "نقشه"
                                  : widget.selectedLanguage == Language.English
                                  ? "Map"
                                  : widget.selectedLanguage == Language.Kurdish
                                  ? "نەخشە"
                                  : "",
                              press: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return MyApp();
                                    },
                                  ),
                                );
                              },
                              svgScr: 'assets/icons/map-svgrepo-com.svg',
                            ),
                            SizedBox(width: 10.0),
                            CategoryCard(
                              key: Key('2'),
                              title: widget.selectedLanguage == Language.Arabic
                                  ? "معلومات الزائر "
                                  : widget.selectedLanguage == Language.Persian
                                  ? "اطلاعات بازدید کننده"
                                  : widget.selectedLanguage == Language.English
                                  ? "Visitor Information"
                                  : widget.selectedLanguage == Language.Kurdish
                                  ? "زانیاری سەرنجەمەند"
                                  : "",
                              press: () {},
                              svgScr: 'assets/icons/list-svgrepo-com.svg',
                            ),
                            SizedBox(width: 10.0),
                            CategoryCard(
                              key: Key('3'),
                              title: widget.selectedLanguage == Language.Arabic
                                  ? "عدد الزيارات "
                                  : widget.selectedLanguage == Language.Persian
                                  ? "تعداد بازدیدها"
                                  : widget.selectedLanguage == Language.English
                                  ? "Number of Visits"
                                  : widget.selectedLanguage == Language.Kurdish
                                  ? "ژمارەی سەردانەکان"
                                  : "",
                              press: () {},
                              svgScr: 'assets/icons/hospital-svgrepo-com.svg',
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: ClipRRect(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                widget.selectedLanguage == Language.Arabic
                                    ? 'اخر الاحداث'
                                    : widget.selectedLanguage == Language.Persian
                                    ? 'آخرین اخبار'
                                    : widget.selectedLanguage == Language.English
                                    ? 'Latest News'
                                    : widget.selectedLanguage == Language.Kurdish
                                    ? 'وەڵامەکانی نوێترین'
                                    : '',
                                style: Theme.of(context).textTheme.headline6?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Changa-VariableFont_wght',
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FutureBuilder<List<Product>>(
                      future: futureProducts,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Failed to load products'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(child: Text('No products available'));
                        } else {
                          return CarouselSlider(
                            options: CarouselOptions(
                              height: 400,
                              autoPlay: true,
                              enlargeCenterPage: true,
                            ),
                            items: snapshot.data!.map((product) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Container(
                                        color: Colors.white,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            product.images.isNotEmpty
                                                ? Image.network(product.images[0], height: 200, fit: BoxFit.cover)
                                                : Container(height: 200, color: Colors.grey),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                product.title,
                                                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: Text(
                                                product.description,
                                                style: TextStyle(fontSize: 14.0),
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
