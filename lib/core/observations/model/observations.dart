enum Observations {
  lameness,
  laboredBreathing,
  coughing,
  nasalDischarge,
  aggression,
  excessiveVocalization,
  signsOfDistress,
  inappetence,
  dehydration,
  visibleInjuries,
  openWounds,
  bleeding,
  abnormalDischargesEyes,
  abnormalDischargesNose,
  abnormalDischargesRectum,
  tremorsOrShaking,
}

extension ObservationsExtension on Observations {
  String get name {
    switch (this) {
      case Observations.lameness:
        return 'Lameness';
      case Observations.laboredBreathing:
        return 'Labored breathing';
      case Observations.coughing:
        return 'Coughing';
      case Observations.nasalDischarge:
        return 'Nasal discharge';
      case Observations.aggression:
        return 'Aggression';
      case Observations.excessiveVocalization:
        return 'Excessive vocalization';
      case Observations.signsOfDistress:
        return 'Signs of distress';
      case Observations.inappetence:
        return 'Inappetence';
      case Observations.dehydration:
        return 'Dehydration';
      case Observations.visibleInjuries:
        return 'Visible injuries';
      case Observations.openWounds:
        return 'Open wounds';
      case Observations.bleeding:
        return 'Bleeding';
      case Observations.abnormalDischargesEyes:
        return 'Abnormal discharges in the eyes';
      case Observations.abnormalDischargesNose:
        return 'Abnormal discharges in the nose';
      case Observations.abnormalDischargesRectum:
        return 'Abnormal discharges in the rectum';
      case Observations.tremorsOrShaking:
        return 'Tremors or shaking';
      // default:
      //   return null;
    }
  }

  static List<String> get allObservations {
    return Observations.values.map((observation) => observation.name).toList();
  }
}