#!/bin/bash
bundle install

#rake db:create_migration NAME=create_users
#rake db:create_migration NAME=add_passwords_to_users
#rake db:create_migration NAME=create_posts
#rake db:create_migration NAME=add_roles_to_users

rackup
