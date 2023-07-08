

#!/bin/bash

usage() { echo "Usage: ${0} [-p <string>]"; exit 1; }

kpath=""
while getopts "p:" arg; do
  case ${arg} in
    p)
      kpath=${OPTARG}
      echo "Evaluating only file into [${kpath}] subdir"
      ;;
    *)
      usage
      ;;
  esac
done
shift $((OPTIND-1))

for arg in "$@"
do 
  if [[ $arg == *".yaml" ]]; then
    if [[ $path != "" ]]; then
      if [[ $arg != *"$path"* ]]; then
        continue
      fi
    fi
    echo "Running kubeconform on $arg"
    kubeconform -strict -ignore-missing-schemas -summary -schema-location default -schema-location 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/{{.Group}}/{{.ResourceKind}}_{{.ResourceAPIVersion}}.json' $arg
  fi
done