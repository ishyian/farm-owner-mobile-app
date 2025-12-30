bool dynamicToBool(dynamic response) {
  if (response is int) {
    return response == 1;
  } else if (response is bool) {
    return response;
  } else {
    return false;
  }
}
