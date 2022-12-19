class UserModel {
  final int id;
  final String name;
  final String email;
  final String companyName;
  bool isFavourite;

  UserModel(
      {required this.id,
      required this.name,
      required this.companyName,
      required this.email,
      this.isFavourite = false});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final String name = json.containsKey('name') ? json['name'] ?? '' : '';
    final String email = json.containsKey('email') ? json['email'] ?? '' : '';
    final int id = json.containsKey('id') ? json['id'] ?? -1 : -1;
    final String companyName = json.containsKey('company')
        ? (json['company'] is Map)
            ? (json['company'] as Map).containsKey('name')
                ? json['company']['name']
                : ''
            : ''
        : '';

    return UserModel(
        id: id, companyName: companyName, email: email, name: name);
  }

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, email: $email, companyName: $companyName, isFavourite: $isFavourite}';
  }
}
