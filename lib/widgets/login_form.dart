import 'package:evaluacion_final/providers/login_form_provider.dart';
import 'package:evaluacion_final/services/auth_service.dart';
import 'package:flutter/material.dart';
import '../ui/input_decorations.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      key: LoginForm.formKey,
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column (children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecorations.authInputDecoration(
              hinText: 'Ingrese su correo',
              labelText: 'Email',
              prefixIcon: Icons.people,
            ),
            onChanged: (value) => LoginForm.email = value,
            validator: (value) {
              return (value != null && value.length >= 4) ? null : 'El ususario no puede estar vacio';
            },
          ),
          const SizedBox(height: 50),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputDecorations.authInputDecoration(
              hinText: '********',
              labelText: 'Password',
              prefixIcon: Icons.lock_outline
            ),
            onChanged: (value) => LoginForm.password = value,
            validator: (value) {
              return (value != null && value.length >= 4) ? null : 'El ususario no puede estar vacio';
            },
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            disabledColor: Colors.grey,
            color: Colors.red,
            elevation: 0,
            onPressed:
              LoginForm.isLoading ? 
              () async {print('loading');} : 
              () async {
                FocusScope.of(context).unfocus();
                final authService = Provider.of<AuthServices>(context, listen: false);
                LoginForm.isLoading = true;
                final String? errorMessage  = await authService.login(LoginForm.email, LoginForm.password);
                if (errorMessage == null) {
                  Navigator.pushNamed(context, 'home');
                } else {
                  print(errorMessage);
                }
                LoginForm.isLoading = false;

              }
            ,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
              child: Text('Ingresar', style: const TextStyle(color: Colors.white),)
            ),
          ) 
        ])
      )
    );
  }
}