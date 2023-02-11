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

TODO: This package is used to manage sessions in flutter applications.

## Features

```dart
  call class FlutterSession() and chain it with the functions below
  use set('userName', userName) to save a variable
  use get('userName') to retrieve into a variable for your use
```

## Getting started

Link the class in the file it's required

## Usage

```dart
Future setLogin () async {
  await FlutterSession().set('userName', userName);
  await FlutterSession().set('password', password);
  }
  
Future setlLogin () async {
  await FlutterSession().get('userName');
  await FlutterSession().get('password');
  }
```

## Additional information

