#!/bin/bash

usage() { echo "Usage: ${0} [-p <string>]"; exit 1; }

check() {
  which kubeconform
  if [[ $? -gt 0 ]]; then
    echo "kubeconform not found, please install it from https://github.com/yannh/kubeconform/releases/latest"
    exit 255
  fi
}

check

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
    if [[ $kpath != "" ]]; then
      echo ${arg} | grep -q ${kpath}
      if [[ $? -gt 0 ]]; then
        continue
      fi
    fi
    echo "Running kubeconform on $arg"
    kubeconform -strict -ignore-missing-schemas -summary -schema-location default -schema-location 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/{{.Group}}/{{.ResourceKind}}_{{.ResourceAPIVersion}}.json' $arg
done