#!/bin/bash

{{/*
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/}}

set -ex

mkdir -p ~nova/.ssh
chown -R nova:nova ~nova/.ssh

cat > ~nova/.ssh/config <<EOF
LogLevel DEBUG
Host *
  User nova
  StrictHostKeyChecking no
  UserKnownHostsFile /dev/null
  IdentityFile /var/lib/nova/.ssh/id_rsa
  Port 8022
EOF

cp /tmp/nova-ssh/* ~nova/.ssh/
chmod 600 ~nova/.ssh/id_rsa
