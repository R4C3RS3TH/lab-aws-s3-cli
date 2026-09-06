#!/usr/bin/env bash
set -euo pipefail

BUCKET="${1:?Uso: $0 <bucket>}"

if ! aws s3api head-bucket --bucket "$BUCKET" >/dev/null 2>&1; then
  echo "El bucket $BUCKET no existe. Nada que limpiar."
  exit 0
fi

read -p "Se eliminará s3://$BUCKET y TODO su contenido. ¿Continuar? (y/N): " respuesta
if [[ "$respuesta" != "y" && "$respuesta" != "Y" ]]; then
  echo "Operación cancelada."
  exit 0
fi

aws s3 rb "s3://$BUCKET" --force
echo "✔ Bucket $BUCKET eliminado"
