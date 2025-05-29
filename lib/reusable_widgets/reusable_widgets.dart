import 'package:flutter/material.dart';

TextFormField reusableTextField(String text, IconData icon, bool isPasswordType, String errorMessage, TextEditingController controller) {
  return TextFormField(
    controller: controller,
    keyboardType: isPasswordType ? TextInputType.visiblePassword : TextInputType.emailAddress,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: false,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: Colors.white),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white),
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.3),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    onChanged: (String value) {

    },
    validator: (value) {
    return value!.isEmpty ? errorMessage : null;
    },
  );
}

Container signInSignUpButton(BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return Colors.black26;
          }
          return Colors.white;
        }),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      ),
      child: Text(
        isLogin ? 'LOG IN' : 'SIGN UP',
        style: const TextStyle(
          color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
        )
    ),
  );
}

