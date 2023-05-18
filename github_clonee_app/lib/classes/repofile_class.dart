class Repofile_Class {
  final String name;
  final String path;
  final String type;



  Repofile_Class({required this.name, required this.path, required this.type});

  factory Repofile_Class.fromJson(Map<String, dynamic> json) {
    return Repofile_Class(
      name: json['name'],
      path: json['full_name'],
      type: json['type'],
    );
  }
}

