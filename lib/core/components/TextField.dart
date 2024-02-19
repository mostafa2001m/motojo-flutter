// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';


  textFieldCreation(TextEditingController controller, String labelText, {
    bool isPassword = false, bool isNumber = false,Icon? exm}) {
  return TextFormField(
    controller: controller,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Please enter $labelText';
      }
      if (isNumber && double.tryParse(value) == null) {
        return 'Please enter a valid number';
      }
      return null;
    },
    
    obscureText: isPassword,
    keyboardType: isNumber ? TextInputType.number : TextInputType.text,
    decoration: InputDecoration(
      
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      contentPadding: const EdgeInsets.all(16.0),
      prefixIcon: exm,
      suffixIcon: isPassword
          ? IconButton(
        icon: const Icon(
          Icons.visibility,
        ),
        onPressed: () {

        },
      )
          : null,
          
    ),
  );
}
