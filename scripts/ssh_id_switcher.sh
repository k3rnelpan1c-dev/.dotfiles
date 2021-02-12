#!/etc/bash

# WARNING: 
#  I designed this script to easily switch between my ssh IDs.
#  It depends on a certain naming schema of the ssh ID keys and OVERWRITES id_ed25519 & id_ed25519.pub

function __prompt() {
  echo "WARNING: About to overwrite id_ed25519 with ${1}_ed25519!"
  echo -n "Proceed? [y/n]: "
  read -n 1 ans
  [[ ${ans} != 'y' ]] && exit 1
}
function __overwrite() {
  if [[ -f ~/.ssh/${1}_ed25519 ]]; then
    mv -f ~/.ssh/${1}_ed25519 ~/.ssh/id_ed25519
  else
    echo "ERROR: ~/.ssh/${1}_ed25519 not found! Have you set-up the environemt properly?"
    exit 1
  fi
}

# # ssh_id_switcher - switches the active ssh ed25519 id
#
# # usage: ssh_id_switcher {k3|h1|dh}
function ssh_id_switcher() {
  case "${1}" in
    k3)
      __prompt "k3"
      __overwrite "k3"
    ;;
    h1)
      __prompt "h1"
      __overwrite "h1"
    ;;
    dh)
      __prompt "dh"
      __overwrite "dh"
    ;;
    *)
      echo "Usage: ${0} {k3|h1|dh}"
      exit 0
    ;;
  esac
  echo "Successfully changed ssh ID to ${1}_ed25519!"
}

alias ssh-id='ssh_id_switcher'
