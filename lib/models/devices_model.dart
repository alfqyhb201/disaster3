class Devices {
  final int? id;
  final String name;
  final int isPs4;

  const Devices({
    this.id,
    required this.name,
    required this.isPs4,
  });

  factory Devices.fromJson(Map<String, dynamic> json) => Devices(
        id: json['id'],
        name: json['name'],
        isPs4: json['isPs4'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'isPs4': isPs4,
      };
}
