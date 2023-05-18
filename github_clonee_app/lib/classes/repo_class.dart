class Repo_Class {
  final String name;
  final String full_name;
  final String description;


  Repo_Class({required this.name,required this.full_name,required this.description});

  factory Repo_Class.fromJson(Map<String, dynamic> json) {
    return Repo_Class(
      name: json['name'],
      full_name: json['full_name'],
      description: json['description'],
    );
  }
}