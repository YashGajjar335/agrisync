import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

class WaitingScreenWithWarnning extends StatelessWidget {
  const WaitingScreenWithWarnning({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
          const TextLato(text: "Something wrong..!"),
        ],
      ),
    );
  }
}
