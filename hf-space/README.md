---
title: MoneyPrinterTurbo
emoji: 🎬
colorFrom: blue
colorTo: green
sdk: docker
app_port: 7860
pinned: false
---

# MoneyPrinterTurbo — Hugging Face Space

Bu Space, [esenocak/MoneyPrinterTurbo](https://github.com/esenocak/MoneyPrinterTurbo)
forkundan otomatik olarak dağıtılır. Dağıtımı GitHub Actions workflow'u
(`.github/workflows/deploy-hf-space.yml`) yapar; fork'un `main` dalı her
güncellendiğinde Space en son kodla yeniden kurulur.

## Gerekli Space secret'ları

Space ayarlarından (Settings → Variables and secrets) şu secret'ları ekleyin:

| Secret | Zorunlu | Açıklama |
| --- | --- | --- |
| `GEMINI_API_KEY` | Evet | Google AI Studio'dan ücretsiz alınır: https://aistudio.google.com/app/apikey |
| `PEXELS_API_KEY` | Evet | Ücretsiz stok video için: https://www.pexels.com/api/ |
| `PIXABAY_API_KEY` | Hayır | İsteğe bağlı ikinci stok video kaynağı: https://pixabay.com/api/docs/ |

Secret'lar her açılışta `config.toml` içine yazılır. Anahtarları WebUI'dan
girmeyin — Space diski kalıcı olmadığı için yeniden başlatmada kaybolur.

## Notlar

- Seslendirme varsayılan olarak Edge TTS kullanır; anahtar gerektirmez.
- Üretilen videolar kalıcı değildir; üretim biter bitmez indirin.
- Space'i gizli (private) tutun: WebUI'da kimlik doğrulama yoktur.
