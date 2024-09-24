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
                context: context,
              ),
              _buildSection(
                title: _getLocalizedText('abbas_remembrance'),
                content: _getArabicText('abbas_prayer'),
                icon: Icons.water_drop,
                context: context,
              ),
              _buildSection(
                title: _getLocalizedText('journey_prayers'),
                content: _getArabicText('journey_prayer_content'),
                icon: Icons.route,
                context: context,
              ),
              _buildSection(
                title: _getLocalizedText('recommended_glorifications'),
                content: _getArabicText('glorification_content'),
                icon: Icons.repeat,
                context: context,
              ),
              _buildSection(
                title: _getLocalizedText('blessings_on_muhammad'),
                content: _getArabicText('blessings_on_muhammad'),
                icon: Icons.brightness_5,
                context: context,
              ),
              _buildSection(
                title: _getLocalizedText('arbaeen_visitation'),
                content: _getArabicText('arbaeen_prayer'),
                icon: Icons.place,
                context: context,
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
    required BuildContext context,
  }) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        onTap: () => _showContentDialog(context, title, content),
      ),
    );
  }

  void _showContentDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Text(content),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
      'imam_hussein_prayer': '''
في رحاب ادعية الامام الحسين
لقد تميّز تراث أهل البيت (عليهم السّلام) بظاهرة الدعاء تميّزاً فريداً في جانبي الكمّ والكيف معاً.

فالاهتمام بالدعاء في جميع الحالات والظروف التي يمرّ بها الإنسان في الحياة، كما قال تعالى:﴿ قُلْ مَا يَعْبَأُ بِكُمْ رَبِّي لَوْلَا دُعَاؤُكُمْ ... ﴾ 1، هو المظهر الذي ميّز سلوك أهل البيت (عليهم السّلام) عمّن سواهم، وعلى ذلك ساروا في تربيتهم لشيعتهم.
والمسلمون بشكل عام يلمسون هذه الظاهرة بوضوح في موسم الحجّ وغيره من مواسم العبادة عند أتباع أهل البيت (عليهم السّلام) وشيعتهم.
وتفرّدت أدعية أهل البيت (عليهم السّلام) في المحتوى والمقاصد، والمعاني التي اشتملت عليها أدعيتهم ؛ فإنّها تُفصح بوضوح عن البون الشاسع بينهم وبين غيرهم. فأين الثرى وأين الثريّا؟
وتدلّنا بعض النصوص المأثورة عن الإمام الحسين (عليه السّلام) على سرّ هذا الاهتمام البليغ منهم بالدعاء.

قال (عليه السّلام): " أعجز النّاس مَنْ عجز عن الدعاء، وأبخل النّاس مَنْ بخل بالسّلام"2.
وجاء عنه أنّه كان يدعو في قنوت الوتر بالدعاء الذي علّمه رسول الله (صلّى الله عليه وآله) وهو: " اللهمّ إنّك تَرى ولا تُرى، وأنت بالمنظر الأعلى، وإنّ إليك الرجعى، وإنّ لك الآخرة والاُولى. اللهمّ إنّا نعوذ بك من أن نَذِلّ ونخزى"3.
من الأدعية القصيرة المأثورة عنه قوله (عليه السّلام): " اللهمّ لا تستدرِجني بالإحسانِ، ولا تؤدِّبني بالبلاء"4. وقال في معنى الاستدراج: " الاستدراج من الله لعبده أن يُسبغ عليه النِّعَمَ ويَسْلُبَه الشُكرَ"5.
ومن أدعيته في قنوته: " اللهمّ مَنْ آوى إلى مأوى فأنتَ مأوايَ، ومَنْ لجأ إلى مَلجَأ فأنتَ مَلجايَ. اللهمّ صلّ على محمّد وآلِ محمّد، واسمع ندائي، وأجب دُعائي، واجعل مآبي عندك ومثوايَ، واحرُسني في بَلواي من افتتانِ الامتحان، ولُمَّةِ الشّيطانِ بعظمتك التي لا يشوبُها وَلَعُ نفس بِتَفتين، ولا واردُ طيف بتظنين، ولا يلُمُّ بها فَرَجٌ حَبَتْ، وأجرعني شُربًا مَرَارَ الشِّدَّة، مَحْبوسًا مُوَاسِبًا رَامِيًا، واجعل ختامَ أمرنا بالآخرة أفضلُ من سابقهِ"6.
ومن الأدعية الواردة عنه (عليه السّلام) قوله (عليه السّلام): " اللهمّ ما عبدناك حتّى أقمنا الدّين، وما استغفَرناك حتّى نسينا الذّنبَ"7.
''',
      'abbas_prayer': '''
دعاء يوم العباس (عليه السلام)
قال عبد الله بن عطاء: قال أبو عبد الله (عليه السلام): " من أراد أن يطلب حاجة فليقرأ هذا الدعاء في أي وقت شاء، فيُعطى حاجته: اللهمّ بحقّ أمير المؤمنين (عليه السلام) وبحقّ العباس بن علي (عليه السلام) وبحقّ جميع الأئمة الطاهرين من أهل بيت نبيك محمد (صلّى الله عليه وآله)، وبحقّ جميع الأنبياء والصالحين، وبحقّ المرسلين الذين بعثتهم بالإسلام، وبحقّ محمد (صلّى الله عليه وآله) الذي بعثته بالحق، وبحقّ العباس الذي لم يزل مع وليك، وبحقّ ذريته الطاهرين.
أعوذ بكلمات الله التامات من شر ما خلق، من شرّ ما أنزلت من السماء، ومن شرّ ما صعد من الأرض، ومن شرّ ما يُدَبِّر من غيبياته، ومن شرّ ما يُعْلَم من شياطين الإنس والجنّ، من شرّ ما يُوَفَّق عليه.
اللهمّ آمين، اللهمّ آمين، اللهمّ آمين، فاغفر لي وارحمني، إنك أنت الغفور الرحيم"''',
      'journey_prayer_content': '''
دعاء السفر: 
قال رسول الله (صلى الله عليه وآله): " من قال عند ركوب دابته: بسم الله، توكلت على الله، ولا حول ولا قوة إلا بالله، فإنما يحمد الله تعالى، ويقال له: أجزأتك، وتوفيقك لا يكون إلا في الجنة".

دعاء السفر: 
اللهمّ اجعل رحلتي مباركة، ورفيقي خيرَ رفيق، وكن لي طيبًا، فإنك أعلم من أكون، والرحمن بعبادك أقربُ، فاجعل طريقي إلى منزلِ السلامةِ.
تستحضر النصوص المأثورة عن النبي (صلى الله عليه وآله) قضاء الحوائج والأمن من كل سوء، وتكون الدعوة مقبولة بإذن الله تعالى"''',
      'glorification_content': '''
الغوراة والتسبيحات الموصى بها: 
قال رسول الله (صلى الله عليه وآله): "من قال: سبحان الله والحمد لله ولا إله إلا الله والله أكبر، فقد ذكر الله تعالى. ومن قال: سبحان الله وبحمده، غُفِرَ له ذنبه وإن كان مثل زبد البحر".

وقال الإمام الصادق (عليه السلام): " من أكثر من ذكر الله تعالى، فله من الأجر ما لا يعلم ثوابه إلا الله تعالى".

وتستحضر النصوص المأثورة عن النبي (صلى الله عليه وآله) في التسبيحات وتأتي بها لتجعل الدعاء أفضل وأكثر قبولا"''',
      'blessings_on_muhammad': '''
صلوات على محمد وآل محمد: 
قال رسول الله (صلى الله عليه وآله): " من صلّى عليّ صلاةً واحدةً، صلّى الله عليه بها عشرة صلوات".

وقال الإمام الصادق (عليه السلام): " من صلى على محمد وآل محمد، صلّى الله عليه بهما، وأعطى بكل حرف عشر حسنات".

واستحضر دعاء اللهم صل على محمد وآل محمد من النصوص المأثورة، وحاول تكرارها في يومك لزيادة البركة في عملك وعمر لك".
''',
      'arbaeen_prayer': '''
زيارة الأربعين: 
قال الإمام الصادق (عليه السلام): "من زار الأربعين، فله الجنة".

وقال الإمام الكاظم (عليه السلام): "من زار الأربعين، زارني".

وتستحضر النصوص المأثورة عن أهل البيت (عليهم السّلام) في زيارة الأربعين وتعظيم هذه الزيارة وصلاة الظهر والعصر بعد زيارة أربعين للتركيز على تعظيم هذه المناسبة"''',
    };
    return arabicTexts[key] ?? key;
  }
}
