import 'package:evaluacion_final/providers/login_form_provider.dart';
import 'package:evaluacion_final/widgets/auth_background.dart';
import 'package:evaluacion_final/widgets/card_container.dart';
import 'package:evaluacion_final/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Cambia dinámicamente el fondo según el tema seleccionado (claro u oscuro)
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 150),
                    Text(
                      'Login',
                      style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    const SizedBox(height: 50),
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: LoginForm()
                    ),
                    const SizedBox(height: 150),                    
                  ]
                ),
              )         
            ],
          ),
        )
      )
    );
  }
}