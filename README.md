# Classroom Time Checker

Classroom time checker helps you to find an empty classroom to study in, especially if you are looking to find a room before class and will like to hang out in the room beforehand.

Read more on the Devpost entry (submitted to Hack Western 3): https://devpost.com/software/classroomfor-me

## Screenshots

![picture](http://i.imgur.com/SViOEIw.png)
![picture](http://i.imgur.com/3ngRPUD.png)
![picture](http://i.imgur.com/3aN8JH6.png)

## Prerequisites for building and running the project

You can easily build and run this project on your system! Before starting, please ensure that you have the following properly configured:

* Git
* Ruby 2.3.1
* Rails 5.0.0.1
* MySQL

## Building and running

Clone the repository onto your local system:

```
git clone git@github.com:wlee367/classroomTimeChecker-.git

cd classroomTimeChecker-/time-checker
```

Edit config/database.yml and change the username (line 16), password (line 17) and socket (lines 18 and 23) to correspond with the credentials and path for your MySQL database.

Now you can continue with installing and running the app:

```
bundle install

rake db:seed
rake db:create db:migrate

rails server
```

Now open a browser, and visit: [localhost:3000](http://localhost:3000/)
