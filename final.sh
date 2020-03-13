#!bin/bash
gcloud compute instances create rsyslog-server2 \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-central1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=/home/cng0006/NTI310/script.sh \
--private-network-ip=10.128.0.27
gcloud compute instances create ldap-server2 \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-central1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=/home/cng0006/NTI310/script.sh \
--private-network-ip=10.128.0.28
gcloud compute instances create nfs-server2 \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-central1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=/home/cng0006/NTI310/script.sh \
--private-network-ip=10.128.0.29
gcloud compute instances create postgres-server2 \
--image-family centos-8 \
--image-project centos-cloud \
--zone us-central1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=/home/cng0006/NTI310/script.sh \
--private-network-ip=10.128.0.30
gcloud compute instances create django-server2 \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-central1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=/home/cng0006/NTI310/script.sh \
--private-network-ip=10.128.0.31
gcloud compute instances create ubuntu-client1 \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-central1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=/home/cng0006/NTI310/script.sh \
--private-network-ip=10.128.0.32
gcloud compute instances create ubuntu-client2 \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-central1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=/home/cng0006/NTI310/script.sh \
--private-network-ip=10.128.0.33
