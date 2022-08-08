import 'package:flutter/material.dart';
import 'package:rx_command/rx_command.dart';

import 'dropdown_alert_model.dart';

class DropdownAlertController {
  static DropdownAlertController? _instance;

  static DropdownAlertController get instance =>
      _instance ??= DropdownAlertController._();

  factory DropdownAlertController() => instance;

  late RxCommand<DropdownAlertModel, DropdownAlertModel> stateChangeCommand;

  DropdownAlertController._() {
    stateChangeCommand = RxCommand.createSync((param) => param,
        emitLastResult: true, initialLastResult: DropdownAlertModel.none());
  }

  ///Show alert message
  void showAlert(String message,
      {TextStyle? mesStyle,
      int initAnimTime = 350,
      int reverseAnimTime = 350,
      int limitedTimeShow = 2000,
      DropdownStyle dropdownStyle = DropdownStyle.none,
      DropdownPosition position = DropdownPosition.top,
      EdgeInsets? parentPadding,
      bool isReverseIconPosition = false,
      Color dropdownColor = Colors.transparent}) {
    if (!stateChangeCommand.lastResult!.state) {
      hideAlert();
    }
    DropdownAlertModel dropdownAlert = DropdownAlertModel.create(message,
        limitedTimeShow: limitedTimeShow,
        initAnimTime: initAnimTime,
        messageStyle: mesStyle,
        reverseAnimTime: reverseAnimTime,
        position: position,
        isReverseIconPosition: isReverseIconPosition,
        dropdownBGColor: dropdownColor,
        parentPadding: parentPadding);
    stateChangeCommand.execute(dropdownAlert);
  }

  ///Ẩn alert message
  void hideAlert() {
    final DropdownAlertModel dropdownAlert = DropdownAlertModel.none();
    stateChangeCommand.execute(dropdownAlert);
  }
}
