#!/bin/sh
# Copyright 2022 Stichting ThingsIX Foundation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0


set -e

generate_bindings() {
  local work_dir=$(mktemp -d /tmp/thingsix-router-registry-XXXXX)
  local artifact_file=$(find $1/artifacts -name "$3.json")
  local pkg=$2  
  local abi_file="$work_dir/router_registry.abi"  

  echo Extract abi from artifact file
  jq .abi "$artifact_file" > "$abi_file"

  echo Generate bindings for package $pkg
  abigen --abi "$abi_file" --pkg $pkg --out "$2/bindings.go"

  echo Delete work directory
  rm -rf $work_dir
}

smart_contract_project=$1
echo Use smart contract project in ${smart_contract_project}

# generate go-bindings for token contracts
generate_bindings ${smart_contract_project} thixm ThixM
generate_bindings ${smart_contract_project} thix Thix

# install dependencies
echo Cleanup go dependencies
go mod tidy
