#!/data/data/com.termux/files/usr/bin/bash
# Publica esta pasta como um NOVO repositório na conta escolhida durante gh auth login.
set -euo pipefail
cd "$(dirname "$0")"
REPO="ampm-instalacao-eletrica"
if [ ! -f index.html ] || [ ! -f assets/logo-ampm.webp ]; then
  echo 'ERRO: extraia todo o ZIP, mantendo a pasta assets junto de index.html.' >&2
  exit 1
fi
if ! command -v pkg >/dev/null 2>&1; then
  echo 'Este script foi preparado para o Termux (Android).' >&2
  exit 1
fi
pkg install -y git gh
if ! gh auth status >/dev/null 2>&1; then
  echo 'Entre na sua conta GitHub quando o navegador solicitar.'
  gh auth login --hostname github.com --git-protocol https --web
fi
USER=$(gh api user --jq .login)
echo "GitHub conectado: $USER"
if gh repo view "$USER/$REPO" >/dev/null 2>&1; then
  echo "O repositório $USER/$REPO já existe. Para não modificar nada, parei aqui." >&2
  exit 1
fi
# Usa URL completa para a imagem de compartilhamento em WhatsApp/redes sociais.
SITE_IMAGE="https://${USER}.github.io/${REPO}/assets/logo-ampm.webp"
sed -i "s@content="assets/logo-ampm.webp"@content="${SITE_IMAGE}"@" index.html
if [ ! -d .git ]; then
  git init -b main
fi
git config user.name "$(gh api user --jq '.name // .login')"
git config user.email "$(gh api user --jq '.email // empty')" 2>/dev/null || true
# Evita impedir o commit caso o GitHub não disponibilize e-mail público.
if [ -z "$(git config user.email || true)" ]; then
  ID=$(gh api user --jq .id)
  git config user.email "${ID}+${USER}@users.noreply.github.com"
fi
git add index.html assets README.md publicar-termux.sh
git commit -m "Criar site AM PM Instalacao Eletrica" >/dev/null
# Esta operação cria APENAS um novo repositório público.
gh repo create "$REPO" --public --source . --remote origin --push
# Habilita GitHub Pages na branch main. Se já estiver configurado, não falha a publicação.
if ! gh api --method POST "repos/$USER/$REPO/pages" -f 'source[branch]=main' -f 'source[path]=/' >/dev/null 2>&1; then
  echo 'GitHub Pages ainda precisa ser ativado manualmente em Settings > Pages.'
fi
printf '\nREPOSITÓRIO: https://github.com/%s/%s\n' "$USER" "$REPO"
printf 'SITE (após a implantação do Pages): https://%s.github.io/%s/\n' "$USER" "$REPO"
