#!/bin/bash
# fun django turorial https://data-flair.training/blogs/django-migrations-and-database-connectivity/

echo "*.info;mail.none;authpriv.none;cron.none   @rsyslog-server2" >> /etc/rsyslog.conf && systemctl restart rsyslog.service

for file in $( ls /etc/yum.repos.d/ ); do mv /etc/yum.repos.d/$file /etc/yum.repos.d/$file.bak; done


echo "[nti-310-epel]
name=NTI310 EPEL
baseurl=http://34.71.91.10/epel
gpgcheck=0
enabled=1" >> /etc/yum.repos.d/local-repo.repo

echo "[nti-310-base]
name=NTI310 BASE
baseurl=http://34.71.91.10/base
gpgcheck=0
enabled=1" >> /etc/yum.repos.d/local-repo.repo

echo "[nti-310-extras]
name=NTI310 EXTRAS
baseurl=http://34.71.91.10/extras/
gpgcheck=0
enabled=1" >> /etc/yum.repos.d/local-repo.repo

echo "[nti-310-updates]
name=NTI310 UPDATES
baseurl=http://34.71.91.10/updates/
gpgcheck=0
enabled=1" >> /etc/yum.repos.d/local-repo.repo
yum -y install python-pip python-devel gcc postgresql-devel postgresql-contrib
pip install --upgrade pip
pip install virtualenv
mkdir /opt/nti310
cd /opt/nti310
virtualenv nti310env
source nti310env/bin/activate
pip install django psycopg2
django-admin.py startproject nti310
#vim /opt/nti310/nti310/settings.py

echo "perl -i -0pe "\'BEGIN{undef $/;} s/        '\'ENGINE'\':.*db.sqlite3'\'\),/        '\'ENGINE'\': '\'django.db.backends.postgresql_psycopg2'\',\n        '\'NAME'\': '\'nti310'\',\n        '\'USER'\': '\'nti310user'\',\n        '\'PASSWORD'\': '\'password'\',\n        '\'HOST'\': '\'postgres-server2'\',\n        '\'PORT'\': '\'5432'\',/smg"\' /opt/nti310/nti310/settings.py" >/opt/nti310/nti310/settings.py

#From the Postgres server:
sed -i "s/host    all             all             127.0.0.1\/32            md5/host    all             all             0.0.0.0\/0               md5/g" /var/lib/pgsql/data/pg_hba.conf
systemctl restart postgresql

#Make sure your user has full permissions:
echo "alter user nti310user createdb;" > /tmp/authfile
sudo -u postgres /bin/psql -f /tmp/authfile

#change ownership of the NTI310 db
echo "ALTER DATABASE nti310 OWNER
TO nti310user; " > /tmp/changeowner
sudo -u postgres /bin/psql -f /tmp/changeowner

# from django
python manage.py startapp Cars
echo "class Specs(models.Model):
    name = models.CharField(max_length = 20)
    price = models.DecimalField(max_digits=8, decimal_places=2)
    weight =models.PositiveIntegerField()" >> Cars/models.py

# put sed into the INSTALLED_APPS variable
sed -i "40i \ \ \ \ 'Cars'," nti310/settings.py

python manage.py makemigrations Cars
python manage.py migrate Cars

#django admin user creation
echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('admin', 'admin@newproject.com','NTI300NTI300')" | python manage.py shell
firewall-cmd --add-port=8000/tcp
python manage.py runserver 0.0.0.0:8000

#be sure to open 8000 in the firewall
