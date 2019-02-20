#!/bin/sh

BASEDIR=$(pwd)
nvm_params=""
setUp() {
  outputDir="${SHUNIT_TMPDIR}/output"
  nvm_params=""
  mkdir "${outputDir}"
  stdoutF="${outputDir}/stdout"
  stderrF="${outputDir}/stderr"
  cd $BASEDIR
}

test_nvm_is_not_called_when_no_nvmrc() {
  cd ./fixtures/without_nvmrc
  nvm_switch_node_version

  assertNull "$nvm_params"
}

test_nvm_is_called_when_nvmrc() {
  cd ./fixtures/with_nvmrc
  nvm_switch_node_version

  assertEquals "use" "$nvm_params"
}

test_nvm_is_called_when_nvmrc_upwards() {
  cd ./fixtures/with_nvmrc/subfolder
  nvm_switch_node_version

  assertEquals "use" "$nvm_params"
}

test_nvm_is_not_called_when_node_version_matches_nvmrc() {
  node() {
    echo "node_version"
  }
  cd ./fixtures/with_nvmrc
  nvm_switch_node_version

  assertNull "$nvm_params"
}

test_nvm_uses_default_when_package_present_but_no_nvmrc() {
  _is_system_node() { 
    echo 0
  }
  cd ./fixtures/with_package
  nvm_switch_node_version

  assertEquals "use system" "$nvm_params"
}

tearDown() {
  # DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
  rm -fr "${outputDir}"
}

# Load and run shUnit2.
[ -n "${ZSH_VERSION:-}" ] && SHUNIT_PARENT=$0
[ -n "${ZSH_VERSION:-}" ] && setopt shwordsplit

. ../init.zsh

nvm() { 
  nvm_params="$@"
}

. ./lib/shunit2
