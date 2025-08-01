class UserModel {
  final String name;
  final String endereco;
  final String email;
  final String senha;

  UserModel({
    this.name = '',
    this.endereco = '',
    this.email = '',
    this.senha = '',
  });

  UserModel copyWith({
    String? name,
    String? endereco,
    String? email,
    String? senha,
  }) {
    return UserModel(
      name: name ?? this.name,
      endereco: endereco ?? this.endereco,
      email: email ?? this.endereco,
      senha: senha ?? this.senha,
    );
  }
}
