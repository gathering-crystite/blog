## Blog

I wrote this blog to learn some ruby, rails, sinatra, and some new deploy techniques.  
The content of this blog will consolidate notes of my learnings into one place. 

#### Setup Guide
##### Install instance on AWS and setup 
```
Ubuntu Server 16.04 LTS (HVM)
SSD Volume Type
ami-b7a114d7
t2.nano
create vpc
vpc-eissfeldt-uswest 
vpc-33800054 
create subnet 
subnet-eissfeldt-uswest 
subnet-a407a3c3 
35.164.63.70
```
The routing table needs an IGW, 
```
add 0.0.0.0/0 igw-1f26717b
```

#### I can now ssh into the machine:
```
ssh -i insert_pem_file ubuntu@external_ip
```

#### Install ruby and sinatra
```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install cvs subversion git-core mercurial
```

##### Install Ruby Version Manager (RVM)
```
curl -L get.rvm.io | bash -s stable
```
##### Create a system environment using RVM shell script:
```
source /etc/profile.d/rvm.sh
```

##### Install Ruby 2.1.0
```
rvm reload
rvm install 2.1.0
```

##### Install Sinatra
```
gem install sinatra
```

##### Create A www User Group And A deployer User
```
sudo addgroup www
```

##### Create a new user and add it to this group:
```
sudo adduser deployer # follow prompts and later automate
sudo adduser deployer www
```

##### Create the application folder in /var directory
```
sudo mkdir /var/www
```

##### Set Permissions
```
sudo chown -R :www  /var/www
sudo chmod -R g+rwX /var/www
sudo chmod g+s /var/www
```

##### Add new user from above, deployer, to sudoers file: /etc/sudoers
##### User privilege specification
```
root     ALL=(ALL:ALL) ALL
deployer ALL=(ALL:ALL) ALL
```

##### Create hello world application with sinatra
##### create app structure:
```
mkdir /var/www/my_app
cd    /var/www/my_app
mkdir tmp
mkdir public
mkdir pids
mkdir logs
touch tmp/restart.txt
```

##### Create sample application files
##### app.rb
```
require 'rubygems'
require 'sinatra/base'

class MyApp < Sinatra::Base

  get '/' do
    'Hello world!'
  end

end
```

##### create config.ru file
##### config.ru
```
require File.expand_path('../app.rb', __FILE__)
use Rack::ShowExceptions
run MyApp.new    
```

##### Create Gemfile
```
source 'https://rubygems.org'
gem 'rack'
gem 'sinatra'
```

##### Install bundle package manager
##### Don't install as root
```
gem install bundler
```
##### Test the application
##### Run this command from /var/www/my_app
```
rackup config.ru --port=4567
```
##### Navigate to the IP, and we should see:
```
Hello world!
```

##### On the instance, git init and git remote add repo /blog
```
# git init
Initialized empty Git repository in /var/www/my_app/.git/
# git remote add origin git@github.com:gathering-crystite/blog.git
```

##### Now, I'm able to make changes locally, push to Github, and pull from GitHub to AWS instances.

#### Acknowledgments
* Jeffrey Baird, I stole our code and hopefully your positive attitude as well. 
* I used this sinatra tutroial as well: https://www.digitalocean.com/community/tutorials/how-to-install-ruby-2-1-0-and-sinatra-on-ubuntu-13-with-rvm


