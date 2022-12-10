# flutter_hello

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)

- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the

[online documentation](https://docs.flutter.dev/), which offers tutorials,

samples, guidance on mobile development, and a full API reference.

# Configuracion de Aplicacion

## Introduccion

Para configurar la aplicacion se puede seguir la guia de flutter en https://docs.flutter.dev/deployment/android#reviewing-the-build-configuration

## Generar Icono de la aplicacion

Cambiar el icono de la carpeta de assets/icon/icon.png y correr el comando

La imagen debe de ser de 1024 x 1024

flutter pub get

flutter pub run flutter_launcher_icons:main

https://pub.dev/packages/flutter_launcher_icons 0.11.0

## Cambiar splashscreen de la aplicacion

https://pub.dev/packages/flutter_native_splash

    flutter pub run flutter_native_splash:create

### Android

Ir a los archivos launch_background.xml de las siguientes ubicaciones y realizar los cambios

> android/app/src/main/res

en las carpetas drawable y drawable-21

### IOS

Cambiar los 3 archivos LaunchImage.png, LaunchImage@2x.png y LaunchImage@3x.png por sus correspondientes. Estos se encuentran en

> ios/Runner/Assets.xcassets/LaunchImage.imageset
> Portrait

1x = 768 x 1024

2x = 1536 x 2048

3x = 2304 x 3072

Landscape

1x = 1024 x 768

2x = 2048 x 1536

3x = 3072 x 2304

## Cambiar nombre de la app

Para cambiar el nombre de la aplicacion deberemos de seguir los siguientes pasos

### Android

Ir a **android -> app -> src -> main** y abrir el archivo **AndroidManifest.xml**. Buscar la etiqueta de **android:label** y colorcar el nombre de nuestra aplicacion con la que se mostrara a la hora de instalarse.

Si nuestra aplicacion utilizara internet se debera de agregar el permiso para internet

    <uses-permission  android:name="android.permission.INTERNET"  />

### IOS

Para colocar el nombre en IOS se debe de buscar el archivo **Info.plist** dentro de la carpeta **_ios/Runner/_** y buscar el siguiente nodo para cambiar el nombre de la aplicacion.

    <key>CFBundleName</key>
    <string>**your_app_name**</string>

## Build de Aplicacion

Para generar el build de la aplicacion se debe de ejecutar el siguiente comando

    flutter build apk --release
    flutter build appbundle --release

Dependiendo el tipo se puede optar por --release, --profile o --debug. El release genera un apk con menor peso

### Documentacion

https://docs.flutter.dev/deployment/android

### Analisis de package

Se puede realizar un analisis de tamaño ejecutando el siguiente comando
flutter build apk --analyze-size

Flutter requiere que se especifique el objetivo de la plataforma, quedando

flutter build apk --analyze-size --target-platform=android-x64
