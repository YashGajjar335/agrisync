import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class WaitingScreen extends StatelessWidget {
  final String? message;
  const WaitingScreen({super.key, this.message});

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
          TextLato(text: AppLocalizations.of(context)!.somethingWrong),
        ],
      ),
    );
  }
}
