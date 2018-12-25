
_node_version() {
  local GREEN="\033[1;32m"
  local NOCOLOR="\033[0m"
  echo "${GREEN}⬢ $(node --version 2>/dev/null)${NOCOLOR} "
}

_file_exists_upwards() {
  local LOOK=${PWD%/}
  while [[ -n $LOOK ]]; do
    [[ -e $LOOK/$1 ]] && {
      return 0
    }
    LOOK=${LOOK%/*}
  done

  return 1
}

_find_file_upwards() {
  local LOOK=${PWD%/}
  while [[ -n $LOOK ]]; do
    [[ -e $LOOK/$1 ]] && {
      echo $LOOK/$1
    }
    LOOK=${LOOK%/*}
  done
}

show_node_version_on_node_project() {
  if _file_exists_upwards "package.json"
  then
    _node_version
  fi
}

nvm_switch_node_version() {
  nvmrc_path=$(_find_file_upwards ".nvmrc")
  if [[ ! -z "$nvmrc_path" && $(< "$nvmrc_path") != $(node --version) ]]
  then
    nvm use
  fi
}
