import 'package:flutter/material.dart';
import 'package:zemoga_posts/app/theme/colors.dart';

///{@template app_dialog}
/// A customized dialog for this app.
/// {@endtemplate}
class AppDialog extends StatelessWidget {
  ///{@macro app_dialog}
  const AppDialog({
    super.key,
    required this.title,
    required this.description,
    required this.onTapConfirm,
  });

  /// Title to be displayed in the dialog.
  final String title;

  /// Description to be displayed in the dialog.
  final String description;

  /// Callback to be called when confirm is tapped
  final VoidCallback onTapConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: [
        TextButton(
          child: const Text('Cancel', style: TextStyle(color: AppColor.blue90)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text(
            'Confirm',
            style: TextStyle(color: AppColor.blue90),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            onTapConfirm();
          },
        ),
      ],
    );
  }
}
