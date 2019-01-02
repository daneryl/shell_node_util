
_node_version() {
  local GREEN="\033[1;32m"
  local NOCOLOR="\033[0m"
  echo "%{$GREEN%}⬢ $(node --version)%{$reset_color%} "
}

_find_file_upwards() {
  local LOOK=${PWD%/}
  while [[ -n $LOOK ]]; do
    [[ -f $LOOK/$1 ]] && {
      echo $LOOK/$1
    }
    [[ -f $LOOK/$2 ]] && {
      break
    }
    LOOK=${LOOK%/*}
  done
}

show_node_version_on_node_project() {
  local package_path;
  package_path=$(_find_file_upwards "package.json")
  if [[ -f $package_path ]]
  then
    _node_version
  fi
}

nvm_switch_node_version() {
  local nvmrc_path;
  nvmrc_path=$(_find_file_upwards ".nvmrc" "package.json")
  if [[ ! -z "$nvmrc_path" && $(< "$nvmrc_path") != $(node --version) ]]
  then
    nvm use
  fi
}
