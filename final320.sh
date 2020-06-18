#!bin/bash
gcloud compute instances create build \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-central1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=/home/cng00006/Final/build_enviroment.sh \
--private-network-ip=10.128.0.42
gcloud compute instances create nagios \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-central1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=/home/cng00006/Final/nagios.sh \
--private-network-ip=10.128.0.41
gcloud compute instances create cacti \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-central1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=/home/cng00006/Final/cacti_server.sh \
--private-network-ip=10.128.0.40
gcloud compute instances create rsyslog-server2 \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-central1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=/home/cng00006/Final/logsrv.sh \
--private-network-ip=10.128.0.34
gcloud compute instances create ldap-server2 \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-central1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=/home/cng00006/Final/ldap.sh \
--private-network-ip=10.128.0.28
gcloud compute instances create nfs-server2 \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-central1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=/home/cng00006/Final/nfs.sh \
--private-network-ip=10.128.0.35
gcloud compute instances create postgres-server2 \
--image-family centos-8 \
--image-project centos-cloud \
--zone us-central1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=/home/cng00006/Final/postgres.sh \
--private-network-ip=10.128.0.30
gcloud compute instances create django-server2 \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-central1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=/home/cng00006/Final/django.sh \
--private-network-ip=10.128.0.31
gcloud compute instances create ubuntu-client1 \
--image-family ubuntu-1804-lts \
--image-project ubuntu-os-cloud \
--zone us-central1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=/home/cng00006/Final/client.sh \
--private-network-ip=10.128.0.32
gcloud compute instances create ubuntu-client2 \
--image-family ubuntu-1804-lts \
--image-project ubuntu-os-cloud \
--zone us-central1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=/home/cng00006/Final/client.sh \
--private-network-ip=10.128.0.33
