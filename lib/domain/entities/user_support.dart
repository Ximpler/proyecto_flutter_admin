class UsserSupport {
  int? id;
  final String name;
  final String email;
  final String password;

  UsserSupport({required this.name, required this.email, required this.password});

  UsserSupport.id(int this.id, {required this.name, required this.email, required this.password});
}
