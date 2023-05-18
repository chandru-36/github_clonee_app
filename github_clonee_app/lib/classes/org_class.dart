class Org_Class {
  final String login;
  final String avatar;
  final String description;

  Org_Class({required this.login, required this.avatar, required this.description});

  factory Org_Class.fromJson(Map<String, dynamic> json) {
    return Org_Class(
      login: json['login'],
      avatar: json['avatar'],
      description: json['description'],
    );
  }
}