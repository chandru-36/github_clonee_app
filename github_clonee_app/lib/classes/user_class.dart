class User_Class {
  final String user_name;
  final String full_name;
  final String company;
  final String location;
  final String email;
  final String avatar;



  User_Class({required this.user_name, required this.full_name, required this.company,
    required this.location, required this.email, required this.avatar});

  factory User_Class.fromJson(Map<String, dynamic> json) {
    return User_Class(
      user_name: json['user_name'],
      full_name: json['full_name'],
      company: json['company'],
      location: json['location'],
      email: json['email'],
      avatar: json['avatar'],
    );
  }
}

