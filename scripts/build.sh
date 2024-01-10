#!/usr/bin/env bash
#
# Generate and copy Olivero css and fonts to our theme for override.

_my_sub_theme=${1:-"olivero_sub_theme"}
_drupal_web_root=${2:-"web/core/themes/olivero"}

_my_sub_theme_path="web/themes/custom/${_my_sub_theme}"

if [ ! -d "${_drupal_web_root}" ]; then
  _drupal_web_root="web/core/themes/olivero"
fi

if [ ! -d "${_drupal_web_root}" ]; then
  echo "[ERROR] Can not find Olivero theme, are you at the root of Drupal?"
  exit 1
fi

if [ ! -d "${_my_sub_theme_path}" ]; then
  echo "[ERROR] Can not find Sub theme, did you create/copy in '${_my_sub_theme_path}'?"
  exit 1
fi

if ! command -v npm >/dev/null 2>&1; then
  echo "[ERROR] Can not find NPM, please install to use this script."
  exit 1
fi

if [ ! -d web/core/node_modules ]; then
  cd web/core && npm install
fi

cp -r "${_drupal_web_root}/css/" "${_drupal_web_root}/css.orig/"
cp -f "web/themes/custom/${_my_sub_theme}/css/variables.pcss.css" "${_drupal_web_root}/css/base/variables.pcss.css"

# Build the theme
cd web/core && npm run build:css

rm -rf "web/themes/custom/${_my_sub_theme}/css/base/*.css" "web/themes/custom/${_my_sub_theme}/css/components" "web/themes/custom/${_my_sub_theme}/css/layout"
cp -r "${_drupal_web_root}/css" "web/themes/custom/${_my_sub_theme}/"
cp -r "${_drupal_web_root}/fonts" "web/themes/custom/${_my_sub_theme}/fonts"
rm -f "web/themes/custom/${_my_sub_theme}/css/**/*.pcss.css"

# Set back Olivero variable file.
rm -rf "${_drupal_web_root}/css/"
mv "${_drupal_web_root}/css.orig/" "${_drupal_web_root}/css/"
