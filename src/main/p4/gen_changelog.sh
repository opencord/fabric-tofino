#!/usr/bin/env bash
# Copyright 2019-present Open Networking Foundation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

if [ -z "$ONOS_ROOT" ]; then
  echo "Error: ONOS_ROOT is not set"
  exit 1
fi

FABRIC_DIR=${ONOS_ROOT}/pipelines/fabric

echo "# fabric.p4 changes included in this release (from ONOS repository)"
echo ""
cd "$FABRIC_DIR" && git --no-pager log --no-color --oneline -- **/*.p4