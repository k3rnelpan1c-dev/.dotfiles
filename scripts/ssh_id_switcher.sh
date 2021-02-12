#!/etc/bash

# WARNING: 
#  I designed this script to easily switch between my ssh IDs.
#  It depends on a certain naming schema of the ssh ID keys and OVERWRITES id_ed25519 & id_ed25519.pub

function __prompt() {
  echo "WARNING: About to overwrite id_ed25519 with ${1}_ed25519!"
  echo -n "Proceed? [y/n]: "
  read -n 1 ans
  echo ""
  [[ ${ans} != 'y' ]] && return 1
  return 0
}
function __overwrite() {
  if [[ -f ~/.ssh/${1}_ed25519 ]]; then
    /bin/cp -f ~/.ssh/${1}_ed25519 ~/.ssh/id_ed25519
    /bin/cp -f ~/.ssh/${1}_ed25519.pub ~/.ssh/id_ed25519.pub
  else
    echo "ERROR: ~/.ssh/${1}_ed25519 not found! Have you set-up the environemt properly?"
    return 1
  fi
  echo "Successfully changed ssh ID to ${1}_ed25519!"
  return 0
}

# # ssh_id_switcher - switches the active ssh ed25519 id
#
# # usage: ssh_id_switcher {k3|h1|dh}
function ssh_id_switcher() {
  case "${1}" in
    k3|h1|dh)
      __prompt "${1}"
      [[ $? == 0 ]] && __overwrite "${1}" || return 1
      return $?
    ;;
    *)
      echo "Usage: ${0} {k3|h1|dh}"
      return 0
    ;;
  esac
}

alias ssh-id='ssh_id_switcher'
