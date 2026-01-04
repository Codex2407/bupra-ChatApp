# Logo Kurulum Rehberi

Uygulama logosu `assets/images/logo.png` konumunda bulunmaktadır ve uygulamanın tüm ekranlarında kullanılmaktadır.

## Mevcut Kullanım

Logo şu ekranlarda kullanılıyor:
- ✅ Splash Screen
- ✅ Login/Register Screen
- ✅ Profile Screen (kullanıcı fotoğrafı yoksa)

## Android App Icon Kurulumu

Android uygulama ikonunu logo'dan oluşturmak için:

### Yöntem 1: Manuel (Önerilen)

1. `android/app/logo.png` dosyasını kullanarak farklı boyutlarda icon'lar oluşturun:
   - `mipmap-mdpi/ic_launcher.png` - 48x48 px
   - `mipmap-hdpi/ic_launcher.png` - 72x72 px
   - `mipmap-xhdpi/ic_launcher.png` - 96x96 px
   - `mipmap-xxhdpi/ic_launcher.png` - 144x144 px
   - `mipmap-xxxhdpi/ic_launcher.png` - 192x192 px

2. Bu dosyaları `android/app/src/main/res/` altındaki ilgili klasörlere kopyalayın.

### Yöntem 2: flutter_launcher_icons Paketi (Otomatik)

1. `pubspec.yaml` dosyasına ekleyin:
```yaml
dev_dependencies:
  flutter_launcher_icons: ^0.13.1

flutter_launcher_icons:
  android: true
  image_path: "assets/images/logo.png"
  adaptive_icon_background: "#0F0F14"
  adaptive_icon_foreground: "assets/images/logo.png"
```

2. Çalıştırın:
```bash
flutter pub get
flutter pub run flutter_launcher_icons
```

## iOS App Icon Kurulumu

iOS için logo'yu app icon olarak kullanmak:

1. `ios/Runner/Assets.xcassets/AppIcon.appiconset/` klasörüne logo'yu farklı boyutlarda ekleyin.
2. Gerekli boyutlar:
   - 20x20, 40x40, 60x60 (iPhone)
   - 29x29, 58x58, 87x87 (Settings)
   - 40x40, 80x80, 120x120 (App)
   - 76x76, 152x152, 167x167 (iPad)

## Logo Widget Kullanımı

Logo'yu kod içinde kullanmak için `AppLogo` widget'ını kullanabilirsiniz:

```dart
import '../widgets/app_logo.dart';

// Kullanım
AppLogo(size: 80)  // 80x80 boyutunda
AppLogo(size: 120, showShadow: false)  // Gölge olmadan
```

## Notlar

- Logo dosyası `assets/images/logo.png` konumunda olmalıdır
- `pubspec.yaml` dosyasında asset olarak tanımlanmıştır
- Logo yüklenemezse otomatik olarak fallback icon gösterilir

