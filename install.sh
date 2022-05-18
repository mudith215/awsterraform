#! /bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo service httpd start  
sudo echo '<!DOCTYPE html> <html> <h1>HELLO WORLD</h1></body></html>' | sudo tee /var/www/html/index.html
sudo mkdir /var/www/html/health
sudo echo '<!DOCTYPE html> <html> <h1> health check ok </h1> </body></html>' | sudo tee /var/www/html/health/index.html


