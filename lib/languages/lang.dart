import 'package:flutter/material.dart';

enum Language {
  Arabic,
  English,
  Persian,
  Kurdish,
  Turkmen,
}

class AppLocalizations {
  final Language language;
  AppLocalizations(this.language);
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  String get introScreenTitle1 => _getLocalizedText(
    arabic: "سجل وادخل بسهولة",
    persian: "ثبت نام و ورود آسان",
    english: "Easy Registration and Login",
    kurdish: "تۆمارکردن و چوونەژوورەوەی ئاسان",
    turkmen: "Aňsat Hasaba Alyş we Giriş",
  );

  String get introScreenBody1 => _getLocalizedText(
    arabic: "سجل معلوماتك الكاملة بسهولة\nوادخل للاستفادة من خدماتنا",
    persian: "به راحتی اطلاعات کامل خود را ثبت کنید\nو وارد شوید تا از خدمات ما بهره مند شوید",
    english: "Easily register your complete information\nand log in to benefit from our services",
    kurdish: "بە ئاسانی زانیاریە تەواوەکانت تۆمار بکە\nو بچۆ ژوورەوە بۆ سوود وەرگرتن لە خزمەتگوزاریەکانمان",
    turkmen: "Doly maglumatlaryňyzy aňsat hasaba alyň\nwe hyzmatlarymyzdan peýdalanmak üçin",
  );

  String get introScreenTitle2 => _getLocalizedText(
    arabic: "خدمات الخرائط",
    persian: "خدمات نقشه",
    english: "Map Services",
    kurdish: "خزمەتگوزاریەکانی نەخشە",
    turkmen: "Karta Hyzmatlary",
  );

  String get introScreenBody2 => _getLocalizedText(
    arabic: "استكشف المواقع الطبية القريبة\nواحصل على الاتجاهات بسهولة",
    persian: "مکان های پزشکی نزدیک را کشف کنید\nو به راحتی مسیریابی کنید",
    english: "Discover nearby medical locations\nand get directions easily",
    kurdish: "شوێنە پزیشکیە نزیکەکان بدۆزەرەوە\nو بە ئاسانی ئاراستەکان وەربگرە",
    turkmen: "Golaýdaky lukmançylyk ýerlerini açyň\nwe aňsat görkezme alyň",
  );

  String get introScreenTitle3 => _getLocalizedText(
    arabic: "خدمات التطبيق العامة",
    persian: "خدمات عمومی برنامه",
    english: "General App Services",
    kurdish: "خزمەتگوزاریە گشتیەکانی بەرنامە",
    turkmen: "Umumy Programmanyň Hyzmatlary",
  );

  String get introScreenBody3 => _getLocalizedText(
    arabic: "احصل على تقارير طبية وإرشادات\nلتحسين رحلتك الصحية",
    persian: "گزارش های پزشکی و راهنمایی دریافت کنید\nبرای بهبود سفر سلامتی شما",
    english: "Get medical reports and guidance\nto improve your health journey",
    kurdish: "راپۆرت و رێنمایی پزیشکی وەربگرە\nبۆ باشترکردنی گەشتی تەندروستیت",
    turkmen: "Lukmançylyk hasabatlaryny we görkezmelerini alyň\nsaglygyňyzy gowulandyrmak üçin",
  );

  String get skip => _getLocalizedText(
    arabic: "تخطي",
    persian: "تخطي",
    english: "Skip",
    kurdish: "تخطي",
    turkmen: "تخطي",
  );

  String get done => _getLocalizedText(
    arabic: "تم",
    persian: "تم",
    english: "Done",
    kurdish: "تم",
    turkmen: "تم",
  );
  String get translate => _getLocalizedText(
    arabic: "ترجم",
    persian: "ترجمه",
    english: "Translate",
    kurdish: "وەرگێڕان",
    turkmen: "Terjime et",
  );

  String get tapToChangeLanguage => _getLocalizedText(
    arabic: "انقر هنا لتغيير اللغة",
    persian: "برای تغییر زبان اینجا را لمس کنید",
    english: "Tap here to change the language",
    kurdish: "بۆ گۆڕینی زمان لێرە دابگرە",
    turkmen: "Dili üýtgetmek üçin şu ýere basyň",
  );
  String get languageSelection => _getLocalizedText(
    arabic: 'اختيار اللغة',
    persian: 'انتخاب زبان',
    english: 'Language Selection',
    kurdish: 'هەڵبژاردنی زمان',
    turkmen: 'Dil seçimi',
  );

