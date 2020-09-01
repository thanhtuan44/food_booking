import 'package:flutter/material.dart';
import 'package:food_booking/shared/app_colors.dart';
import 'dart:io';

import 'package:food_booking/shared/widget/keyboard_actions/keyboard_actions.dart';

class KeyboardLayoutBase extends StatelessWidget
{
  final List<FocusNode> nodes;
  final Widget child;
  KeyboardLayoutBase({@required this.nodes, @required this.child});

  KeyboardActionsConfig _buildKeyboardConfig(BuildContext context)
  {
    bool nextPrev = true;
    List<KeyboardAction> actions = [];
    if(this.nodes != null) {
      if(this.nodes.length < 2) {
        nextPrev = false;
      }
      this.nodes.fold(0, (prev, current) {
        actions.add(KeyboardAction(
            focusNode: current
        ));
      });
    }

    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL, // Limit to IOS Only
      keyboardBarColor: AppColors.colorKeyboardBackground,
      nextFocus: nextPrev,
      actions: actions,
    );
  }

  @override
  Widget build(BuildContext context)
  {
    if(this.nodes == null || this.nodes.length == 0) {
      return child;
    } else {
      return KeyboardActions(
          config: _buildKeyboardConfig(context),
          child: child
      );
    }
  }
}