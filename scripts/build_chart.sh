#!/usr/bin/env bash
#
# Build chart and update chart repository.
# Run from the root directory with the name of the chart (i.e. `my-chart`).
#
# This script automates the following steps:
#   1. Linting (skip with `--no-lint`)
#   2. OPTIONAL Update chart dependencies (enable with `--update-deps`)
#   3. Delete previous version of chart in `docs` folder
#   4. Package chart and save in `docs` folder
#   5. Update chart repository index (`docs/index.yaml`)
# 
# Usage: ./scripts/build_chart.sh my-chart [--no-lint] [--update-deps]
#
# 

# Quit script if a step fails (exit-on-error mode)
set -e

usage() {
  name=$(basename "$0")
  
  echo "Build Chart"
  echo ""
  echo "Usage:"
  echo "  $name [--no-lint] [--update] [--catalog=CATALOG] CHART"
  echo "  $name -h | --help"
  echo ""
  echo "Arguments:"
  echo "  CHART                Name of chart to build"
  echo ""
  echo "Options:"
  echo "  -h --help            Show this screen."
  echo "  --no-lint            Do not run 'chart lint' on chart files."
  echo "  --update             Update catalog index."
  echo "  --catalog=CATALOG    Name of catalog to save chart in [default: 'default']."
  echo ""
  exit 1
}

# Initialise arguments
chart=""
catalog="default"
no_lint=0
do_update=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --no-lint)
      no_lint=1
      shift
      ;;
    --update)
      do_update=1
      shift
      ;;
    --catalog=*)
      catalog="${1#*=}"
      shift
      ;;
    -h|--help)
      usage
      ;;
    -*)
      echo "Unknown option: $1"
      exit 1
      ;;
    *)
      if [[ -z "$chart" ]]; then
        chart="$1"
        shift
      else
        echo "Error: too many arguments"
        exit 1
      fi
      ;;
  esac
done

# Check if chart name is provided
if [[ -z "$chart" ]]; then
  echo "❌ Error: Missing required chart name"
  exit 1
fi

chart_path="charts/${chart}"

# Check if chart exists
if [[ ! -d "${chart_path}" ]]; then
  echo "❌ Error: Chart '${chart}' not found in ${chart_path}"
  exit 1
fi

catalog_path="docs/${catalog}"

# Check if catalog exists
if [[ ! -d "${catalog_path}" ]]; then
  echo "❌ Error: Catalog '${catalog}' not found in ${catalog_path}"
  exit 1
fi

echo "👷‍♀️ Build chart '${chart}' for catalog '${catalog}'"

# Step 1: Linting (unless skipped)
if [[ $no_lint -eq 0 ]]; then
  echo "👮 Linting chart..."
  helm lint "${chart_path}"
else
  echo "⚠️ Skipping linting (you've set --no-lint to skip)"
fi

# Step 2: Dependency update (unless skipped)
if [[ $do_update -eq 1 ]]; then
  echo "🔁 Updating dependencies..."
  helm dependency update "${chart_path}"
else
  echo "⚠️ Skipping dependency update (use --update to update chart dependencies)"
fi

# Step 3: Clean existing packages
echo "🗑️ Cleaning existing packages..."
find "${catalog_path}" -maxdepth 1 -type f -name "*${chart}*.tgz" -exec rm -f {} \+

# Step 4: Package chart
echo "📦 Packaging chart..."
helm package "${chart_path}" -d "${catalog_path}"

# Step 5: Update repository index
echo "📚 Updating repository index..."
helm repo index "${catalog_path}" --url "https://cbs-bouwers.github.io/onyxia-repo/${catalog}"

echo "✅ Chart '${chart}' has been successfully built!"

