#!/usr/bin/env bash

# this script automates bumping version numbers and setting back to dev post-release
# doing this in bash reduces dependencies & removes headaches around which PHP version to use on automated runners

function bump_version() {
	BASE_VERSION="$1"

	suffix="$(echo "$BASE_VERSION" | cut -d- -sf2)"
	if [ "$suffix" != "" ]; then
		major_minor_patch="$(echo "$BASE_VERSION" | cut -d- -f1)"
		suffix_type="$(echo "$suffix" | sed -n "s/^\([A-Za-z]*\)\([0-9]*\)$/\1/p")"
		suffix_number="$(echo "$suffix" | sed -n "s/^\([A-Za-z]*\)\([0-9]*\)$/\2/p")"

		if [ "$suffix_type" == "" ] || [ "$suffix_number" == "" ]; then
			echo "error: don't know how to bump this version number $BASE_VERSION"
			exit 1
		fi

		new_release_number=$((suffix_number+1))
		new_version="$major_minor_patch-$suffix_type$new_release_number"
	else
		patch="$(echo "$BASE_VERSION" | cut -d. -sf3)"
		if [ "$patch" == "" ]; then
			echo "error: don't know how to bump this version number $BASE_VERSION"
			exit 1
		fi
		major_minor="$(echo "$BASE_VERSION" | cut -d. -sf1-2)"
		new_patch=$((patch+1))
		new_version="$major_minor.$new_patch"
	fi

	echo "$new_version"
}

cd "$1"
additional_info="$2"
base_version_regex='^(\s*public const BASE_VERSION = \")(.+)(\";)$'
is_dev_regex='^(\s*public const IS_DEVELOPMENT_BUILD = )(false|true)(;)$'

BASE_VERSION="$( sed -nE "s/$base_version_regex/\2/p" "./src/VersionInfo.php")"
IS_DEVELOPMENT_BUILD="$( sed -nE "s/$is_dev_regex/\2/p" "./src/VersionInfo.php")"

if [ "$IS_DEVELOPMENT_BUILD" == "true" ]; then
	echo "IS_DEVELOPMENT_BUILD is already true, nothing to do"
	exit 0
fi

NEW_VERSION="$(bump_version "$BASE_VERSION")"

#make sure sed doesn't misinterpret the version digits as capture group numbers
sed -i -E "s/$base_version_regex/\1___replaceme___\3/" "./src/VersionInfo.php"
sed -i "s/___replaceme___/$NEW_VERSION/" "./src/VersionInfo.php"

sed -i -E "s/$is_dev_regex/\1true\3/" "./src/VersionInfo.php"

git commit -m "$NEW_VERSION is next" -m "$additional_info" --only "./src/VersionInfo.php"
