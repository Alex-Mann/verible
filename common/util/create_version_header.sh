#!/bin/bash
# Copyright 2020 The Verible Authors.
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

# The file where bazel stores name/value pairs
BAZEL_VOLATILE=bazel-out/volatile-status.txt

GIT_DATE="$(grep -s GIT_DATE $BAZEL_VOLATILE | cut -f2- -d' ')"
GIT_DESC="$(grep -s GIT_DESCRIBE $BAZEL_VOLATILE | cut -f2- -d' ')"

# Timestamp is always provided by bazel.
TS_INT="$(grep -s BUILD_TIMESTAMP $BAZEL_VOLATILE | cut -f2 -d' ')"
test -z "$TS_INT" || TS_STRING="$(date +"%Y-%m-%dT%H:%M:%SZ" -u -d @$TS_INT)"

test -z "$GIT_DATE"  || echo "#define VERIBLE_GIT_DATE $GIT_DATE"
test -z "$GIT_DESC"  || echo "#define VERIBLE_GIT_DESC $GIT_DESC"
test -z "$TS_STRING" || echo "#define VERIBLE_BUILD_TIMESTAMP \"$TS_STRING\""
