class Reports {
  final int? id;
  final String device;
  final String price;
  final String user;
  final String date;

  Reports({
    this.id,
    required this.device,
    required this.price,
    required this.user,
    required this.date,
  });

  factory Reports.fromJson(Map<String, dynamic> json) => Reports(
        id: json['id'],
        device: json['device'],
        price: json['price'],
        user: json['user'],
        date: json['date'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'device': device,
        'price': price,
        'user': user,
        'date': date,
      };
}
