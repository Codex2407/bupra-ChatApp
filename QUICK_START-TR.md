# 🚀 Hızlı Başlangıç Rehberi

Bupra uygulamasını hızlıca çalıştırmak için bu adımları takip edin.

## ⚡ 5 Dakikada Başlayın

### 1. Bağımlılıkları Yükleyin

```bash
flutter pub get
```

### 2. Firebase Kurulumu

Detaylı kurulum için [FIREBASE_MANUAL_SETUP.md](FIREBASE_MANUAL_SETUP.md) dosyasına bakın.

**Hızlı Adımlar:**

1. Firebase Console'da proje oluşturun: https://console.firebase.google.com
2. Android uygulaması ekleyin (Package: `com.akdbt.bupra`)
3. `google-services.json` dosyasını indirip `android/app/` klasörüne yerleştirin

### 3. Firebase Servislerini Etkinleştirin

Firebase Console'da ([console.firebase.google.com](https://console.firebase.google.com/)):

1. **Authentication** > **Sign-in method**:
   - ✅ Email/Password → Enable

2. **Firestore Database**:
   - Create database → Production mode → Location seçin → Enable

3. **Storage**:
   - Get started → Production mode → Location seçin → Done

### 4. Güvenlik Kurallarını Ayarlayın

Detaylı kurallar için [FIREBASE_MANUAL_SETUP.md](FIREBASE_MANUAL_SETUP.md) dosyasına bakın.

**Firestore Rules** (Firestore Database > Rules):

Detaylı ve güncel kurallar için [FIRESTORE_SECURITY_RULES.md](FIRESTORE_SECURITY_RULES.md) veya [FIRESTORE_SECURITY_RULES-TR.md](FIRESTORE_SECURITY_RULES-TR.md) dosyasına bakın.

**Önemli:** Firestore Security Rules'ı ayarlamadan uygulama çalışmayacaktır.

**Storage Rules** (Storage > Rules):
```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /chats/{chatId}/{fileName} {
      allow read, write: if request.auth != null;
    }
  }
}
```

### 5. Uygulamayı Çalıştırın

```bash
flutter run
```

## 📝 Önemli Notlar

- **Discord-Style Kullanıcı Adları** - Aynı username'i birden fazla kullanıcı seçebilir, sistem otomatik unique sayı ekler (örn: bugra#1234, bugra#1256)
- **Email benzersizliği zorunludur** - Bir email sadece bir hesap için kullanılabilir
- **Display Name benzersizliği** - Her display name (username#number) unique olmalıdır

## 🔍 Sorun Giderme

### Firestore Index Hatası

Uygulama ilk çalıştırıldığında Firestore index hatası alabilirsiniz:

1. Hata mesajındaki mavi linke tıklayın
2. Firebase Console'da "Create Index" butonuna tıklayın
3. Index oluşturulana kadar bekleyin (1-2 dakika)
4. Index "Enabled" olduğunda uygulamayı yeniden başlatın

### Display Name Hatası

Eğer "kullanıcı adı oluşturulamadı" hatası alıyorsanız:
- Tekrar deneyin (sistem otomatik olarak unique sayı bulacaktır)
- Farklı bir base username deneyin

## 📚 Daha Fazla Bilgi

- [FIREBASE_MANUAL_SETUP.md](FIREBASE_MANUAL_SETUP.md) - Detaylı Firebase kurulumu
- [FIRESTORE_SECURITY_RULES.md](FIRESTORE_SECURITY_RULES.md) - Güvenlik kuralları (İngilizce)
- [FIRESTORE_SECURITY_RULES-TR.md](FIRESTORE_SECURITY_RULES-TR.md) - Güvenlik kuralları (Türkçe)
- [LOGO_SETUP.md](LOGO_SETUP.md) - Logo kurulum rehberi

