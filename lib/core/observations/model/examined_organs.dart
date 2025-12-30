enum ExaminedOrgans {
  skinAndCoat,
  eyes,
  ears,
  mouthAndTeeth,
  heart,
  lungs,
  abdomen,
  musculoskeletalSystem,
  reproductiveOrgans,
  nervousSystem,
  lymphNodes,
}

extension ExaminedOrgansExtension on ExaminedOrgans {
  String get name {
    switch (this) {
      case ExaminedOrgans.skinAndCoat:
        return 'Skin and Coat';
      case ExaminedOrgans.eyes:
        return 'Eyes';
      case ExaminedOrgans.ears:
        return 'Ears';
      case ExaminedOrgans.mouthAndTeeth:
        return 'Mouth and Teeth';
      case ExaminedOrgans.heart:
        return 'Heart';
      case ExaminedOrgans.lungs:
        return 'Lungs';
      case ExaminedOrgans.abdomen:
        return 'Abdomen';
      case ExaminedOrgans.musculoskeletalSystem:
        return 'Musculoskeletal System';
      case ExaminedOrgans.reproductiveOrgans:
        return 'Reproductive Organs';
      case ExaminedOrgans.nervousSystem:
        return 'Nervous System';
      case ExaminedOrgans.lymphNodes:
        return 'Lymph Nodes';
      // default:
      //   return null;
    }
  }

  static List<String> get allExaminedOrgans {
    return ExaminedOrgans.values.map((organ) => organ.name).toList();
  }
}