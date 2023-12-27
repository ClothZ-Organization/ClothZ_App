import 'package:auto_route/auto_route.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_bordered_content.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_button.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/optional.dart';
import 'package:flutter/material.dart';

import '../../../domain/alert_model.dart';

@RoutePage()
class AlertDialogPage extends StatelessWidget {
  final AlertModel model;
  const AlertDialogPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      backgroundColor: Colors.transparent,
      child: FCBorderedContent(
        radius: 16,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                model.title,
                style: const TextStyle(
                  fontFamily: 'WorkSans',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  height: 1.17,
                  color: Color(0xFF334155),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 8,
              ),
              Optional(
                optional: model.message,
                widgetBuilder: (message) => Text(
                  message,
                  style: const TextStyle(
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    height: 1.17,
                    color: Color(0xFF64748B),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Optional(
                    optional: model.onCancel,
                    widgetBuilder: (action) => Expanded(
                      child: FCButton(
                        text: action.title,
                        onTap: action.callback,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Optional(
                    optional: model.onConfirm,
                    widgetBuilder: (action) => Expanded(
                      child: FCButton(
                        text: action.title,
                        onTap: action.callback,
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