  String get visitorRegistration => _getLocalizedText(
    arabic: 'تسجيل الزائر',
    persian: 'ثبت نام بازدیدکننده',
    english: 'Visitor Registration',
    kurdish: 'خواردنی سەردان',
    turkmen: 'Çişmäniň girişi',
  );

  String get signIn => _getLocalizedText(
    arabic: 'تسجيل دخول',
    persian: 'ورود',
    english: 'Sign In',
    kurdish: 'چوونەژوورەوە',
    turkmen: 'Giriş',
  );

  String get signUp => _getLocalizedText(
    arabic: 'تسجيل جديد',
    persian: 'ثبت نام',
    english: 'Sign Up',
    kurdish: 'تۆمارکردن',
    turkmen: 'Hasap aç',
  );

  String get phoneNumberVerification => _getLocalizedText(
    arabic: 'ادخل رقم الهاتف وكلمة المرور قبل البدء',
    persian: 'تأیید شماره تلفن',
    english: 'Phone Number Verification',
    kurdish: 'پشت ژمارەی مۆبایل',
    turkmen: 'Telefon belgisini tassykla',
  );

  String get phoneNumber => _getLocalizedText(
    arabic: 'رقم الهاتف',
    persian: 'شماره تلفن',
    english: 'Phone Number',
    kurdish: 'ژمارەی مۆبایل',
    turkmen: 'Telefon belgisi',
  );

  String get password => _getLocalizedText(
    arabic: 'كلمة المرور',
    persian: 'کلمه عبور',
    english: 'Password',
    kurdish: 'وشەی نهێنی',
    turkmen: 'Açar söz',
  );

  String get login => _getLocalizedText(
    arabic: 'تسجيل الدخول',
    persian: 'ورود',
    english: 'Login',
    kurdish: 'چوونەژوورەوە',
    turkmen: 'Giriş',
  );

  String get personalInformation => _getLocalizedText(
    arabic: 'المعلومات الشخصية',
    persian: 'اطلاعات شخصی',
    english: 'Personal Information',
    kurdish: 'زانیاری تایبەتی',
    turkmen: 'Şahsy maglumat',
  );

  String get firstName => _getLocalizedText(
    arabic: 'الاسم الاول',
    persian: 'نام اول',
    english: 'First Name',
    kurdish: 'ناوی یەکەم',
    turkmen: 'Birinji at',
  );

  String get secondName => _getLocalizedText(
    arabic: 'الاسم الثاني',
    persian: 'نام دوم',
    english: 'Second Name',
    kurdish: 'ناوی دووهەم',
    turkmen: 'Ikinji at',
  );

  String get thirdName => _getLocalizedText(
    arabic: 'الاسم الثالث',
    persian: 'نام سوم',
    english: 'Third Name',
    kurdish: 'ناوی سێیەم',
    turkmen: 'Üçünji at',
  );
  String get greeting => _getLocalizedText(
    arabic: "الزائر العزيز",
    persian: "بازدیدکننده عزیز",
    english: "Dear Visitor",
    kurdish: "میوانی خۆشەویست",
    turkmen: "Hormatly Myhman",
  );

  String get name => _getLocalizedText(
    arabic: "الاسم: ",
    persian: "نام: ",
    english: "Name: ",
    kurdish: "ناو: ",
    turkmen: "Ady: ",
  );

  String get number => _getLocalizedText(
    arabic: "الرقم: ",
    persian: "شماره: ",
    english: "Number: ",
    kurdish: "ژمارە: ",
    turkmen: "Belgisi: ",
  );

  String get bloodType => _getLocalizedText(
    arabic: "فصيلة الدم: ",
    persian: "گروه خونی: ",
    english: "Blood Type: ",
    kurdish: "شێوەی خوێن: ",
    turkmen: "Gan Topary: ",
  );

