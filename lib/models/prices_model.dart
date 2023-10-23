class Prices {
  final int? id;
  final String device;
  final int price;

  const Prices({
    this.id,
    required this.device,
    required this.price,
  });

  factory Prices.fromJson(Map<String, dynamic> json) => Prices(
        id: json['id'],
        device: json['device'],
        price: json['price'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'device': device,
        'price': price,
      };
}
