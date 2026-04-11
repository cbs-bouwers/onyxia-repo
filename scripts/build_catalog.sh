#!/usr/bin/env bash
#
# Build catalog index
#

# Quit script if a step fails (exit-on-error mode)
set -e

usage() {
  name=$(basename "$0")
  
  echo "Build Catalog"
  echo ""
  echo "Usage:"
  echo "  $name [CATALOG]"
  echo "  $name -h | --help"
  echo ""
  echo "Options:"
  echo "  -h --help  Show this screen."
  echo "  CATALOG    Name of catalog to update [default: 'default']."
  echo ""
  exit 1
}

# Initialise arguments
catalog=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
      usage
      ;;
    -*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      if [[ -z "$catalog" ]]; then
        catalog="$1"
        shift
      else
        echo "Error: too many arguments"
        exit 1
      fi
  esac
done

if [[ -z "$catalog" ]]; then
  catalog="default"
fi

catalog_path="docs/${catalog}"

# Check if catalog exists
if [[ ! -d "${catalog_path}" ]]; then
  echo "❌ Error: Catalog '${catalog}' not found in ${catalog_path}"
  exit 1
fi

echo "👷‍♀️ Update catalog '${catalog}'"

echo "📚 Updating repository index..."
helm repo index "${catalog_path}" --url "https://cbs-bouwers.github.io/onyxia-repo/${catalog}"

echo "✅ Catalog '${catalog}' has been successfully updated!"

