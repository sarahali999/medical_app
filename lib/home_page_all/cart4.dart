import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../languages/lang.dart';

class Cart4 extends StatelessWidget {
  final Language selectedLanguage;

  Cart4({required this.selectedLanguage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          _getLocalizedText('religious_aspect'),
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: AnimationLimiter(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: [
              _buildSection(
                title: _getLocalizedText('remembering_imam_hussein'),
                content: _getArabicText('imam_hussein_prayer'),
                icon: Icons.star,
              ),
              _buildSection(
                title: _getLocalizedText('abbas_remembrance'),
                content: _getArabicText('abbas_prayer'),
                icon: Icons.water_drop,
              ),
              _buildSection(
                title: _getLocalizedText('journey_prayers'),
                content: _getArabicText('journey_prayer_content'),
                icon: Icons.route,
              ),
              _buildSection(
                title: _getLocalizedText('recommended_glorifications'),
                content: _getArabicText('glorification_content'),
                icon: Icons.repeat,
              ),
              _buildSection(
                title: _getLocalizedText('blessings_on_muhammad'),
                content: _getArabicText('blessings_on_muhammad'),
                icon: Icons.brightness_5,
              ),
              _buildSection(
                title: _getLocalizedText('arbaeen_visitation'),
                content: _getArabicText('arbaeen_prayer'),
                icon: Icons.place,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              content,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  String _getLocalizedText(String key) {
    Map<String, Map<String, String>> localizedTexts = {
      'religious_aspect': {
        'Arabic': 'الجانب الديني',
        'Persian': 'جنبه مذهبی',
        'Kurdish': 'لایەنی ئایینی',
        'Turkmen': 'Dini tarap',
        'English': 'Religious Aspect',
      },
      'remembering_imam_hussein': {
        'Arabic': 'استذكار شهادة الإمام الحسين (ع)',
        'Persian': 'یادآوری شهادت امام حسین (ع)',
        'Kurdish': 'بیرهێنانەوەی شەهادەتی ئیمام حوسەین (ع)',
        'Turkmen': 'Imam Hüseýiniň (a.s.) şehadat ýatlamagy',
        'English': 'Remembering Imam Hussein\'s (PBUH) Martyrdom',
      },
      'abbas_remembrance': {
        'Arabic': 'ذكر العباس (ع)',
        'Persian': 'یاد عباس (ع)',
        'Kurdish': 'یادی عەباس (ع)',
        'Turkmen': 'Abbasyň (a.s.) ýatlanmagy',
        'English': 'Remembrance of Abbas (PBUH)',
      },
      'journey_prayers': {
        'Arabic': 'أدعية الطريق',
        'Persian': 'دعاهای سفر',
        'Kurdish': 'دوعاکانی ڕێگا',
        'Turkmen': 'Ýol dogalary',
        'English': 'Journey Prayers',
      },
      'recommended_glorifications': {
        'Arabic': 'التسبيحات الموصى بها',
        'Persian': 'تسبیحات توصیه شده',
        'Kurdish': 'گوڕانییەکانی پێشنیارکراو',
        'Turkmen': 'Maslahat berlen tesbihler',
        'English': 'Recommended Glorifications',
      },
      'blessings_on_muhammad': {
        'Arabic': 'الصلاة على محمد وآل محمد',
        'Persian': 'صلوات بر محمد و آل محمد',
        'Kurdish': 'سەلاوات لەسەر محەمەد و خانەوادەی محەمەد',
        'Turkmen': 'Muhammet we onuň maşgalasyna salawat',
        'English': 'Blessings on Muhammad and his family',
      },
      'arbaeen_visitation': {
        'Arabic': 'زيارة الأربعين',
        'Persian': 'زیارت اربعین',
        'Kurdish': 'زیاڕەتەی  ئەربەعین',
        'Turkmen': 'Arbaýyň zyýaraty',
        'English': 'Arbaeen Visitation',
      },
    };
    return localizedTexts[key]?[selectedLanguage.name] ?? key;
  }

  String _getArabicText(String key) {
    Map<String, String> arabicTexts = {
      'imam_hussein_prayer': 'اللهم أنت ثقتي في كلّ كَرب، ورجائي في كلّ شدة، وأنت لي في كلّ أمرٍ نزل بي ثقة، وعُدّة،كم من هِمٍّ يَضْعفُ فيه الفؤاد، وتقلّ فيه الحِيلة، ويَخذُلُ فيه الصّديق، ويشمت فيه العدوّ، أنزلتُه بك وشكوتُه إليك، رغبةً مني إليك عمّن سِواك، ففرّجته وكشفته، فأنت وليُّ كل نعمةٍ، وصاحب كلّ حَسنةٍ، ومنتهى كلّ رغبة',
      'abbas_prayer': 'سَلامُ اللهِ وَسَلامُ مَلائِكَتِهِ الْمُقَرَّبِينَ وَأَنْبِيَائِهِ الْمُرْسَلِينَ ، وَعِبَادِهِ الصَّالِحِينَ وَجَمِيعِ الشُّهَداءِ وَالصِّدِّيقِينَ ، وَالزَّاكِيَاتُ الطَّيِّبَاتُ فِيمَا تَغْتَدِي وَتَرُوحُ عَلَيْكَ يَابْنَ أَمِيرِ الْمُؤْمِنِينَ ، أَشْهَدُ لَكَ بِالتَّسْلِيمِ وَالتَّصْدِيقِ وَالْوَفَاءِ وَالنَّصِيحَةِ ، لِخَلَفِ النَّبِيِّ الْمُرْسَلِ ـ صَلَّى اللهُ عَلَيْهِ وَآلِهِ ـ ، وَالسِّبْطِ الْمُنْتَجَبِ ، وَالدَّلِيلِ الْعَالِمِ ، وَالْوَصِيِّ الْمُبَلِّغِ ، وَالْمَظْلُومِ الْمُهْتَضَمِ ، فَجَزَاكَ اللهُ عَن رَّسُولِهِ وَعَنْ أَمِيرِ الْمُؤْمِنينَ وَعَنْ فَاطِمَةَ والْحَسَنِ وَالْحُسَيْنِ ـ صَلَوَاتُ اللهِ عَلَيْهِمْ ـ أَفْضَلَ الْجَزاءِ ، بِمَا صَبَرْتَ وَاحْتَسَبْتَ وَأَعَنْتَ ، فَنِعْمَ عُقْبَى الدَّارِ ، لَعَنَ اللهُ مَنْ قَتَلَكَ ، وَلَعَنَ اللهُ مَنْ جَهِلَ حَقَّكَ وَاسْتَخَفَّ بِحُرْمَتِكَ ، وَلَعَنَ اللهُ مَنْ حَالَ بَيْنَكَ وَبَيْنَ مَاءِ الْفُرَاتِ ، أَشْهَدُ أَنَّكَ قُتِلْتَ مَظْلُوماً ، وَأَنَّ اللهَ مُنْجِزٌ لَّكُم مَّا وَعَدَكُمْ ، جِئْتُكَ يَابْنَ أَمِيرِ اْلُمْؤْمِنينَ وَافِداً إِلَيْكُمْ ، وَقَلْبِي مُسَلِّمٌ لَّكُمْ وَتابِعٌ ، وَأَنَا لَكُمْ تَابِعٌ وَنُصْرَتِي لَكُم مُّعَدَّةٌ ، حَتّى يَحْكُمَ اللهُ وَهُوَ خَيْرُ الْحَاكِمِينَ ، فَمَعَكُمْ مَعَكُمْ لا مَعَ عَدُوِّكُمْ ، إِنِّي بِكُمْ وَبِإِيَابِكُمْ مِنَ الْمُؤْمِنينَ ، وَبِمَنْ خَالَفَكُمْ وَقَتَلَكُمْ مِنَ الْكَافَرِينَ ، قَتَلَ اللهُ أُمَّةً قَتَلَتْكُمْ بِالأَيْدِي وَالأَلْسُنِ',
      'journey_prayer_content': 'بسم الله الرحمن الرحيم. اللهم إني أسألك في سفري هذا البر والتقوى، ومن العمل ما ترضى. اللهم احفظني من بين يدي ومن خلفي، وبارك لي في مسيري وارزقني خيره واصرف عني شره.',
      'glorification_content': 'سبحان الله والحمد لله ولا إله إلا الله والله أكبر. سبحان الله وبحمده، سبحان الله العظيم. لا حول ولا قوة إلا بالله العلي العظيم.',
      'blessings_on_muhammad': 'اللهم صل على محمد وآل محمد، كما صليت على إبراهيم وآل إبراهيم، إنك حميد مجيد.',
      'arbaeen_prayer': 'السلام على الحسين، وعلى علي بن الحسين، وعلى أولاد الحسين، وعلى أصحاب الحسين. اللهم ارزقنا في الدنيا زيارته، وفي الآخرة شفاعته. اللهم اجعلنا من المتمسكين بولايته والمحافظين على عهده والسائرين على خطاه.',
    };
    return arabicTexts[key] ?? key;
  }
}