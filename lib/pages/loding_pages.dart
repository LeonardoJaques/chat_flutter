import 'package:flutter/material.dart';

class LoadingPages extends StatelessWidget {
  const LoadingPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            backgroundColor: Colors.white,
          ),
          const SizedBox(height: 20),
          Text(
            'Carregando...',
            style: TextStyle(
              color: Theme.of(context).primaryTextTheme.titleMedium?.color,
              fontSize: 24,
            ),
          ),
          const CircularProgressIndicator(),
        ],
      )),
    );
  }
}
