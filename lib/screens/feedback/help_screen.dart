import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    String language = AppLocalizations.of(context)!.appLanguage;
    return language == "en"
        ? const HelpScreenEN()
        : language == 'hi'
            ? const HelpScreenHI()
            : const HelpScreenGU();
  }
}

class HelpScreenEN extends StatelessWidget {
  const HelpScreenEN({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Help & Support")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const TextLato(
            text: "🧠 Frequently Asked Questions",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          _faqTile(
            "What is AgriSync?",
            "AgriSync is a platform where farmers share crop problems, get help from specialists, view technologies, and manage crop health.",
          ),
          _faqTile(
            "How do I post a thread?",
            "Go to the Threads tab and tap the '+' button. Add your issue and submit. A specialist will reply soon.",
          ),
          _faqTile(
            "Can I message a specialist directly?",
            "Currently, specialists respond in the thread. Direct messaging may be added in the future.",
          ),
          _faqTile(
            "How do I update my review?",
            "Go to the Review section, and if you've already submitted a review, it will open in edit mode automatically.",
          ),
          _faqTile(
            "How to delete a comment or review?",
            "Long press on the comment or review. A confirmation dialog will appear. Tap 'OK' to delete it.",
          ),
          const SizedBox(height: 20),
          const TextLato(
            text: "📲 How to Use AgriSync",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          const TextLato(
            text:
                "📝 Post a Crop Issue:\nGo to the Threads section, tap the '+' button, describe your issue, and submit.",
            fontSize: 15,
          ),
          const TextLato(
            text:
                "💬 Get Specialist Replies:\nSpecialists will view your post and respond with advice or solutions.",
            fontSize: 15,
          ),
          const TextLato(
            text:
                "🌱 Crop Health Reminder:\n(FUTURE)Use this feature to stay notified about seeding, watering, and harvesting schedules.",
            fontSize: 15,
          ),
          const TextLato(
            text:
                "🧪 Discover Technologies:\nVisit AgriConnect to explore the latest farming technologies posted by experts.",
            fontSize: 15,
          ),
          const TextLato(
            text:
                "🔒 Profile & Settings:\nUpdate your profile, language, or give app feedback anytime.",
            fontSize: 15,
          ),
          const SizedBox(height: 20),
          const TextLato(
            text: "📞 Contact & Support",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          const TextLato(
            text: "📧 Email: agrisync12547@gmail.com",
            fontSize: 16,
          ),
          const TextLato(
            text: "📱 Phone 1: +91 91069-71174",
            fontSize: 16,
          ),
          const TextLato(
            text: "📱 Phone 2: +91 93276-52033",
            fontSize: 16,
          ),
          const TextLato(
            text: "📱 Phone 3: +91 90162-52155",
            fontSize: 16,
          ),
        ],
      ),
    );
  }

  Widget _faqTile(String question, String answer) {
    return ExpansionTile(
      title: TextLato(
        text: question,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, right: 8.0),
          child: TextLato(
            text: answer,
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class HelpScreenHI extends StatelessWidget {
  const HelpScreenHI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("मदद और सहायता")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const TextLato(
            text: "🧠 अक्सर पूछे जाने वाले प्रश्न",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          _faqTile("AgriSync क्या है?",
              "AgriSync एक ऐसा प्लेटफ़ॉर्म है जहाँ किसान फसल की समस्याएँ साझा करते हैं और विशेषज्ञों से सहायता प्राप्त करते हैं।"),
          _faqTile("मैं पोस्ट कैसे करूं?",
              "Threads टैब में जाएं और '+' बटन पर टैप करें, अपनी समस्या जोड़ें और सबमिट करें।"),
          _faqTile("क्या मैं विशेषज्ञ से सीधे संपर्क कर सकता हूँ?",
              "फिलहाल, विशेषज्ञ थ्रेड में ही जवाब देते हैं। भविष्य में डायरेक्ट मैसेजिंग जोड़ी जा सकती है।"),
          _faqTile("मैं अपनी समीक्षा कैसे अपडेट करूं?",
              "Review सेक्शन में जाएं, यदि आपने पहले से समीक्षा की है तो वह एडिट मोड में खुलेगी।"),
          _faqTile("मैं टिप्पणी या समीक्षा कैसे हटाऊं?",
              "टिप्पणी या समीक्षा पर लॉन्ग प्रेस करें, फिर 'OK' दबाएं।"),
          const SizedBox(height: 20),
          const TextLato(
            text: "📲 AgriSync का उपयोग कैसे करें",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          const TextLato(
              text:
                  "📝 फसल की समस्या पोस्ट करें:\nThreads सेक्शन में जाएं, '+' टैप करें, विवरण भरें और सबमिट करें।",
              fontSize: 15),
          const TextLato(
              text:
                  "💬 विशेषज्ञ की प्रतिक्रिया प्राप्त करें:\nविशेषज्ञ आपकी पोस्ट पढ़कर समाधान देंगे।",
              fontSize: 15),
          const TextLato(
              text:
                  "🌱 फसल स्वास्थ्य रिमाइंडर:\n(आने वाला फीचर) बुवाई, पानी और कटाई के लिए नोटिफिकेशन प्राप्त करें।",
              fontSize: 15),
          const TextLato(
              text:
                  "🧪 तकनीक खोजें:\nAgriConnect में जाकर विशेषज्ञों द्वारा जोड़ी गई नई कृषि तकनीकें देखें।",
              fontSize: 15),
          const TextLato(
              text:
                  "🔒 प्रोफ़ाइल और सेटिंग्स:\nप्रोफ़ाइल अपडेट करें, भाषा बदलें या प्रतिक्रिया दें।",
              fontSize: 15),
          const SizedBox(height: 20),
          const TextLato(
              text: "📞 संपर्क और सहायता",
              fontSize: 20,
              fontWeight: FontWeight.bold),
          const TextLato(
              text: "📧 ईमेल: agrisync12547@gmail.com", fontSize: 16),
          const TextLato(text: "📱 फोन 1: +91 91069-71174", fontSize: 16),
          const TextLato(text: "📱 फोन 2: +91 93276-52033", fontSize: 16),
          const TextLato(text: "📱 फोन 3: +91 90162-52155", fontSize: 16),
        ],
      ),
    );
  }

  Widget _faqTile(String question, String answer) {
    return ExpansionTile(
      title:
          TextLato(text: question, fontSize: 16, fontWeight: FontWeight.w600),
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextLato(text: answer, fontSize: 15))
      ],
    );
  }
}

