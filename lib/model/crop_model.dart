import 'package:cloud_firestore/cloud_firestore.dart';

class Crop {
  final String cropId;
  final String cropImage;
  final List<String> cropName;
  final List<String> description;
  final String category; // "kharif", "rabi", or "zaid"
  final List<String> images;
  final Map<String, List<CropStep>> language;

  Crop({
    required this.cropId,
    required this.cropImage,
    required this.cropName,
    required this.description,
    required this.category,
    required this.language,
    required this.images,
  });

  factory Crop.fromJson(DocumentSnapshot snap) {
    final json = snap.data() as Map<String, dynamic>;

    return Crop(
      cropId: json['cropId'] ?? '',
      cropImage: json['cropImage'] ?? '',
      cropName: List<String>.from(json['cropName'] ?? []),
      description: List<String>.from(json['description'] ?? []),
      category: json['category'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      language: (json['language'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(
              key,
              (value as List<dynamic>)
                  .map((e) => CropStep.fromJson(e as Map<String, dynamic>))
                  .toList(),
            ),
          ) ??
          {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cropId': cropId,
      'cropName': cropName,
      '': cropImage,
      'description': description,
      'category': category,
      'images': images,
      'language': language.map((key, value) {
        return MapEntry(key, value.map((e) => e.toJson()).toList());
      }),
    };
  }

  Crop copyWith({
    String? cropId,
    String? cropImage,
    List<String>? cropName,
    List<String>? description,
    String? category,
    List<String>? images,
    Map<String, List<CropStep>>? language,
  }) {
    return Crop(
      cropId: cropId ?? this.cropId,
      cropImage: cropImage ?? this.cropImage,
      cropName: cropName ?? this.cropName,
      description: description ?? this.description,
      category: category ?? this.category,
      images: images ?? this.images,
      language: language ?? this.language,
    );
  }
}

class CropStep {
  final int step;
  final String title;
  final String description;

  CropStep({
    required this.step,
    required this.title,
    required this.description,
  });

  factory CropStep.fromJson(Map<String, dynamic> json) {
    return CropStep(
      step: json['step'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'step': step,
      'title': title,
      'description': description,
    };
  }

  CropStep copyWith({int? step, String? title, String? description}) {
    return CropStep(
      step: step ?? this.step,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}