  String get age => _getLocalizedText(
    arabic: "العمر: ",
    persian: "سن: ",
    english: "Age: ",
    kurdish: "تەمەن: ",
    turkmen: "Ýaşy: ",
  );
  String get address => _getLocalizedText(
    arabic: 'العنوان',
    persian: 'آدرس',
    english: 'Address',
    kurdish: 'ناونیشان',
    turkmen: 'Salgy',
  );

  String get country => _getLocalizedText(
    arabic: 'البلد',
    persian: 'کشور',
    english: 'Country',
    kurdish: 'وڵات',
    turkmen: 'Ýurt',
  );

  String get province => _getLocalizedText(
    arabic: 'المحافظة',
    persian: 'استان',
    english: 'Province',
    kurdish: 'پارێزگا',
    turkmen: 'Welaýat',
  );

  String get judiciary => _getLocalizedText(
    arabic: 'القضاء',
    persian: 'دادگاه',
    english: 'Judiciary',
    kurdish: 'دادگا',
    turkmen: 'Kazyýet',
  );

  String get alley => _getLocalizedText(
    arabic: 'الزقاق',
    persian: 'کوچه',
    english: 'Alley',
    kurdish: 'کۆڵان',
    turkmen: 'Köçe',
  );

  String get house => _getLocalizedText(
    arabic: 'الدار',
    persian: 'خانه',
    english: 'House',
    kurdish: 'ماڵ',
    turkmen: 'Öý',
  );

  String get gender => _getLocalizedText(
    arabic: 'الجنس',
    persian: 'جنس',
    english: 'Gender',
    kurdish: 'رەگەز',
    turkmen: 'Jyns',
  );

  String get male => _getLocalizedText(
    arabic: 'ذكر',
    persian: 'نر',
    english: 'Male',
    kurdish: 'نر',
    turkmen: 'Erkek',
  );

  String get female => _getLocalizedText(
    arabic: 'انثى',
    persian: 'ژنان',
    english: 'Female',
    kurdish: 'ژن',
    turkmen: 'Aýal',
  );

  String get dateOfBirth => _getLocalizedText(
    arabic: 'تاريخ الميلاد',
    persian: 'تاریخ تولد',
    english: 'Date of Birth',
    kurdish: 'رێکەوتی لەدایکبوون',
    turkmen: 'Doglan senesi',
  );

  String get day => _getLocalizedText(
    arabic: 'اليوم',
    persian: 'روز',
    english: 'Day',
    kurdish: 'ڕۆژ',
    turkmen: 'Gün',
  );

  String get month => _getLocalizedText(
    arabic: 'الشهر',
    persian: 'ماه',
    english: 'Month',
    kurdish: 'مانگ',
    turkmen: 'Aý',
  );

  String get year => _getLocalizedText(
    arabic: 'السنة',
    persian: 'سال',
    english: 'Year',
    kurdish: 'ساڵ',
    turkmen: 'Ýyl',
  );

  String get medicalInformation => _getLocalizedText(
    arabic: 'المعلومات الطبية',
    persian: 'اطلاعات پزشکی',
    english: 'Medical Information',
    kurdish: 'زانیاری پزیشکی',
    turkmen: 'Lukmançylyk maglumatlary',
  );
  //
  // String get bloodType => _getLocalizedText(
  //   arabic: 'نوع الدم',
  //   persian: 'گروه خونی',
  //   english: 'Blood Type',
  //   kurdish: 'جۆری خوون',
  //   turkmen: 'Gan topary',
  // );

  String get chronicDiseases => _getLocalizedText(
    arabic: 'الأمراض المزمنة',
    persian: 'بیماری‌های مزمن',
    english: 'Chronic Diseases',
    kurdish: 'نەخۆشیە مزمنەکان',
    turkmen: 'Dowamly keseller',
  );

  String get allergies => _getLocalizedText(
    arabic: 'الحساسية',
    persian: 'آلرژی‌ها',
    english: 'Allergies',
    kurdish: 'تێکەڵەکان',
    turkmen: 'Allergiýalar',
  );
  String get accountInformation => _getLocalizedText(
    arabic: 'معلومات الحساب',
    persian: 'اطلاعات حساب',
    english: 'Account Information',
    kurdish: 'زانیاری هەژمار',
    turkmen: 'Hasap maglumatlary',
  );

