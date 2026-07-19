FROM python:3.11-slim-bookworm

RUN apt-get update && apt-get install -y --no-install-recommends \
        git ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# BUILD_REV her dağıtımda değişir; böylece aşağıdaki clone katmanı asla
# eski Docker önbelleğinden gelmez ve Space her zaman güncel kodla kurulur.
COPY BUILD_REV /tmp/BUILD_REV
RUN git clone --depth 1 https://github.com/esenocak/MoneyPrinterTurbo.git /MoneyPrinterTurbo \
    && rm -rf /MoneyPrinterTurbo/.git

WORKDIR /MoneyPrinterTurbo
ENV PYTHONPATH=/MoneyPrinterTurbo \
    HOME=/MoneyPrinterTurbo

RUN pip install --no-cache-dir --retries 3 --timeout 60 -r requirements.txt

COPY entrypoint.sh /entrypoint.sh
# HF Spaces konteyneri root olmayan bir kullanıcıyla çalıştırabilir;
# uygulama config.toml ve storage/ altına yazdığı için dizin herkese açık olmalı.
RUN chmod +x /entrypoint.sh \
    && mkdir -p /MoneyPrinterTurbo/storage \
    && chmod -R 777 /MoneyPrinterTurbo

EXPOSE 7860
CMD ["/entrypoint.sh"]
