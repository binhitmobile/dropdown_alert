TODO: Put a short description of the package here that helps potential users know whether this
package might be useful for them.

## Features

- Show alert message on both Android - IOS
- Custom alert style.

## Getting started

TODO: List prerequisites and provide or point to information on how to start using the package.

## Usage

- Import

```dart
import 'package:dropdown_alert/dropdown_alert.dart';
```

- Init Widget

```dart
import 'package:dropdown_alert/dropdown_alert.dart';

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
- Controller
```dart
import 'package:dropdown_alert/dropdown_alert.dart';
///Show alert
DropdownAlertController().showAlert("Something");

///Hide Alert
DropdownAlertController().hideAlert();

```
