
/*class User {
  final String gender;
  final String email;
  final String phone;
  final String cell;
  final String nat;
  final UserName name;

  User( {
    required this.gender,
    required this.email,
    required this.phone,
    required this.cell,
    required this.nat,
    required this.name,
  });
  String get  fullName {
    return '${name.title}${name.first} ${name.last}';
  }


}*/

// User

import 'dart:math';

class User {
  final String gender;
  final String phone;
  final String cell;
  final String email;
  final String nat;
  final Username name;
  final dateOfBirth dob;
  final UserLocation location;
  final UserPicture picture;

  User( {
    required this.gender,
    required this.email,
    required this.cell,
    required this.nat,
    required this.phone,
    required this.name,
    required this.dob,
    required this.location,
    required this.picture,

  });

  factory User.fromMap(Map<String,dynamic>e) {
    final date = e['dob']['date'];
    final dob = dateOfBirth(
      age: e['dob']['age'],
      date: DateTime.parse(date),
    );

    final location = UserLocation.fromMap(e['location']);
    final name = Username.fromMap(e['name']);
    final picture = UserPicture.fromMap(e['picture']);

    return User(
      gender: e["gender"],
      email: e["email"],
      phone: e["phone"],
      cell: e["cell"],
      nat: e["nat"],
      name: name,
      dob:dob,
      location: location,
      picture: picture,
    );

  }
  String get  fullName {
    return '${name.title}${name.first} ${name.last}';
  }
}
// User Name
class Username{
  final String title;
  final String first;
  final String last;

  Username({
    required this.title,
    required this.first,
    required this.last,

  });
  factory Username.fromMap(Map<String, dynamic> json){
    return Username(
      title: json['title'],
      first: json['first'],
      last: json['last'],
    );
  }

}
// Date of birth
class dateOfBirth
{
  final DateTime date;
  final int age;

  dateOfBirth({
    required this.date,
    required this.age,
  });
}
// Location
class  UserLocation
{
  final String city;
  final String state;
  final String country;
  final String postcode;

  final LocationStreet street;
  final LocationCoordinates coordinates;
  final LocationTime timezone;


  UserLocation({
    required this.city,
    required this.country,
    required this.postcode,
    required this.state,
    required this.coordinates,
    required this.street,
    required this.timezone,

  });
  factory UserLocation.fromMap(Map<String, dynamic> json) {
    final coordinates = LocationCoordinates(
      latitude: json['coordinates']['latitude'],
      longitude: json['coordinates']['longitude'],
    );
    final street = LocationStreet(
        name: json['street']['name'],
        number: json['street']['number'].toString());
    final timezone = LocationTime(
      offset: json['timezone']['offset'],
      description: json['timezone']['description'],
    );
    return UserLocation(
      city: json['city'],
      country: json['country'],
      postcode: json['postcode'].toString(),
      state: json['state'],
      coordinates: coordinates,
      street: street,
      timezone: timezone,
    );
  }
}
// Street
class LocationStreet {
  final String number;
  final String name;
  LocationStreet({
    required this.name,
    required this.number,

  });
}
// coordinates
class LocationCoordinates {

  final String latitude ;
  final String longitude;

  LocationCoordinates({
    required this.latitude,
    required this.longitude,

  });
}
// timezone
class LocationTime {
  final String offset;
  final String description;

  LocationTime({
    required this.offset,
    required this.description,
  });
}

class UserPicture{
  final  String large;
  final String medium;
  final String thumbnail;

  UserPicture({
    required this.large,
    required this.medium,
    required this.thumbnail,
});

  factory UserPicture.fromMap(Map<String, dynamic> json){
    return UserPicture(
      large: json['large'],
      medium: json['medium'],
      thumbnail: json['thumbnail'],
    );
  }
}

