import 'package:flutter/material.dart';

class SignUpText extends StatelessWidget {
  const SignUpText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '¿Aún sin cuenta? ',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge!.color,
              fontWeight: FontWeight.bold,
            ),
          ),
          WidgetSpan(
            child: GestureDetector(
              onTap:() {
                
              },
              child: const Text(
                'Crea una cuenta',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold
                ),            
              ),
            )
          ),
        ],
      ),
    );
  }
}
