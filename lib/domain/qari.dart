class Qari {
  final String name;
  final String whereFrom;
  final String description;
  final String img;

  Qari({
    required this.name,
    required this.whereFrom,
    required this.description,
    required this.img,
  });

  factory Qari.fromJson(Map<String, dynamic> json) {
    return Qari(
      name: json['name'],
      whereFrom: json['whereFrom'],
      description: json['description'],
      img: json['qariImage']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'whereFrom': whereFrom,
      'description': description,
      'qariImage':img
    };
  }
} 
