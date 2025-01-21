# Work Scheduler

*by Cole Bye*

## Usage

### Versions:

Versions used to create this project are as follows:
- Ruby - 3.4.1
- Rails - 8.0.1
- Node.js - 20.9.0
- Yarn - 1.22.22
- sqlite3 - >= 2.1
- Bootstrap - 5.3.3
- Bundler - 2.6.3


### Setup:

Steps to run this application on a new machine are as follows:
1. Install Ruby 3.4.1
2. Download files the source files from and navigate to the project folder
3. Run bin/setup
4. Navigate to localhost:3000 in a web browser
5. Add database files on the rake page

## Additional Comments

### Approach taken:
The scheduler is my first project in Rails, so I took my time exploring its features and 
creating small test projects.  Once I felt familiar enough with the framework I started
outlining how I wanted the final front-end design to look like and feel like. The back-end
design was pretty straight forward as Rails streamlines the process nicely.  I choose 
sqlite for the database because I've used it in previous projects and a small project like
this won't be held back by its simplicity. The rest of the development process was focused 
into small sprints with steady improvements until the final product match what I'd 
initially designed.

### Challenges faced:
The main challenge I faced would be hosting on Heroku.  I was able to get the project 
running locally with postgresql (required for heroku), but I ran into trouble when I tried 
to deploy. Postgres is throwing BadConnection errors and refusing to connect. I've spent some 
time digging around in config files and the firewall, but due to time constrains I've decided 
to revert back to the local sqlite version for the time being.  

### Possible improvements:

Some features I'd like to implement in the future are:

- Improved conflict resolution for overlapping work orders.
- Better design for the rake page.
- A rake function that can be used on the command line.
- More checking on csv input file validity (currently assumed that the user puts the file in the correct form input)






