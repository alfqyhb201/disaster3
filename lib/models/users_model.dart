class Users {
  final int? id;
  final String name;
  final String password;
  final String rule;

  const Users({
    this.id,
    required this.name,
    required this.password,
    required this.rule,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json['id'],
        name: json['name'],
        password: json['password'],
        rule: json['rule'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'password': password,
        'rule': rule,
      };
}
