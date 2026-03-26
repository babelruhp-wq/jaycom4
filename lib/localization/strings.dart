import 'app_lang.dart';

class Tr {
  static String t(L10n l10n, String key) => _map[l10n.lang]![key] ?? key;

  static const Map<AppLang, Map<String, String>> _map = {
    AppLang.ar: {
      "home": "الرئيسية",
      "about": "من نحن",
      "services": "خدماتنا",
      "contact": "تواصل معنا",
      "downloadApps": "حمّل التطبيق",
      "langBtn": "EN",
      'menu': 'القائمة',
      "heroTitle": "Jaicom4\nالموقع الرسمي للتطبيق",
      "heroSubtitle":
          "منصة تعريفية لتطبيق Jaicom4 (تطبيق واحد).\nتحميل للأندرويد والآيفون من الروابط بالأسفل.",
      "tag1": "احترافية",
      "tag2": "سهولة",
      "tag3": "سرعة",
      "btnAndroid": "تحميل Android",
      "btniOS": "تحميل iOS",

      "howTitle": "كيف يعمل؟",
      "howSub": "التعامل الكامل يتم داخل التطبيق.",
      "step1t": "ثبت التطبيق",
      "step1s": "Android أو iOS",
      "step2t": "اختر الخدمة",
      "step2s": "سباك/نجار/كهربائي/…",
      "step3t": "تواصل واطلب",
      "step3s": "كل الشغل يتم من خلال التطبيق",

      "profTitle": "أمثلة للمهن",
      "aboutTitle": "من نحن",
      "aboutSub": "Jaicom4 يربطك بالخدمة اللي تحتاجها بشكل احترافي.",
      "bullet1": "موقع تعريفي للتطبيق فقط.",
      "bullet2": "التواصل والطلبات تتم داخل التطبيق.",
      "bullet3": "تجربة بسيطة وسريعة.",

      "servicesTitle": "خدماتنا",
      "servicesSub": "لمحة عن قيمة Jaicom4.",
      "s1t": "سهولة الوصول",
      "s1s": "تلاقي الخدمة المطلوبة بسرعة.",
      "s2t": "وضوح وثقة",
      "s2s": "معلومات واضحة وتجربة احترافية.",
      "s3t": "دعم",
      "s3s": "قنوات تواصل واضحة لأي استفسار.",

      "ctaTitle": "جاهز تبدأ؟",
      "ctaSub": "حمّل التطبيق الآن للأندرويد أو الآيفون.",

      "contactTitle": "تواصل معنا",
      "contactSub": "ابعت رسالة وسنرد عليك.",
      "name": "الاسم",
      "phone": "رقم الجوال",
      "message": "رسالتك",
      "send": "إرسال",
      "sent": "تم إرسال رسالتك ✅",

      "fabContact": "تواصل",
      "fabWhatsapp": "واتساب",
      "fabSnap": "سناب",
      "fabTiktok": "تيكتوك",
      "fabX": "X",
      "svcHint": "سريع • واضح • موثوق",
      'privacy_policy':'سياسة الخصوصية',
      'terms_conditions':'الشروط والأحكام',
      "footer": "© Jaicom4 — الموقع تعريفي، التنفيذ داخل التطبيق",
    },
    AppLang.en: {
      "home": "Home",
      "about": "About",
      "services": "Services",
      "contact": "Contact",
      "downloadApps": "Get the app",
      "langBtn": "AR",
      'menu': 'Menu',
      'privacy_policy':'Privacy Policy',
      'terms_conditions':'Terms and conditions',

      "heroTitle": "Jaicom4\nOfficial App Website",
      "heroSubtitle":
          "An informational website for the Jaicom4 app (single app).\nDownload for Android & iOS using the links below.",
      "tag1": "Professional",
      "tag2": "Simple",
      "tag3": "Fast",
      "btnAndroid": "Download Android",
      "btniOS": "Download iOS",

      "howTitle": "How it works",
      "howSub": "All operations happen inside the app.",
      "step1t": "Download",
      "step1s": "Android or iOS",
      "step2t": "Choose service",
      "step2s": "Plumber/Carpenter/Electrician/…",
      "step3t": "Request & connect",
      "step3s": "Everything is done inside the app",

      "profTitle": "Sample professions",
      "aboutTitle": "About us",
      "aboutSub":
          "Jaicom4 helps you reach the service you need professionally.",
      "bullet1": "This is a landing website for the app only.",
      "bullet2": "Requests and communication happen inside the app.",
      "bullet3": "Simple & fast experience.",

      "servicesTitle": "Our services",
      "servicesSub": "A quick overview of Jaicom4 value.",
      "s1t": "Easy access",
      "s1s": "Find the service you need quickly.",
      "s2t": "Clarity & trust",
      "s2s": "Clear info with a professional experience.",
      "s3t": "Support",
      "s3s": "Clear communication channels for inquiries.",

      "ctaTitle": "Ready to start?",
      "ctaSub": "Download the app for Android or iOS.",

      "contactTitle": "Contact us",
      "contactSub": "Send a message and we’ll get back to you.",
      "name": "Name",
      "phone": "Phone",
      "message": "Message",
      "send": "Send",
      "sent": "Message sent ✅",

      "svcHint": "Fast • Clear • Reliable",

      "fabContact": "Contact",
      "fabWhatsapp": "WhatsApp",
      "fabSnap": "Snapchat",
      "fabTiktok": "TikTok",
      "fabX": "X",

      "footer": "© Jaicom4 — Informational website, operations in-app",
    },
  };
}
