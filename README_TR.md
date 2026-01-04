# Bupra - Mini Chat Uygulaması

Bupra, Flutter ve Firebase kullanılarak geliştirilmiş minimal ve üretim için hazır bir mesajlaşma uygulamasıdır.

## 🚀 Özellikler

- ✅ **Kimlik Doğrulama**: Email/şifre ile giriş
- ✅ **Discord-Style Kullanıcı Adları**: Aynı username'i birden fazla kullanıcı seçebilir, sistem otomatik unique sayı ekler (örn: bugra#1234, bugra#1256)
- ✅ **Kullanıcılar ve Arkadaşlar**: Kullanıcı arama, arkadaş ekleme
- ✅ **Birebir Sohbet**: Gerçek zamanlı mesajlaşma
- ✅ **Grup Sohbeti**: Grup oluşturma ve grup mesajlaşması
- ✅ **Resim Mesajlaşması**: Galeriden resim seçme ve gönderme
- ✅ **Premium Dark Theme**: Modern ve şık karanlık tema

## 📋 Gereksinimler

- Flutter SDK (3.10.4 veya üzeri)
- Dart SDK
- Firebase hesabı
- Android Studio / Xcode (platform bağımlı geliştirme için)

## 🔧 Kurulum

### 1. Projeyi Klonlayın

```bash
git clone <repository-url>
cd bupra
```

### 2. Bağımlılıkları Yükleyin

```bash
flutter pub get
```

### 3. Firebase Kurulumu

Detaylı Firebase kurulum talimatları için [FIREBASE_MANUAL_SETUP.md](FIREBASE_MANUAL_SETUP.md) dosyasına bakın.

**Hızlı Başlangıç:**

1. Firebase Console'da yeni bir proje oluşturun
2. Android uygulaması ekleyin (Package: `com.akdbt.bupra`)
3. `google-services.json` dosyasını indirip `android/app/` klasörüne yerleştirin
4. Firebase servislerini etkinleştirin:
   - Authentication (Email/Password)
   - Cloud Firestore
   - Firebase Storage
5. Firestore Security Rules'ı ayarlayın (detaylar için [FIRESTORE_SECURITY_RULES.md](FIRESTORE_SECURITY_RULES.md) dosyasına bakın)
6. Firestore Index oluşturun (hata mesajındaki linke tıklayarak)

### 4. Uygulamayı Çalıştırın

```bash
flutter run
```

## 📱 Platform Yapılandırması

### Android

- **Package Name**: `com.akdbt.bupra`
- Minimum SDK: 21
- Target SDK: 34

### iOS

- **Bundle Identifier**: `com.akdbt.bupra` (Xcode'da ayarlayın)
- Minimum iOS: 12.0

## 🏗️ Proje Yapısı

```
lib/
├── main.dart                    # Uygulama giriş noktası
├── models/                      # Veri modelleri
│   ├── user_model.dart
│   ├── chat_model.dart
│   └── message_model.dart
├── services/                    # Firebase servisleri
│   ├── auth_service.dart
│   ├── firestore_service.dart
│   └── storage_service.dart
├── screens/                     # Ekranlar
│   ├── login_screen.dart
│   ├── home_screen.dart
│   ├── friends_screen.dart
│   ├── chat_screen.dart
│   └── create_group_screen.dart
└── widgets/                     # Widget'lar
    └── message_bubble.dart
```

## 🔍 Firestore Index

Uygulama ilk çalıştırıldığında Firestore index hatası alabilirsiniz. Bu normaldir:

1. Hata mesajındaki mavi linke tıklayın
2. Firebase Console'da "Create Index" butonuna tıklayın
3. Index oluşturulana kadar bekleyin (1-2 dakika)
4. Index "Enabled" olduğunda uygulamayı yeniden başlatın

**Index Detayları:**
- Collection: `chats`
- Fields: `members` (Array) + `updatedAt` (Descending)

## 🔐 Firebase Güvenlik Kuralları

Detaylı güvenlik kuralları için [FIRESTORE_SECURITY_RULES.md](FIRESTORE_SECURITY_RULES.md) dosyasına bakın.

**Önemli:** Firestore Security Rules'ı Firebase Console'da ayarlamadan uygulama çalışmayacaktır.

## 📊 Veri Modeli

### Users Collection
```
users/{uid}
  - username: string (base username, #number olmadan)
  - displayName: string (full display name, username#number formatında)
  - email: string
  - photoUrl: string (optional)
```

### Display Names Collection
```
displayNames/{normalizedDisplayName}
  - uid: string
  - displayName: string (username#number)
  - createdAt: timestamp
```

### Friends Collection
```
friends/{uid}/friends/{friendUid}
  - addedAt: timestamp
```

### Chats Collection
```
chats/{chatId}
  - isGroup: boolean
  - name: string (optional, for groups)
  - members: array[string]
  - lastMessage: string (optional)
  - updatedAt: timestamp
```

### Messages Subcollection
```
chats/{chatId}/messages/{messageId}
  - senderId: string
  - text: string (optional)
  - imageUrl: string (optional)
  - createdAt: timestamp
```

## 🛠️ Geliştirme

### Kod Yapısı

- **Services**: Tüm Firebase işlemleri servis sınıflarında toplanmıştır
- **Models**: Type-safe veri modelleri Firestore serileştirmesi ile
- **Screens**: Her ekran kendi dosyasında
- **Widgets**: Yeniden kullanılabilir UI bileşenleri

### Test Etme

```bash
flutter test
```

## 📝 Lisans

Bu proje özel bir projedir.

## 🤝 Katkıda Bulunma

Katkılarınızı bekliyoruz! Lütfen pull request göndermeden önce değişikliklerinizi test edin.

## 📞 İletişim

Sorularınız için issue açabilirsiniz.

---

**Not**: Bu uygulama eğitim ve geliştirme amaçlıdır. Üretim ortamında kullanmadan önce güvenlik ayarlarını gözden geçirin.