  String get username => _getLocalizedText(
    arabic: 'اسم المستخدم',
    persian: 'نام کاربری',
    english: 'Username',
    kurdish: 'ناوی بەکارهێنەر',
    turkmen: 'Ulanyjy ady',
  );

  String get email => _getLocalizedText(
    arabic: 'البريد الإلكتروني',
    persian: 'ایمیل',
    english: 'Email',
    kurdish: 'ئیمەیل',
    turkmen: 'E-poçta',
  );


  String get phoneNumber8 => _getLocalizedText(
    arabic: 'رقم الهاتف',
    persian: 'شماره تلفن',
    english: 'Phone Number',
    kurdish: 'ژمارەی تەلەفۆن',
    turkmen: 'Telefon belgisi',
  );

  String get pleaseEnterPhoneNumber => _getLocalizedText(
    arabic: 'يرجى إدخال رقم الهاتف',
    persian: 'لطفاً شماره تلفن را وارد کنید',
    english: 'Please enter a phone number',
    kurdish: 'تکایە ژمارەی تەلەفۆن داخڵ بکە',
    turkmen: 'Telefon belgiňizi giriziň',
  );

  String get emergencyContact => _getLocalizedText(
    arabic: "جهة الاتصال الطارئة",
    persian: "پەیوەندیدەری بەرەوپێش",
    english: "Emergency Contact",
    kurdish: "پەیوەندیدەری بەرەوپێش",
    turkmen: "Ýaňyşlygyň aragatnaşygy",
  );

  String get emergencyContactName => _getLocalizedText(
    arabic: "اسم جهة الاتصال الطارئة",
    persian: "نام فرد اضطراری",
    english: "Emergency Contact Name",
    kurdish: "ناوی پەیوندیدەری بەرەوپێش",
    turkmen: "Ýaňyşlygyň aragatnaşygyň ady",
  );

  String get connection => _getLocalizedText(
    arabic: "صلة القرابة",
    persian: "نسبت",
    english: "Connection",
    kurdish: "پەیوەندی",
    turkmen: "Baglanyşyk",
  );

  String get father => _getLocalizedText(
    arabic: "أب",
    persian: "پدر",
    english: "Father",
    kurdish: "باوک",
    turkmen: "Ata",
  );

  String get mother => _getLocalizedText(
    arabic: "أم",
    persian: "مادر",
    english: "Mother",
    kurdish: "دایک",
    turkmen: "Ene",
  );

  String get brother => _getLocalizedText(
    arabic: "أخ",
    persian: "برادر",
    english: "Brother",
    kurdish: "برا",
    turkmen: "Doganyňyz",
  );

  String get sister => _getLocalizedText(
    arabic: "أخت",
    persian: "خواهر",
    english: "Sister",
    kurdish: "خوشک",
    turkmen: "Uýadyňyz",
  );

  String get other => _getLocalizedText(
    arabic: "أخرى",
    persian: "دیگر",
    english: "Other",
    kurdish: "تر",
    turkmen: "Beýlekiler",
  );
  String get continuousTreatment => _getLocalizedText(
    arabic: "العلاج المستمر",
    persian: "درمان مداوم",
    english: "Continuous Treatment",
    kurdish: "بەرەوپێش",
    turkmen: "Daimi bej",
  );

  String get examsAndMedications => _getLocalizedText(
    arabic: "الفحوصات والادوية التي تلقاها الزائر",
    persian: "آزمون‌ها و داروهایی که بازدیدکننده دریافت کرده",
    english: "Exams and medications received by the visitor",
    kurdish: "Test û dermanên ku serdana kiryar hatibû",
    turkmen: "Gözden geçirilen we dermanlar",
  );

  String get completeMedicalCondition => _getLocalizedText(
    arabic: "الحالة المرضية الكاملة",
    persian: "وضعیت کامل پزشکی",
    english: "Complete Medical Condition",
    kurdish: "حالت پڕەی تیبەتی",
    turkmen: "Dolandyryş ýagdaýy",
  );

  String get medicalReport => _getLocalizedText(
    arabic: "تقريره الطبي",
    persian: "گزارش پزشکی",
    english: "Medical Report",
    kurdish: "Raporê teyrana",
    turkmen: "Mediki rapor",
  );

