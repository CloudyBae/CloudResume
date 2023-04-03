#!/bin/bash -e
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
sudo apt-get update
sudo apt-get install nginx -y
sudo service nginx start
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install php7.4-fpm php7.4-common php7.4-mysql php7.4-gmp php7.4-curl php7.4-intl php7.4-mbstring php7.4-xmlrpc php7.4-gd php7.4-xml php7.4-cli php7.4-zip -y

#create uploads folder and set permissions
#EFS
git clone https://github.com/aws/efs-utils
sudo apt-get -y install binutils
cd efs-utils/
./build-deb.sh
sudo apt-get -y install ./build/amazon-efs-utils*deb
sudo mkdir /var/www/html/wp-content
sudo mount -t efs -o tls ${efs_id}:/ /var/www/html/wp-content
cd /var/www/html

#download wordpress
curl -O https://wordpress.org/latest.tar.gz
#unzip wordpress
tar -zxvf latest.tar.gz
#change dir to wordpress
cd wordpress
#copy file to parent dir
cp -rf . ..
#move back to parent dir
cd ..
chown -R www-data:www-data /var/www/html/
#remove files from wordpress folder
rm index.nginx-debian.html
rm -R wordpress
#create wp config
cp wp-config-sample.php wp-config.php

# set database details with perl find and replace
perl -pi -e "s/database_name_here/${db_name}/g" wp-config.php
perl -pi -e "s/username_here/${db_user}/g" wp-config.php
perl -pi -e "s/password_here/${db_pass}/g" wp-config.php
perl -pi -e "s/localhost/${db_host}/g" wp-config.php

#set WP salts
perl -i -pe'
  BEGIN {
    @chars = ("a" .. "z", "A" .. "Z", 0 .. 9);
    push @chars, split //, "!@#$%^&*()-_ []{}<>~\`+=,.;:/?|";
    sub salt { join "", map $chars[ rand @chars ], 1 .. 64 }
  }
  s/put your unique phrase here/salt()/ge
' wp-config.php

echo "Cleaning..."
#remove zip file
rm latest.tar.gz
#remove bash script
mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak
cat > /etc/nginx/sites-available/default <<EOT
server {
        listen 80 default_server;
        listen [::]:80 default_server;
        root /var/www/html;
        index index.php index.html index.htm index.nginx-debian.html;
        server_name _;
        location / {
                try_files \$uri \$uri/ /index.php?\$args;
        }
        location ~ \.php$ {
         include snippets/fastcgi-php.conf;
         fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
         include fastcgi_params;
        }
}

EOT
sudo service nginx restart
echo "========================="
echo "Installation is complete."
echo "========================="