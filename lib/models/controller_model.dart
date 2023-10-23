class Controller {
  final int? id;
  final int price;

  const Controller({
    this.id,
    required this.price,
  });

  factory Controller.fromJson(Map<String, dynamic> json) => Controller(
        id: json['id'],
        price: json['price'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'price': price,
      };
}
