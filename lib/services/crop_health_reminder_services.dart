import 'package:agrisync/model/crop_health_reminder.dart';
import 'package:agrisync/model/crop_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';

class CropHealthReminderServices {
  CropHealthReminderServices._();
  static CropHealthReminderServices instance = CropHealthReminderServices._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String uid = FirebaseAuth.instance.currentUser!.uid;

  static const String chr = "crop health reminder";
  static const String crops = "crops";

  Future<Crop> findCrop(String cropId) async {
    final snap = await _firestore.collection(crops).doc(cropId).get();
    return Crop.fromSnap(snap);
  }

  Future<String?> addCropToCHR(String cropId) async {
    try {
      final existing = await _firestore
          .collection(chr)
          .where('uid', isEqualTo: uid)
          .where('cropId', isEqualTo: cropId)
          .get();

      if (existing.docs.isNotEmpty) {
        return 'You already added this crop!';
      }

      String chrId = const Uuid().v4();
      Crop crop = await findCrop(cropId);
      DateTime endingDate = DateTime.now().add(
        Duration(days: (crop.language['en']!.length) * 7),
      );

      CropHealthReminder cropHealthReminder = CropHealthReminder(
        chrId: chrId,
        uid: uid,
        cropId: cropId,
        startDate: DateTime.now(),
        endingDate: endingDate,
      );

      await _firestore
          .collection(chr)
          .doc(chrId)
          .set(cropHealthReminder.toJson());

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<Crop>> userCropHealthReminder() async {
    try {
      final snaplist =
          await _firestore.collection(chr).where('uid', isEqualTo: uid).get();

      List<Crop> cropList = [];

      for (var doc in snaplist.docs) {
        final cropId = doc['cropId'];
        Crop crop = await findCrop(cropId); // Fetch full crop details
        cropList.add(crop);
      }

      return cropList;
    } catch (e) {
      print("Error in findCHR user : ${e.toString()}");
      return [];
    }
  }

  Future<String?> delCHR(String chrId) async {
    try {
      await _firestore.collection(chr).doc(chrId).delete();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<CropHealthReminder?> findCropHealthReminder(
      String cropId, String uid) async {
    try {
      final snap = await _firestore
          .collection(chr)
          .where("cropId", isEqualTo: cropId)
          .where("uid", isEqualTo: uid)
          .get();
      return CropHealthReminder.fromSnap(snap.docs.first);
    } catch (e) {
      return null;
    }
  }
}
