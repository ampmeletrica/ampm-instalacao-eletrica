# AM⚡PM Instalação Elétrica — Antes e Depois

Site estático e responsivo para Goiânia e região. Criado a partir do HTML e das **duas fotografias enviadas pelo cliente**.

## Arquivos
- `index.html`: site completo, incluindo CSS, links de WhatsApp, SEO e acessibilidade.
- `assets/fundo-ampm.webp`: imagem azul usada no plano de fundo principal.
- `assets/logo-ampm.webp`: logomarca preta e dourada no cabeçalho e na apresentação da empresa.
- `assets/favicon.svg`: ícone de raio para a aba do navegador.
- `publicar-termux.sh`: script opcional para criar um repositório novo e publicar o site via Termux.

## Contato
Todos os botões do WhatsApp usam `https://wa.me/5562999186824`, número **(62) 99918-6824**, informado pelo cliente. O site não usa servidor, Supabase ou formulário que armazena informações.

## Publicação pelo GitHub Pages
Crie um repositório público, envie o conteúdo desta pasta para a raiz da branch `main` e ative **Settings → Pages → Deploy from a branch → main / (root)**. Alternativamente, use o script Termux.

**Importante:** para pré-visualizações em redes sociais, após publicar é recomendável atualizar `og:image` no `index.html` com a URL HTTPS absoluta do logo hospedado no site.
