
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
    [[ -f $LOOK/$1 ]] && {
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

_is_system_node() {
  local node_path;
  node_path=$(which node)
  if [[ $node_path == *"fnm-shell"* ]]; then
    echo 0
  else
    echo 1
  fi
}

nvm_switch_node_version() {
  local nvmrc_path;
  local package_path;
  nvmrc_path=$(_find_file_upwards ".nvmrc")
  package_path=$(_find_file_upwards "package.json")
  if [[ ! -z "$nvmrc_path" && $(< "$nvmrc_path") != $(node --version) ]]
  then
    fnm use
  fi

  if [[ $(_is_system_node) -eq 0 && -z "$nvmrc_path" && ! -z "$package_path" ]]
  then
    fnm use system
  fi
}
