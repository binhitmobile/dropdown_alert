<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

TODO: Put a short description of the package here that helps potential users know whether this
package might be useful for them.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to start using the package.

## Usage

- Import

```dart
import 'package:dropdown_alert/dropdown_alert.dart';
```

- Init Widget

```dart
class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (ctx, child) {
        return Stack(
          children: [
            child!
            const DropdownAlertWidget(),
          ],
        );
      },
    );
  }
}
```

- Init controller:

```dart
///Show alert
void showAlert(String message,
    {TextStyle? mesStyle,
      int initAnimTime = 350,
      int reverseAnimTime = 350,
      int limitedTimeShow = 2000,
      DropdownStyle dropdownStyle = DropdownStyle.none,
      DropdownPosition position = DropdownPosition.top,
      EdgeInsets? parentPadding,
      bool isReverseIconPosition = false,
      Color dropdownColor = Colors.transparent});

///Hide Alert
void hideAlert();
```
