#!/bin/sh

test_version_printed_on_folder_with_packageJson() {
  cd ./fixtures/with_package
  show_node_version_on_node_project >${stdoutF} 2>${stderrF}
  cd ../../

  assertEquals 'node_version' "`cat ${stdoutF}`"
  assertEquals '' "`cat ${stderrF}`"
}

test_version_printed_on_sub_folder_with_packageJson() {
  cd ./fixtures/with_package/subFolder
  show_node_version_on_node_project >${stdoutF} 2>${stderrF}
  cd ../../..

  assertEquals 'node_version' "`cat ${stdoutF}`"
  assertEquals '' "`cat ${stderrF}`"
}

test_version_printed_on_sub_sub_folder_with_packageJson() {
  cd ./fixtures/with_package/subFolder/subFolder2
  show_node_version_on_node_project >${stdoutF} 2>${stderrF}
  cd ../../../..

  assertEquals 'node_version' "`cat ${stdoutF}`"
  assertEquals '' "`cat ${stderrF}`"
}

test_version_not_printed_on_folder_with_out_packageJson() {
  cd ./fixtures/without_package
  show_node_version_on_node_project >${stdoutF} 2>${stderrF}
  cd ../../

  assertEquals '' "`cat ${stdoutF}`"
  assertEquals '' "`cat ${stderrF}`"
}

setUp() {
  outputDir="${SHUNIT_TMPDIR}/output"
  mkdir "${outputDir}"
  stdoutF="${outputDir}/stdout"
  stderrF="${outputDir}/stderr"
}

tearDown() {
  # DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
  rm -fr "${outputDir}"
}

. ../init.zsh
_node_version() {
  echo "node_version";
}

# Load and run shUnit2.
[ -n "${ZSH_VERSION:-}" ] && SHUNIT_PARENT=$0
[ -n "${ZSH_VERSION:-}" ] && setopt shwordsplit


. ./lib/shunit2
