# graphify-plugin

Marketplace de Claude con el plugin **graphify** ([Graphify-Labs/graphify](https://github.com/Graphify-Labs/graphify)), sincronizado cada semana con GitHub Actions.

- Agregar en Claude: marketplace `diegoasm11/graphify-plugin` → instalar **graphify**.
- Python requerido en la sesión: `pip install -U graphifyy`
- Sincronizar a mano: pestaña **Actions → Sync Graphify → Run workflow**.

Contenido de la skill: © Graphify-Labs, licencia MIT (ver `LICENSE-UPSTREAM`).

## context-mode

También incluye **context-mode** ([mksglu/context-mode](https://github.com/mksglu/context-mode)), copiado cada semana sin la carpeta `bin/` (solo tenía la statusline y claude.ai rechaza plugins con `bin/`). Licencia Elastic-2.0 (ver `plugins/context-mode/LICENSE`).
