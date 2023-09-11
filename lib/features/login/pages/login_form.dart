import 'package:fisioflex_mobile/core/auth/providers/auth_provider.dart';
import 'package:fisioflex_mobile/widgets/forms_inputs.dart';
import 'package:fisioflex_mobile/widgets/warning_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginForm extends StatefulHookConsumerWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  Map<String, TextEditingController> controllers = {};
  final _formKey =
      GlobalKey<FormState>(); // Crea una clave global única para el formulario.

  @override
  void initState() {
    controllers = {
      'identification': TextEditingController(),
      'password': TextEditingController()
    };
    ref.read(authProvider.notifier).checkIfAuthenticated();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        child: Form(
            key: _formKey, // Asigna la clave global al formulario.
            child: Column(
              children: [
                textInputWidget(
                    'Numero de identificacion',
                    controllers['identification']!,
                    TextInputType.emailAddress,
                    false,
                    const Icon(Icons.person), (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingrese su numero de identificacion';
                  }
                }),
                textInputWidget(
                    'Contraseña',
                    controllers['password']!,
                    TextInputType.visiblePassword,
                    true,
                    const Icon(Icons.lock), (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingrese su contraseña';
                  }
                }),
                buttonSubmitWidget('Iniciar Sesion', () {
                  if (_formKey.currentState!.validate()) {
                    ref
                        .read(authProvider.notifier)
                        .login(controllers['identification']!.text,
                            controllers['password']!.text)
                        .then((value) {
                      if (value.statusCode != 201) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return WarningDialogWidget(
                                title: 'Atención!',
                                description: 'Credenciales invalidas',
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                              );
                            });
                      }
                    });
                  }
                }, context)
              ],
            )));
  }
}
