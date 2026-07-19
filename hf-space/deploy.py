"""Hugging Face Space dağıtım scripti.

GitHub Actions içinden çalışır: HF_TOKEN ile token sahibinin hesabında
(yoksa) gizli bir Docker Space oluşturur ve hf-space/ içeriğini yükler.
BUILD_REV dosyasına commit SHA'sı yazıldığı için her dağıtım Space'te
önbelleksiz yeniden kurulum tetikler (Dockerfile'daki COPY BUILD_REV katmanı).
"""

import os
from pathlib import Path

from huggingface_hub import HfApi

SPACE_NAME = "moneyprinterturbo"
SPACE_DIR = Path(__file__).resolve().parent


def main() -> None:
    token = os.environ["HF_TOKEN"]
    api = HfApi(token=token)
    owner = api.whoami()["name"]
    repo_id = f"{owner}/{SPACE_NAME}"

    api.create_repo(
        repo_id=repo_id,
        repo_type="space",
        space_sdk="docker",
        private=True,
        exist_ok=True,
    )

    revision = os.environ.get("GITHUB_SHA", "manual")
    (SPACE_DIR / "BUILD_REV").write_text(revision + "\n", encoding="utf-8")

    api.upload_folder(
        folder_path=str(SPACE_DIR),
        repo_id=repo_id,
        repo_type="space",
        commit_message=f"deploy {revision[:7]}",
    )
    print(f"Deployed: https://huggingface.co/spaces/{repo_id}")


if __name__ == "__main__":
    main()
