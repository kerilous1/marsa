// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'مَرسى';

  @override
  String get slogan => 'Capture. Route. Keep. — More than just sharing';

  @override
  String get catDocs => 'ورق رسمي';

  @override
  String get catDocsSub => 'بطاقات، رخص، شهادات';

  @override
  String get catReadLater => 'للقراءة والمشاهدة';

  @override
  String get catReadLaterSub => 'مقالات، بوستات، روابط';

  @override
  String get catQuickNotes => 'ملاحظات وأفكار';

  @override
  String get catQuickNotesSub => 'نصوص، حسابات، كودات';

  @override
  String get catTempVault => 'مخزن مؤقت';

  @override
  String get catTempVaultSub => 'حذف تلقائي بعد 72 ساعة';

  @override
  String get copyNationalId => 'نسخ الرقم القومي';

  @override
  String get nationalIdCopied => 'تم نسخ الرقم القومي بنجاح';

  @override
  String get searchPlaceholder => 'ابحث في المستندات، الروابط، والملاحظات...';

  @override
  String get saving => 'جارٍ الحفظ...';

  @override
  String get savedSuccessfully => 'تم الحفظ بنجاح';

  @override
  String get saveFailed => 'فشل الحفظ، حاول مجدداً';

  @override
  String get requiresReview => 'يتطلب مراجعة';

  @override
  String get delete => 'حذف';

  @override
  String get share => 'مشاركة';

  @override
  String get moveCategory => 'نقل لتصنيف آخر';

  @override
  String get emptyVaultTitle => 'المخزن فارغ حالياً';

  @override
  String get emptyVaultSubtitle => 'شارك أي محتوى من أي تطبيق لتجده هنا فوراً';

  @override
  String get onboarding1Title => 'محادثتك مع نفسك انتهت هنا';

  @override
  String get onboarding1Desc =>
      'لا مزيد من إرسال البطاقات والروابط والملاحظات لنفسك على واتساب لتضيع في زحام الرسائل.';

  @override
  String get onboarding2Title => 'شارك من أي مكان بنقرة واحدة';

  @override
  String get onboarding2Desc =>
      'من فيسبوك، إنستجرام، المتصفح، أو المعرض.. نافذة مَرسى تطفو فوق تطبيقك وتفرز محتواك في لمح البصر دون مقاطعة تدفق عملك.';

  @override
  String get onboarding3Title => 'محلي 100% وآمن على جهازك';

  @override
  String get onboarding3Desc =>
      'صفر تسريبات سحابية، صفر خوادم وسيطة. ملفاتك وسجلاتك محفوظة ومعزولة محلياً في مساحة جهازك الخاصة ومحمية ببصمة إصبعك أو وجهك.';

  @override
  String get getStarted => 'ابدأ تجربتك الآمنة';

  @override
  String get skip => 'تخطي';

  @override
  String get next => 'التالي';

  @override
  String get vaultLocked => 'الخزنة مقفلة';

  @override
  String get vaultLockedSubtitle =>
      'يرجى التحقق من هويتك لفتح خزنتك المحلية المشفرة';

  @override
  String get unlockWithBiometrics => 'فتح باستخدام البصمة';

  @override
  String get usePinFallback => 'استخدام رمز PIN';

  @override
  String get authFailed => 'فشل التحقق، يرجى المحاولة مجدداً';

  @override
  String get manageCategories => 'إدارة الخزائن والتصنيفات';

  @override
  String get addCategory => 'إضافة تصنيف جديد';

  @override
  String get editCategory => 'تعديل التصنيف';

  @override
  String get deleteCategory => 'حذف التصنيف';

  @override
  String get categoryNameAr => 'اسم التصنيف (عربي)';

  @override
  String get categoryNameEn => 'اسم التصنيف (إنجليزي)';

  @override
  String get selectIcon => 'اختر الأيقونة';

  @override
  String get selectColor => 'اختر اللون المميز';

  @override
  String get cannotDeleteSystemCategory =>
      'لا يمكن حذف التصنيفات الأساسية للنظام';

  @override
  String get securitySettings => 'إعدادات الأمان والقفل';

  @override
  String get enableBiometrics => 'تفعيل القفل البيومتري';

  @override
  String get autoLockImmediate => 'قفل فوري بمجرد مغادرة التطبيق';

  @override
  String get save => 'حفظ';

  @override
  String get cancel => 'إلغاء';

  @override
  String get confirmDelete => 'هل أنت متأكد من رغبتك في حذف هذا التصنيف؟';

  @override
  String get systemCategoryBadge => 'نظامي';

  @override
  String get autoPurgeBadge => 'حذف تلقائي (72 ساعة)';

  @override
  String get linkCopiedSuccessfully => 'تم نسخ الرابط بنجاح';

  @override
  String get couldNotLaunchUrl => 'تعذر فتح الرابط';

  @override
  String deleteCategoryCascadeWarning(int count) {
    return 'هذا التصنيف يحتوي على $count عنصر(اً). ماذا تريد أن تفعل بمحتواه؟';
  }

  @override
  String get moveToTempVault => 'نقل إلى المخزن المؤقت (حماية 72 ساعة)';

  @override
  String get deleteAllItems => 'حذف شامل للتصنيف وجميع محتوياته';

  @override
  String get categoryDeleted => 'تم حذف التصنيف بنجاح';

  @override
  String get categoryMigrated => 'تم ترحيل العناصر وحذف التصنيف بنجاح';

  @override
  String get noCategoriesTitle => 'لا توجد خزائن حالياً';

  @override
  String get noCategoriesSubtitle =>
      'أنشئ خزانتك الأولى أو اختر من الاقتراحات السريعة أدناه.';

  @override
  String get createFirstCategory => 'إنشاء خزانة جديدة';

  @override
  String get quickSuggestions => 'اقتراحات سريعة';

  @override
  String get tabVaults => 'الخزائن';

  @override
  String get tabSearch => 'البحث';

  @override
  String get tabSettings => 'الإعدادات';

  @override
  String get permissionsPromptTitle => 'أذونات مَرسى لحماية بياناتك';

  @override
  String get permissionsPromptDesc =>
      'مَرسى يعمل محلياً 100% بدون أي خوادم سحابية. هذه الأذونات ضرورية حصراً داخل جهازك.';

  @override
  String get continueAction => 'متابعة';

  @override
  String get enablePinLock => 'تفعيل القفل برمز PIN';

  @override
  String get setPinCode => 'تعيين رمز PIN';

  @override
  String get changePinCode => 'تغيير رمز PIN';

  @override
  String get enterPinToUnlock => 'أدخل رمز PIN لفتح الخزنة';

  @override
  String get enterNewPin => 'أدخل رمز PIN المكون من 4 أرقام';

  @override
  String get confirmPin => 'تأكيد رمز PIN';

  @override
  String get pinMismatch => 'رمزا PIN غير متطابقين';

  @override
  String get incorrectPin => 'رمز PIN غير صحيح، حاول ثانية';

  @override
  String get pinSetSuccess => 'تم تعيين رمز PIN بنجاح';

  @override
  String get quickCaptureTitle => 'إضافة سريعة';

  @override
  String get quickCaptureHint => 'ألصق رابطاً أو اكتب ملاحظة...';

  @override
  String get welcomeSubtitle => 'خزنتك المحلية الآمنة على هاتفك';

  @override
  String get unlock => 'إلغاء القفل';

  @override
  String get categoryNameHint => 'اسم الخزانة';

  @override
  String get tourNext => 'التالي';

  @override
  String get tourSkip => 'تخطي';

  @override
  String get tourFinish => 'ابدأ الآن';

  @override
  String tourStepCounter(int current, int total) {
    return 'الخطوة $current من $total';
  }

  @override
  String get tourStepSearchTitle => 'البحث الفوري الشامل';

  @override
  String get tourStepSearchDesc =>
      'ابحث بلمح البصر في كافة عناوينك، نصوصك، وروابطك المخزنة عبر محرك FTS5 فائق السرعة.';

  @override
  String get tourStepVaultsTitle => 'خزائنك والتصنيفات الذكية';

  @override
  String get tourStepVaultsDesc =>
      'تنقل بين أقسامك بالسحب، حيث يتم فرز الروابط، الصور، المستندات، والملاحظات تلقائياً.';

  @override
  String get tourStepLinksTitle => 'تفاعل ذكي وسريع مع الكروت';

  @override
  String get tourStepLinksDesc =>
      'انقر على الكارت لعرض التفاصيل وفتح الروابط، أو اضغط مطولاً للخيارات السريعة كالنسخ والمشاركة.';

  @override
  String get tourStepFabTitle => 'التقاط فوري من الداخل (+)';

  @override
  String get tourStepFabDesc =>
      'سجل ملاحظة سريعة أو ألصق رابطاً أو احفظ ملفاً في أي وقت بنصف ثانية.';

  @override
  String get tourStepNavTitle => 'شريط التنقل الزجاجي';

  @override
  String get tourStepNavDesc =>
      'تنقل بمرونة بين خزينتك الرئيسية، البحث الشامل، والإعدادات المتقدمة.';

  @override
  String get tourStepShareTitle => 'القوة الحقيقية: المشاركة الخارجية';

  @override
  String get tourStepShareDesc =>
      'شارك أي رابط أو ملف من أي تطبيق آخر (واتساب، متصفح..) إلى مَرسى ليُحفظ فوراً في الخلفية دون فتح التطبيق!';

  @override
  String get tourStepSettingsTitle => 'الإعدادات والخصوصية المطلقة';

  @override
  String get tourStepSettingsDesc =>
      'خصص المظهر واللغة، واطلع على سياسة الخصوصية المحلية 100% الخالية من أي تتبع أو خوادم.';

  @override
  String get settingsTourTile => 'جولة تعريفية في التطبيق';

  @override
  String get settingsTourTileDesc =>
      'تعلم كيفية استخدام مَرسى وأهم اختصاراته ومميزاته';

  @override
  String get privacyPolicyTitle => 'سياسة الخصوصية وأمان البيانات';

  @override
  String get privacyPolicySubtitle =>
      'خزانة محلية 100% بدون خوادم سحابية أو تتبع';

  @override
  String get privacyPolicyLocalHeading => 'تخزين محلي 100% (Zero-Cloud)';

  @override
  String get privacyPolicyLocalDesc =>
      'جميع روابطك، ملفاتك، صورك وملاحظاتك تُحفظ حصرياً داخل الذاكرة المحلية لهاتفك مشفرة ومعزولة في مساحة التطبيق الآمنة. لا يتم إرسال أي بايت واحد لأي خادم خارجي.';

  @override
  String get privacyPolicyZeroDataHeading => 'صفر تتبع وصفر إعلانات';

  @override
  String get privacyPolicyZeroDataDesc =>
      'تطبيق مَرسى لا يحتوي على أي أدوات تتبع إعلانية أو تحليلات بيانات، ولا نجمع أي هوية تخص هاتفك. خصوصيتك ملكك بالكامل.';

  @override
  String get privacyPolicyStorageHeading => 'تحكم كامل في بياناتك';

  @override
  String get privacyPolicyStorageDesc =>
      'يمكنك حذف أو تصدير أي عنصر في أي وقت، وحذف التطبيق يزيل كافة البيانات نهائياً من هاتفك دون أن يبقى لها أي أثر.';

  @override
  String get permissionsTransparencyTitle => 'شفافية أذونات التطبيق';

  @override
  String get permissionsTransparencyDesc =>
      'شرح تفصيلي لما يحتاجه التطبيق بأمان وشفافية كاملة';

  @override
  String get permShareSheetTitle => 'استقبال المشاركة الخارجية';

  @override
  String get permShareSheetDesc =>
      'يستقبل التطبيق الروابط والملفات فقط عندما تختار مشاركتها طوعاً من خلال قائمة المشاركة بنظام أندرويد دون الحاجة لأي وصول شامل لذاكرتك.';

  @override
  String get permUrlLauncherTitle => 'فتح الروابط في المتصفح';

  @override
  String get permUrlLauncherDesc =>
      'لفتح الروابط والمواقع المحفوظة في متصفحك الافتراضي فور الضغط عليها.';

  @override
  String get permNoSensorsTitle => 'بدون أذونات حساسة';

  @override
  String get permNoSensorsDesc =>
      'تم الاستغناء بالكامل عن البصمة، الكاميرا، الموقع الجغرافي، أو جهات الاتصال. بياناتك في أمان مطلق.';

  @override
  String get expiryNotificationTitle => 'تنبيه خزانة مَرسى المؤقتة';

  @override
  String expiryNotificationBody(String itemTitle) {
    return 'سيتم حذف «$itemTitle» تلقائياً خلال ساعة واحدة!';
  }

  @override
  String get ttlBadgeUrgent => 'باقي أقل من ساعة (حذف وشيك)';

  @override
  String get ocrProcessing => 'جاري قراءة بيانات الوثيقة...';

  @override
  String get ocrRequiresReview => 'يحتاج مراجعة (انقر للتعديل)';

  @override
  String get ocrCompleted => 'تم استخراج البيانات بنجاح';

  @override
  String get editNationalId => 'تعديل الرقم القومي';

  @override
  String get saveChanges => 'حفظ التغييرات';

  @override
  String get documentPreview => 'معاينة الوثيقة';

  @override
  String get rawOcrText => 'النص المستخرج';

  @override
  String get enterNationalIdHint => 'أدخل الرقم القومي المكون من 14 رقماً';

  @override
  String get nationalIdLabel => 'الرقم القومي المصري';

  @override
  String get enrichmentPending => 'جاري جلب تفاصيل الرابط...';

  @override
  String get linkEnriched => 'تم جلب بيانات الرابط بنجاح';

  @override
  String get thumbnailsCache => 'الصور المصغرة للروابط';

  @override
  String get clearThumbnails => 'مسح كاش الصور';

  @override
  String get thumbnailsCleared => 'تم تفريغ مساحة الصور المصغرة بنجاح';

  @override
  String get openInBrowser => 'فتح في المتصفح';

  @override
  String get backupAndRestore => 'النسخ الاحتياطي والأمان المتقدم';

  @override
  String get exportBackup => 'تصدير نسخة مشفرة (.marsa)';

  @override
  String get exportBackupDesc =>
      'حفظ كامل الخزانة في ملف محمي بكلمة مرور دون إنترنت';

  @override
  String get importBackup => 'استرجاع من نسخة سابقة';

  @override
  String get importBackupDesc => 'استيراد خزانة سابقة وفك تشفيرها بأمان';

  @override
  String get enterBackupPassword => 'أدخل كلمة مرور النسخة الاحتياطية';

  @override
  String get confirmBackupPassword => 'تأكيد كلمة المرور';

  @override
  String get passwordMismatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get backupExportSuccess => 'تم إنشاء ومشاركة النسخة المشفرة بنجاح';

  @override
  String get backupImportSuccess => 'تم استرجاع الخزانة بنجاح كامل';

  @override
  String get invalidBackupPassword => 'كلمة المرور غير صحيحة أو الملف تالف';
}
