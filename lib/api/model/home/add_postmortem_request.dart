class AddPostMortemRequest {
  String? dateOfPostMortem;
  int? noOfAnimalsScreened;
  int? noOfAnimalsOrgansCollected;
  List<Details>? details;

  AddPostMortemRequest({
    this.dateOfPostMortem,
    this.noOfAnimalsScreened,
    this.noOfAnimalsOrgansCollected,
    this.details,
  });

  Map<String, dynamic> toJson() {
    return {
      'date_of_post_mortem': dateOfPostMortem,
      'no_of_animals_screened': noOfAnimalsScreened,
      'no_of_animals_organs_collected': noOfAnimalsOrgansCollected,
      'details': details?.map((e) => e.toJson()).toList(),
    };
  }
}

class Details {
  String? animalId;
  String? examinedOrgan;
  String? observation;
  String? carcassCondemnation;

  Details({
    this.animalId,
    this.examinedOrgan,
    this.observation,
    this.carcassCondemnation,
  });

  Map<String, dynamic> toJson() {
    return {
      'animal_id': animalId,
      'examined_organ': examinedOrgan,
      'observation': observation,
      'carcass_condemnation': carcassCondemnation,
    };
  }
}