  String get guideToMedicalUnits => _getLocalizedText(
    arabic: "دليلك الى المفارز الطبية",
    persian: "راهنمایی به واحدهای پزشکی",
    english: "Guide to Medical Units",
    kurdish: "ڕێبەری بۆ ئەنجامی پزیشکی",
    turkmen: "Baglanyşykly lukmançylyk nokatlary",
  );

  String get map => _getLocalizedText(
    arabic: "الخريطة",
    persian: "نقشه",
    english: "Map",
    kurdish: "Nexşe",
    turkmen: "Karta",
  );

  String get religiousAspect => _getLocalizedText(
    arabic: "الجانب الديني",
    persian: "جنبه مذهبی",
    english: "Religious Aspect",
    kurdish: "لایەنی ئایینی",
    turkmen: "Dini tarap",
  );

  String get prayersAndGlorifications => _getLocalizedText(
    arabic: "الأدعية والتسبيحات خلال المشي",
    persian: "دعاها و تسبیحات هنگام راه رفتن",
    english: "Prayers and glorifications during walking",
    kurdish: "نوێژ و ستایشەکان لە کاتی ڕۆیشتندا",
    turkmen: "Ýöremek wagtynda dogalar we öwgüler",
  );

  String get noDataAvailable => _getLocalizedText(
    arabic: "لا توجد بيانات متاحة",
    persian: "داده ای در دسترس نیست",
    english: "No data available",
    kurdish: "هیچ زانیاریەک بەردەست نییە",
    turkmen: "Maglumat ýok",
  );

  String get years => _getLocalizedText(
    arabic: "سنوات",
    persian: "سال",
    english: "years",
    kurdish: "ساڵ",
    turkmen: "ýyl",
  );

  String get fullName => _getLocalizedText(
    arabic: "الاسم الكامل",
    persian: "نام کامل",
    english: "Full Name",
    kurdish: "ناوی تەواو",
    turkmen: "Doly ady",
  );

  String get none => _getLocalizedText(
    arabic: "لا شيء",
    persian: "هیچ",
    english: "None",
    kurdish: "هیچ",
    turkmen: "Hiç",
  );

  String get emergencyContactNumber => _getLocalizedText(
    arabic: "رقم الاتصال في حالات الطوارئ",
    persian: "شماره تماس اضطراری",
    english: "Emergency Contact Number",
    kurdish: "ژمارەی پەیوەندی لە کاتی لەناکاو",
    turkmen: "Gyssagly ýagdaýda habarlaşmaly belgisi",
  );

  String get emergencyContactRelationship => _getLocalizedText(
    arabic: "علاقة جهة الاتصال في حالات الطوارئ",
    persian: "نسبت تماس اضطراری",
    english: "Emergency Contact Relationship",
    kurdish: "پەیوەندی کەسی پەیوەندی لە کاتی لەناکاو",
    turkmen: "Gyssagly ýagdaýda habarlaşmaly adamyň gatnaşygy",
  );

  String get randomCode => _getLocalizedText(
    arabic: "رمز عشوائي",
    persian: "کد تصادفی",
    english: "Random Code",
    kurdish: "کۆدی هەڕەمەکی",
    turkmen: "Tötänleýin kod",
  );

  String get editProfile => _getLocalizedText(
    arabic: "تعديل الملف الشخصي",
    persian: "ویرایش نمایه",
    english: "Edit Profile",
    kurdish: "دەستکاری پڕۆفایل",
    turkmen: "Profili üýtgetmek",
  );

  String get settings => _getLocalizedText(
    arabic: "الإعدادات",
    persian: "تنظیمات",
    english: "Settings",
    kurdish: "ڕێکخستنەکان",
    turkmen: "Sazlamalar",
  );

  String get friend => _getLocalizedText(
    arabic: "صديق",
    persian: "دوست",
    english: "Friend",
    kurdish: "هاوڕێ",
    turkmen: "Dost",
  );

