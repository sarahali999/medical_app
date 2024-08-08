enum Language { English, Arabic, Persian, Kurdish, Turkmen }

class LanguageService {
  static String getText(String key, Language language) {
    final translations = {
      'personalInfo': {
        Language.English: 'Personal Information',
        Language.Arabic: 'البيانات الشخصية',
        Language.Persian: 'اطلاعات شخصی',
        Language.Kurdish: 'زانیاری کەسی',
        Language.Turkmen: 'Şahsy maglumatlar',
      },
      'firstName': {
        Language.English: 'First Name',
        Language.Arabic: 'الاسم الأول',
        Language.Persian: 'نام اول',
        Language.Kurdish: 'ناوی یەکەم',
        Language.Turkmen: 'Adyňyz',
      },
      'secondName': {
        Language.English: 'Second Name',
        Language.Arabic: 'الاسم الثاني',
        Language.Persian: 'نام دوم',
        Language.Kurdish: 'ناوی دووهەم',
        Language.Turkmen: 'Ikinji ady',
      },
      'thirdName': {
        Language.English: 'Third Name',
        Language.Arabic: 'الاسم الثالث',
        Language.Persian: 'نام سوم',
        Language.Kurdish: 'ناوی سێیەم',
        Language.Turkmen: 'Üçünji ady',
      },
      'dateOfBirth': {
        Language.English: 'Date of Birth',
        Language.Arabic: 'تاريخ الميلاد',
        Language.Persian: 'تاریخ تولد',
        Language.Kurdish: 'رێکەوتی لەدایکبوون',
        Language.Turkmen: 'Doğulýan senesi',
      },
      'gender': {
        Language.English: 'Gender',
        Language.Arabic: 'الجنس',
        Language.Persian: 'جنس',
        Language.Kurdish: 'رەگەز',
        Language.Turkmen: 'Jyns',
      },
      'male': {
        Language.English: 'Male',
        Language.Arabic: 'ذكر',
        Language.Persian: 'مرد',
        Language.Kurdish: 'پیاو',
        Language.Turkmen: 'Erkek',
      },
      'female': {
        Language.English: 'Female',
        Language.Arabic: 'أنثى',
        Language.Persian: 'زن',
        Language.Kurdish: 'ژن',
        Language.Turkmen: 'Aýal',
      },
      'phoneNumber': {
        Language.English: 'Phone Number',
        Language.Arabic: 'رقم الهاتف',
        Language.Persian: 'شماره تلفن',
        Language.Kurdish: 'ژمارەی تەلەفۆن',
        Language.Turkmen: 'Telefon belgisi',
      },
      'medicalInfo': {
        Language.English: 'Medical Information',
        Language.Arabic: 'المعلومات الطبية',
        Language.Persian: 'اطلاعات پزشکی',
        Language.Kurdish: 'زانیاری پزیشکی',
        Language.Turkmen: 'Baglanyşyk maglumatlary',
      },
      'bloodType': {
        Language.English: 'Blood Type',
        Language.Arabic: 'فصيلة الدم',
        Language.Persian: 'گروه خون',
        Language.Kurdish: 'جۆری خوێن',
        Language.Turkmen: 'Aýak görnüşi',
      },
      'chronicDiseases': {
        Language.English: 'Chronic Diseases',
        Language.Arabic: 'الأمراض المزمنة',
        Language.Persian: 'بیماری‌های مزمن',
        Language.Kurdish: 'نەخۆشییە درێژخایەنەکان',
        Language.Turkmen: 'Hroniki keseller',
      },
      'allergies': {
        Language.English: 'Allergies',
        Language.Arabic: 'الحساسية',
        Language.Persian: 'آلرژی‌ها',
        Language.Kurdish: 'هەستیاری',
        Language.Turkmen: 'Alergiýalar',
      },
      'emergencyContact': {
        Language.English: 'Emergency Contact',
        Language.Arabic: 'جهة الاتصال في حالات الطوارئ',
        Language.Persian: 'تماس اضطراری',
        Language.Kurdish: 'پەیوەندی کتوپڕ',
        Language.Turkmen: 'Gözegçilik baglanyşygy',
      },
      'emergencyContactName': {
        Language.English: 'Emergency Contact Name',
        Language.Arabic: 'اسم جهة الاتصال في حالات الطوارئ',
        Language.Persian: 'نام تماس اضطراری',
        Language.Kurdish: 'ناوی پەیوەندی کتوپڕ',
        Language.Turkmen: 'Gözegçilik baglanyşygynyň ady',
      },
      'relationship': {
        Language.English: 'Relationship',
        Language.Arabic: 'العلاقة',
        Language.Persian: 'نسبت',
        Language.Kurdish: 'پەیوەندی',
        Language.Turkmen: 'Baglanyşyk',
      },
      'done': {
        Language.English: 'Done',
        Language.Arabic: 'تم',
        Language.Persian: 'انجام شد',
        Language.Kurdish: 'تەواو',
        Language.Turkmen: 'Tamam',
      },
      // Add more translations as needed
    };

    return translations[key]?[language] ?? key;
  }
}