class HelpScreenGU extends StatelessWidget {
  const HelpScreenGU({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("મદદ અને સપોર્ટ")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const TextLato(
            text: "🧠 વારંવાર પૂછાતા પ્રશ્નો",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          _faqTile("AgriSync શું છે?",
              "AgriSync એ એક પ્લેટફોર્મ છે જ્યાં ખેડૂતોએ પાકની સમસ્યાઓ શેર કરી શકે છે અને નિષ્ણાતોથી મદદ મેળવી શકે છે."),
          _faqTile("હું થ્રેડ કેવી રીતે પોસ્ટ કરું?",
              "Threads ટૅબ પર જાઓ અને '+' બટન પર ટેપ કરો. તમારું પ્રશ્ન લખો અને મોકલો."),
          _faqTile("શું હું નિષ્ણાતોને સીધો સંદેશ આપી શકું?",
              "હાલમાં નિષ્ણાતો થ્રેડમાં જવાબ આપે છે. ભવિષ્યમાં ડાયરેક્ટ મેસેજિંગ ઉમેરાઈ શકે છે."),
          _faqTile("હું મારી સમીક્ષા કેવી રીતે સુધારું?",
              "Review વિભાગમાં જાઓ, અને જો તમે પહેલેથી સમીક્ષા કરી હોય તો તે સુધારવા માટે ખુલે છે."),
          _faqTile("ટિપ્પણી અથવા સમીક્ષા કેવી રીતે ડિલીટ કરવી?",
              "ટિપ્પણી પર લાંબો પ્રેસ કરો, પછી 'OK' દબાવો."),
          const SizedBox(height: 20),
          const TextLato(
            text: "📲 AgriSync કેવી રીતે વાપરવો",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          const TextLato(
              text:
                  "📝 પાક સમસ્યા પોસ્ટ કરો:\nThreads વિભાગમાં '+', દબાવો, વિગતો લખો અને મોકલો.",
              fontSize: 15),
          const TextLato(
              text:
                  "💬 નિષ્ણાતની જવાબદારી મેળવો:\nનિષ્ણાતો તમારા પ્રશ્નને વાંચીને જવાબ આપશે.",
              fontSize: 15),
          const TextLato(
              text:
                  "🌱 પાક હેલ્થ રિમાઈન્ડર:\n(આવતીકાલે) પાક માટે સૂચનાઓ મેળવો - વાવણી, પાણી, હાર્વેસ્ટિંગ.",
              fontSize: 15),
          const TextLato(
              text:
                  "🧪 ટેક્નોલોજી શોધો:\nAgriConnectમાં નવી ખેતી ટેકનોલોજી જુઓ.",
              fontSize: 15),
          const TextLato(
              text:
                  "🔒 પ્રોફાઇલ અને સેટિંગ્સ:\nપ્રોફાઇલ સુધારો, ભાષા બદલો, અને ફીડબેક આપો.",
              fontSize: 15),
          const SizedBox(height: 20),
          const TextLato(
              text: "📞 સંપર્ક અને સપોર્ટ",
              fontSize: 20,
              fontWeight: FontWeight.bold),
          const TextLato(
              text: "📧 ઇમેઇલ: agrisync12547@gmail.com", fontSize: 16),
          const TextLato(text: "📱 ફોન 1: +91 91069-71174", fontSize: 16),
          const TextLato(text: "📱 ફોન 2: +91 93276-52033", fontSize: 16),
          const TextLato(text: "📱 ફોન 3: +91 90162-52155", fontSize: 16),
        ],
      ),
    );
  }

  Widget _faqTile(String question, String answer) {
    return ExpansionTile(
      title:
          TextLato(text: question, fontSize: 16, fontWeight: FontWeight.w600),
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextLato(text: answer, fontSize: 15))
      ],
    );
  }
}
