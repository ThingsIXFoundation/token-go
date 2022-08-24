#!/bin/sh

set -e

THINGS_TOKEN_SMART_CONTRACT_REPO=git@github.com:ThingsIXFoundation/smart-contracts-evm.git

generate_bindings() {
  local work_dir=$1
  local pkg=$2
  local artifact_file=$(find $work_dir -name "$3.json")
  local abi_file="$work_dir/$3.abi"

  # ensure output directory exists
  mkdir -p "$pkg"

  # extract abi from artifacts file
  jq .abi "$artifact_file" > "$abi_file"

  echo "Generate token smart contract go bindings for package $pkg"
  
  abigen --abi "$abi_file" --pkg $pkg --out "$pkg/bindings.go"
}

# clone smart contract repo and install dependencies
work_dir=$(mktemp -d /tmp/thingsix-tokens-XXXXX)
echo "Clone smart contract repo in work directory $work_dir"
git clone $THINGS_TOKEN_SMART_CONTRACT_REPO $work_dir --quiet

# generate go-bindings for ThixM token contract
generate_bindings $work_dir thixm ThixM

# cleanup work directory
rm -rf $work_dir

# install dependencies
go mod tidy