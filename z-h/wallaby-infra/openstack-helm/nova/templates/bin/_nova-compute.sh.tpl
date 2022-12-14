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

COMPUTE_HOST=$(hostname)
set -ex
echo "$COMPUTE_HOST is the host"
APELBY_COMPUTE="apelbycmp01"
if [[ "$APELBY_COMPUTE" =~ "$COMPUTE_HOST" ]]
then
  mkdir -p /etc/nova/nova.conf.d/
  echo "[compute]" > /tmp/010-nova-ids.conf
  echo "cpu_dedicated_set=1-19,21-31" >> /tmp/010-nova-ids.conf
  cp /tmp/010-nova-ids.conf /etc/nova/nova.conf.d/
fi

exec nova-compute \
      --config-file /etc/nova/nova.conf \
      --config-file /tmp/pod-shared/nova-console.conf \
      --config-file /tmp/pod-shared/nova-libvirt.conf \
{{- if and ( empty .Values.conf.nova.DEFAULT.host ) ( .Values.pod.use_fqdn.compute ) }}
      --config-file /tmp/pod-shared/nova-compute-fqdn.conf \
{{- end }}
      --config-file /tmp/pod-shared/nova-hypervisor.conf
