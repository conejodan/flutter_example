import 'package:flutter/material.dart';

class FormularioScreen extends StatefulWidget {
  const FormularioScreen({super.key});

  static String route = "/formulario";

  @override
  State<FormularioScreen> createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  procesarFormulario() {
    print('Enviando formulario');

    //Ocultando teclado
    FocusManager.instance.primaryFocus?.unfocus();

    //Realizando validacion del formulario
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      formKey.currentState!.save();
      print('Registrando datos');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Todos los datos validados',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Hubo un error en la validacion',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: 'Valor inicial',
                  decoration: InputDecoration(
                    labelText: 'Usuario',
                    hintText: 'Ingrese su usuario',
                    prefixIcon: Icon(Icons.person),
                    helperText: 'Texto de ayuda del input',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Esta vacio';
                    }
                  },
                  onChanged: (value) {
                    print('mi campo cambio, su valor es $value');
                  },
                  onSaved: (newValue) {
                    print("onSaved $newValue");
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Telefono',
                    hintText: 'Ingrese su telefono',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Esta vacio';
                    }
                  },
                  onSaved: (newValue) {
                    print("Formulario de usuario $newValue");
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Correo',
                    hintText: 'Ingrese su correo',
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Esta vacio';
                    }
                  },
                  onSaved: (newValue) {
                    print("Formulario de usuario $newValue");
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: 'Ingresa tu contraseña',
                    hintStyle: TextStyle(fontSize: 16),

                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                    filled: true,
                    contentPadding: EdgeInsets.all(16),
                    //fillColor: Colors.grey.shade300,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: procesarFormulario,
                    child: Text('Enviar'),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
