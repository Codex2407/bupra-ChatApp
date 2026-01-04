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

Detaylı ve güncel kurallar için [FIRESTORE_SECURITY_RULES.md](FIRESTORE_SECURITY_RULES.md) dosyasına bakın.

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

### 5. Firestore Index Oluşturun

İlk çalıştırmada index hatası alabilirsiniz:

1. Hata mesajındaki mavi linke tıklayın
2. "Create Index" butonuna tıklayın
3. Index oluşturulana kadar bekleyin (1-2 dakika)
4. Index "Enabled" olduğunda uygulamayı yeniden başlatın

### 6. Uygulamayı Çalıştırın

```bash
flutter run
```

## ✅ Kontrol Listesi

- [ ] `flutter pub get` çalıştırıldı
- [ ] Firebase projesi oluşturuldu
- [ ] Android uygulaması eklendi
- [ ] `google-services.json` yerleştirildi
- [ ] Firebase Authentication etkinleştirildi
- [ ] Firestore Database oluşturuldu
- [ ] Firebase Storage etkinleştirildi
- [ ] Güvenlik kuralları ayarlandı
- [ ] Firestore Index oluşturuldu
- [ ] Uygulama çalışıyor

## 🐛 Sorun mu Yaşıyorsunuz?

- **"FirebaseApp not initialized"**: `main.dart`'da `Firebase.initializeApp()` çağrısının olduğundan emin olun
- **"Permission denied"**: Güvenlik kurallarını kontrol edin
- **"Index required"**: Hata mesajındaki linke tıklayarak index oluşturun
- **Build hatası**: `flutter clean && flutter pub get` çalıştırın

Detaylı sorun giderme için [FIREBASE_MANUAL_SETUP.md](FIREBASE_MANUAL_SETUP.md) dosyasına bakın.

## 📚 Daha Fazla Bilgi

- [README.md](README.md) - Genel proje bilgileri
- [FIREBASE_MANUAL_SETUP.md](FIREBASE_MANUAL_SETUP.md) - Detaylı Firebase kurulum rehberi

---

**Hazırsınız!** 🎉 Artık Bupra uygulamanızı kullanmaya başlayabilirsiniz.

