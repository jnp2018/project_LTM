import 'package:flutter/material.dart';

class buttonlogin_registration extends StatelessWidget {
  buttonlogin_registration({this.tittle, this.coulour, required this.onPress});
  final String? tittle;
  final Color? coulour;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: coulour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPress,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            tittle!,
          ),
        ),
      ),
    );
  }
}