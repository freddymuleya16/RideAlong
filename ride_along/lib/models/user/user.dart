class AppUser {
  String firstname;
  String lastname;
  String phone;
  String email;
  String location;
  String emergencyContact;
  String language;
  String locationShare;
  String imageUrl;
  String id;
  String about;
  int numberOfTrips;
  double rating;
  double totalDistance;

  AppUser({
    this.about = "",
    this.numberOfTrips = 0,
    this.rating = 0,
    this.totalDistance = 0,
    required this.id,
    this.imageUrl = "",
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.email,
    required this.location,
    required this.emergencyContact,
    required this.language,
    required this.locationShare,
  });

  static AppUser fromFirebase(Map<String, dynamic> firebaseData, String id) {
    return AppUser(
      id: id,
      firstname: firebaseData['firstname'],
      lastname: firebaseData['lastname'],
      phone: firebaseData['phone'],
      email: firebaseData['email'],
      location: firebaseData['location'],
      emergencyContact: firebaseData['emergency_contact'],
      language: firebaseData['language'],
      locationShare: firebaseData['locationShare'],
      imageUrl: firebaseData['imageUrl'],
      about: firebaseData['about'] as String? ?? "",
      numberOfTrips: firebaseData['numberOfTrips'] as int? ?? 0,
      rating: firebaseData['rating'] as double? ?? 0,
      totalDistance: firebaseData['totalDistance'] as double? ?? 0,
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'phone': phone,
      'email': email,
      'location': location,
      'emergency_contact': emergencyContact,
      'language': language,
      'locationShare': locationShare,
      "imageUrl": imageUrl,
      'totalDistance': totalDistance,
      'rating': rating,
      'numberOfTrips': numberOfTrips,
      'about': about
    };
  }

  void setFirstname(String value) {
    firstname = value;
  }

  void setLastname(String value) {
    lastname = value;
  }

  void setPhone(String value) {
    phone = value;
  }

  void setEmail(String value) {
    email = value;
  }

  void setLocation(String value) {
    location = value;
  }

  void setEmergencyContact(String value) {
    emergencyContact = value;
  }

  void setLanguage(String value) {
    language = value;
  }

  void setLocationShare(String value) {
    locationShare = value;
  }

  void setImageUrl(String value) {
    imageUrl = value;
  }

  void setId(String value) {
    id = value;
  }

  void setAbout(String value) {
    about = value;
  }

  void setNumberOfTrips(int value) {
    numberOfTrips = value;
  }

  void setRating(double value) {
    rating = value;
  }

  void setTotalDistance(double value) {
    totalDistance = value;
  }

  void setimageUrl(String value) {
    imageUrl = value;
  }
}
