import 'package:flutter/material.dart';

class DropdownAlertModel {
  DropdownPosition position = DropdownPosition.top;

  ///Nội dung message show
  String message = "";

  TextStyle? messageStyle;

  bool state = false;

  Color dropdownBGColor = Colors.transparent;

  ///Using Millisecond
  int limitedTimeShow = 2000;

  int initAnimTime = 350;

  int reverseAnimTime = 350;

  DropdownAlertModel();

  DropdownAlertModel.create(this.message,
      {this.messageStyle,
      this.limitedTimeShow = 2000,
      this.initAnimTime = 350,
      this.reverseAnimTime = 350,
      this.position = DropdownPosition.top,
      this.parentPadding,
      this.isReverseIconPosition = false,
      this.dropdownBGColor = Colors.transparent})
      : state = true;

  DropdownAlertModel.none() : state = false;

  bool isReverseIconPosition = false;

  EdgeInsets? parentPadding;
}

enum DropdownPosition { top, center, bottom }

enum DropdownState { show, hide, none }

enum DropdownStyle { success, error, pending, info, none }