  String get unknown => _getLocalizedText(
    arabic: "غير معروف",
    persian: "ناشناخته",
    english: "Unknown",
    kurdish: "نەزانراو",
    turkmen: "Näbelli",
  );
  String get saveChanges => _getLocalizedText(
    arabic: 'حفظ التغييرات',
    persian: 'ذخیره تغییرات',
    english: 'Save Changes',
    kurdish: 'گۆڕانکاریەکان پاشەکەوت بکە',
    turkmen: 'Üýtgeşmeleri ýatda saklaň',
  );

  String get profileUpdateSuccess => _getLocalizedText(
    arabic: 'تم تحديث الملف الشخصي بنجاح',
    persian: 'پروفایل با موفقیت به‌روزرسانی شد',
    english: 'Profile updated successfully',
    kurdish: 'پڕۆفایل بە سەرکەوتوویی نوێ کرایەوە',
    turkmen: 'Profil üstünlikli täzelendi',
  );
  String get birthYear => _getLocalizedText(
    arabic: 'سنة الميلاد',
    persian: 'سال تولد',
    english: 'Birth Year',
    kurdish: 'ساڵی لەدایکبوون',
    turkmen: 'Doglan ýyly',
  );

  String get district => _getLocalizedText(
    arabic: 'المنطقة',
    persian: 'ناحیه',
    english: 'District',
    kurdish: 'ناوچە',
    turkmen: 'Etrap',
  );

  String get emergencyContactAddress => _getLocalizedText(
    arabic: 'عنوان جهة الاتصال في حالات الطوارئ',
    persian: 'آدرس تماس اضطراری',
    english: 'Emergency Contact Address',
    kurdish: 'ناونیشانی پەیوەندی لەکاتی لەناکاو',
    turkmen: 'Gyssagly ýagdaýda habarlaşmaly salgy',
  );

  String get emergencyContactCountry => _getLocalizedText(
    arabic: 'بلد جهة الاتصال في حالات الطوارئ',
    persian: 'کشور تماس اضطراری',
    english: 'Emergency Contact Country',
    kurdish: 'وڵاتی پەیوەندی لەکاتی لەناکاو',
    turkmen: 'Gyssagly ýagdaýda habarlaşmaly ýurt',
  );

  String get emergencyContactProvince => _getLocalizedText(
    arabic: 'محافظة جهة الاتصال في حالات الطوارئ',
    persian: 'استان تماس اضطراری',
    english: 'Emergency Contact Province',
    kurdish: 'پارێزگای پەیوەندی لەکاتی لەناکاو',
    turkmen: 'Gyssagly ýagdaýda habarlaşmaly welaýat',
  );

  String get emergencyContactDistrict => _getLocalizedText(
    arabic: 'منطقة جهة الاتصال في حالات الطوارئ',
    persian: 'ناحیه تماس اضطراری',
    english: 'Emergency Contact District',
    kurdish: 'ناوچەی پەیوەندی لەکاتی لەناکاو',
    turkmen: 'Gyssagly ýagdaýda habarlaşmaly etrap',
  );

  String get createdAt => _getLocalizedText(
    arabic: 'تم الإنشاء في',
    persian: 'ایجاد شده در',
    english: 'Created At',
    kurdish: 'دروستکراوە لە',
    turkmen: 'Döredilen wagty',
  );

  String get modifiedAt => _getLocalizedText(
    arabic: 'تم التعديل في',
    persian: 'اصلاح شده در',
    english: 'Modified At',
    kurdish: 'دەستکاری کراوە لە',
    turkmen: 'Üýtgedilen wagty',
  );

  String get profileUpdateFailed => _getLocalizedText(
    arabic: 'فشل تحديث الملف الشخصي',
    persian: 'به‌روزرسانی پروفایل ناموفق بود',
    english: 'Failed to update profile',
    kurdish: 'نوێکردنەوەی پڕۆفایل سەرکەوتوو نەبوو',
    turkmen: 'Profili täzelemek başartmady',
  );


  String _getLocalizedText({
    required String arabic,
    required String persian,
    required String english,
    required String kurdish,
    required String turkmen,
  }) {
    switch (language) {
      case Language.Arabic:
        return arabic;
      case Language.Persian:
        return persian;
      case Language.English:
        return english;
      case Language.Kurdish:
        return kurdish;
      case Language.Turkmen:
        return turkmen;
    }
  }
}
