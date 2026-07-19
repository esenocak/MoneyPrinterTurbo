#!/usr/bin/env bash
set -e
cd /MoneyPrinterTurbo

# Space diski kalıcı olmadığı için config.toml her açılışta Space
# secret'larından yeniden üretilir. Anahtarları WebUI yerine Space
# ayarlarındaki Secrets bölümüne girin ki yeniden başlatmada kaybolmasın.
python3 - <<'PY'
import os

def toml_str(value: str) -> str:
    return '"' + value.replace("\\", "\\\\").replace('"', '\\"') + '"'

text = open("config.example.toml", encoding="utf-8").read()
text = text.replace('llm_provider = "moonshot"', 'llm_provider = "gemini"', 1)

gemini = os.environ.get("GEMINI_API_KEY", "").strip()
pexels = os.environ.get("PEXELS_API_KEY", "").strip()
pixabay = os.environ.get("PIXABAY_API_KEY", "").strip()
if gemini:
    text = text.replace('gemini_api_key = ""', f"gemini_api_key = {toml_str(gemini)}", 1)
if pexels:
    text = text.replace("pexels_api_keys = []", f"pexels_api_keys = [{toml_str(pexels)}]", 1)
if pixabay:
    text = text.replace("pixabay_api_keys = []", f"pixabay_api_keys = [{toml_str(pixabay)}]", 1)

open("config.toml", "w", encoding="utf-8").write(text)
print("config.toml generated from Space secrets")
PY

exec streamlit run webui/Main.py \
    --server.address=0.0.0.0 \
    --server.port=7860 \
    --server.enableCORS=True \
    --browser.gatherUsageStats=False \
    --client.toolbarMode=minimal \
    --server.showEmailPrompt=False \
    --server.headless=True
