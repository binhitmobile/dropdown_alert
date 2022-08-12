import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rx_command/rx_command.dart';

import 'dropdown_alert_controller.dart';
import 'dropdown_alert_model.dart';

class DropdownAlertWidget extends StatefulWidget {
  const DropdownAlertWidget({Key? key}) : super(key: key);

  @override
  State<DropdownAlertWidget> createState() => _DropdownAlertWidgetState();
}

class _DropdownAlertWidgetState extends State<DropdownAlertWidget> {
  RxCommandListener? alertStateListener;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      alertStateListener = RxCommandListener(
          DropdownAlertController().stateChangeCommand,
          onValue: (value) {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final kStatusBarHeight = MediaQuery.of(context).viewPadding.top;
    return StreamBuilder<DropdownAlertModel>(
        initialData: DropdownAlertController().stateChangeCommand.lastResult,
        stream: DropdownAlertController().stateChangeCommand,
        builder: (context, snapshot) {
          if (snapshot.data!.state) {
            return BodyAlertWidget(
              key: UniqueKey(),
              dropdownAlert: snapshot.data!,
              height:
                  snapshot.data?.dropdownHeight ?? kStatusBarHeight + kToolbarHeight,
            );
          }
          return const SizedBox();
        });
  }
}

class BodyAlertWidget extends StatefulWidget {
  final double height;
  final DropdownAlertModel dropdownAlert;

  const BodyAlertWidget(
      {Key? key, required this.height, required this.dropdownAlert})
      : super(key: key);

  @override
  State<BodyAlertWidget> createState() => _BodyAlertWidgetState();
}

class _BodyAlertWidgetState extends State<BodyAlertWidget>
    with TickerProviderStateMixin {
  Animation<dynamic>? animation;
  AnimationController? controller;
  Timer? _timer;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.dropdownAlert.initAnimTime),
        reverseDuration:
            Duration(milliseconds: widget.dropdownAlert.reverseAnimTime));
    if (widget.dropdownAlert.position == DropdownPosition.top) {
      animation = Tween(
              begin: Offset(0, -widget.height), end: const Offset(0, 0))
          .animate(CurvedAnimation(parent: controller!, curve: Curves.ease));
    } else if (widget.dropdownAlert.position == DropdownPosition.bottom) {
      animation = Tween(
              begin: Offset(0, widget.height), end: const Offset(0, 0))
          .animate(CurvedAnimation(parent: controller!, curve: Curves.ease));
    } else {
      animation = Tween(begin: 0.0, end: 1.0)
          .animate(CurvedAnimation(parent: controller!, curve: Curves.ease));
    }
    super.initState();
    controller!.addListener(
      () => setState(() {}),
    );
    controller!.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        DropdownAlertController().hideAlert();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller!.forward();
      startTimer();
    });
  }

  void cancelTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer?.cancel();
    }
  }

  void startTimer() {
    final limited = widget.dropdownAlert.limitedTimeShow;
    _timer = Timer.periodic(Duration(milliseconds: limited), (timer) {
      controller?.reverse();
    });
  }

  @override
  void dispose() {
    cancelTimer();
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color bgColor = widget.dropdownAlert.dropdownBGColor;
    final TextStyle mesStyle = widget.dropdownAlert.messageStyle ??
        Theme.of(context).textTheme.bodyText2!;
    final contentWidget = _BodyContentWidget(
        parentPadding: widget.dropdownAlert.parentPadding,
        isReverseIconPosition: widget.dropdownAlert.isReverseIconPosition,
        onClick: () {
          cancelTimer();
          controller?.reverse();
        },
        height: widget.height,
        bgColor: bgColor,
        icon: widget.dropdownAlert.icon,
        message: widget.dropdownAlert.message,
        mesStyle: mesStyle);
    if (widget.dropdownAlert.position == DropdownPosition.center) {
      return Align(
        alignment: Alignment.center,
        child: Transform.scale(
            alignment: Alignment.center,
            scale: animation!.value,
            child: contentWidget),
      );
    }
    final top =
        (widget.dropdownAlert.position == DropdownPosition.top) ? 0.0 : null;
    final bottom =
        (widget.dropdownAlert.position == DropdownPosition.bottom) ? 0.0 : null;
    return Positioned(
      top: top,
      bottom: bottom,
      left: 0,
      right: 0,
      child:
          Transform.translate(offset: animation!.value, child: contentWidget),
    );
  }
}

class _BodyContentWidget extends StatelessWidget {
  final VoidCallback? onClick;
  final double height;
  final Color bgColor;
  final String message;
  final TextStyle mesStyle;
  final EdgeInsets? parentPadding;
  final Widget? icon;
  final bool isReverseIconPosition;

  const _BodyContentWidget(
      {Key? key,
      this.onClick,
      required this.height,
      required this.bgColor,
      required this.message,
      required this.mesStyle,
      this.parentPadding,
      this.isReverseIconPosition = false,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick?.call();
      },
      child: Container(
        padding: parentPadding ?? const EdgeInsets.symmetric(horizontal: 8),
        width: MediaQuery.of(context).size.width,
        clipBehavior: Clip.antiAlias,
        height: height,
        decoration: BoxDecoration(
          color: bgColor,
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (!isReverseIconPosition) ...{
                icon ?? const SizedBox(),
              },
              Expanded(
                child: Text(
                  message,
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: mesStyle,
                ),
              ),
              if (isReverseIconPosition) ...{
                icon ?? const SizedBox(),
              },
            ],
          ),
        ),
      ),
    );
  }
}
