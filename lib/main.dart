import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart' as validator;
import 'package:cadastro/entidades/userModel.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Forms')),
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formKey = GlobalKey<FormState>();
  var user = UserModel();
  var senhaCache = '';
  var confimSenha = '';
  bool mostrarSenha = false;
  bool checkTerms = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Center(
                child: Text(
                  'Cadastro de Cliente',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 20),
              CustonTextFild(
                label: 'Nome',
                icon: Icons.person,
                hint: 'Digite seu Nome Completo',
                onSaved: (text) => user = user.copyWith(name: text),
                validator: (text) {
                  if (text == null || text.isEmpty)
                    return 'Esse campo nao pode ser nulo';
                  if (text.length < 4) {
                    return 'Nome completo';
                  }
                },
              ),
              SizedBox(height: 20),
              CustonTextFild(
                label: 'Endereço',
                icon: Icons.house,
                hint: 'Digite seu Endereço',
                onSaved: (text) => user = user.copyWith(endereco: text),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Esse campo nao pode ser nulo';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CustonTextFild(
                label: 'Email',
                icon: Icons.mail,
                hint: 'Digite seu Email',
                onSaved: (text) => user = user.copyWith(email: text),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Esse campo nao pode ser nulo';
                  }
                  if (!validator.isEmail(text)) {
                    return 'Valor precisa ser do tipo email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CustonTextFild(
                label: 'Senha',
                icon: Icons.password,
                hint: 'Digite sua Senha',
                onSaved: (text) => user = user.copyWith(senha: text),
                obscureText: mostrarSenha,
                suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      mostrarSenha = !mostrarSenha;
                    });
                  },
                  icon: Icon(
                    mostrarSenha ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Esse campo nao pode ser nulo';
                  }
                  if (confimSenha != senhaCache) {
                    return 'As senhas não são iguais';
                  }
                  if (confimSenha != senhaCache) {
                    return 'As senhas não são iguais';
                  }
                  return null;
                },
                onChanged: (text) => senhaCache = text,
              ),
              SizedBox(height: 20),
              CustonTextFild(
                label: 'Confirme sua senha',
                icon: Icons.password_rounded,
                hint: 'Confirme sua senha',
                obscureText: mostrarSenha,
                suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      mostrarSenha = !mostrarSenha;
                    });
                  },
                  icon: Icon(
                    mostrarSenha ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                onSaved: (text) => user = user.copyWith(senha: text),
                onChanged: (text) => confimSenha = text,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Esse campo nao pode ser nulo';
                  }
                  if (confimSenha != senhaCache) {
                    return 'As senhas não são iguais';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: checkTerms,
                    onChanged: (v) {
                      setState(() {
                        checkTerms = v!;
                      });
                    },
                  ),
                  Text('Termos de uso'),
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                verticalDirection: VerticalDirection.up,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      formKey.currentState?.reset();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    label: Text(
                      'Limpar',
                      style: TextStyle(color: Colors.black),
                    ),
                    icon: Icon(Icons.clear, color: Colors.black),
                  ),
                  SizedBox(width: 30),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        print('''Cadastro Cliente
                        Nome: ${user.name}
                        Endereço: ${user.endereco}
                        Email: ${user.email}
                        Senha: ${user.senha}''');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                    ),
                    label: Text(
                      'Salvar',
                      style: TextStyle(color: Colors.black),
                    ),
                    icon: Icon(Icons.save, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustonTextFild extends StatelessWidget {
  final String label;
  final String? hint;
  final IconData? icon;
  final bool obscureText;
  final Widget? suffix;
  final String? Function(String? text)? validator;
  final void Function(String? text)? onSaved;
  final void Function(String text)? onChanged;

  const CustonTextFild({
    super.key,
    required this.label,
    this.obscureText = false,
    this.icon,
    this.hint,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        suffixIcon: suffix,
        labelText: label,
        hintText: hint,
        prefixIcon: icon == null ? null : Icon(icon),
      ),
    );
  }
}
