class ApiConstant{
  // url end-points
  static const String login = "api/participatory/login";
  static const String sendOtp = "api/send-otps";
  static const String userTypes = "api/user-types";
  static const String register = "api/participatory/register";
  static const String verifyOtp = "api/verify-otps";
  static const String getAccountDetails = 'api/participatory/me';
  static const String logOut = 'api/participatory/logout';
  static const String animalList = 'api/participatory/animals';
  static const String breedList = 'api/breed';
  static const String diseaseList = 'api/disease';
  static const String speciesList = 'api/species';
  static const String symptomList = 'api/symptom';
  static const String facilityList = 'api/facility';
  static const String animalScreeningList = 'api/participatory/animal-screenings';
  static const String postMortemList = 'api/participatory/animal-post-mortems';

  // query params
static const String mobile = "mobile";
  static const String otp = "otp";
  static const String canCreateBatch = "can_create_batch";

//body params
static const String facilityId = "facility_id";
static const String facilityName = "facility_name";
static const String ownerName = "owner_name";
static const String nationalID = "national_id";
static const String location = "location";
static const String manualLocation = "manual_location";
static const String userTypeId = "user_type_id";
}
