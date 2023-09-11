import 'package:fisioflex_mobile/widgets/forms_inputs.dart';
import 'package:flutter/material.dart';

class WarningDialogWidget extends StatefulWidget {
  final String title;
  final String description;
  final Function() onTap;

  const WarningDialogWidget(
      {Key? key,
      required this.title,
      required this.description,
      required this.onTap})
      : super(key: key);

  @override
  _WarningDialogWidgetState createState() => _WarningDialogWidgetState();
}

class _WarningDialogWidgetState extends State<WarningDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      contentPadding: const EdgeInsets.all(0),
      content: Container(
        padding: EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 30,
              child: Icon(
                Icons.warning,
                size: 45,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              widget.title,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 15),
            Text(
              widget.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            buttonSubmitWidget('Aceptar', () {
              widget.onTap();
            }, context)
          ],
        ),
      ),
    );
  }
}
