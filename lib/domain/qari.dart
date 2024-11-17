class Qari {
  final String name;
  final String whereFrom;
  final String description;

  Qari({
    required this.name,
    required this.whereFrom,
    required this.description,
  });

  factory Qari.fromJson(Map<String, dynamic> json) {
    return Qari(
      name: json['name'],
      whereFrom: json['whereFrom'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'whereFrom': whereFrom,
      'description': description,
    };
  }
} 
