#!/usr/bin/env bash
#
# Initiate Olivero sub theme.

_my_sub_theme="{1:-my_sub_theme}"

if [[ ! -d web/core/node_modules ]];
then
  yarn --cwd web/core install
fi

cp web/core/themes/olivero/css/base/variables.pcss.css web/core/themes/olivero/css/base/variables.pcss.css.bak
cp -f web/themes/custom/$_my_sub_theme/css/variables.pcss.css web/core/themes/olivero/css/base/variables.pcss.css

# Build the theme
yarn --cwd web/core build:css

rm -rf web/themes/custom/$_my_sub_theme/css/base/*.css web/themes/custom/$_my_sub_theme/css/components web/themes/custom/$_my_sub_theme/css/layout
cp -r web/core/themes/olivero/css/ web/themes/custom/$_my_sub_theme/
cp -r web/core/themes/olivero/fonts web/themes/custom/$_my_sub_theme/fonts
rm -rf web/themes/custom/$_my_sub_theme/css/theme && rm -f web/themes/custom/$_my_sub_theme/css/**/*.pcss.css

# Set back Olivero variable file.
cp web/core/themes/olivero/css/base/variables.pcss.css.bak web/core/themes/olivero/css/base/variables.pcss.css
