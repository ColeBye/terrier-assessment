# Work Order Scheduler

*by Cole Bye*

## Usage

### Versions:

Versions used to create this project are as follows:
- Ruby - 3.4.1
- Rails - 8.0.1
- Node.js - 20.9.0
- Yarn - 1.22.22
- postgresql 14.15
- Bootstrap - 5.3.3
- Bundler - 2.6.3


### Setup:

Steps to run this application on a new machine are as follows:
1. Install dependencies listed above
2. Download the source files and navigate to the project folder
3. Run `bin/setup`
4. Navigate to `localhost:3000` in a web browser
5. Use one of the following methods to rake .csv files into the database
   - Place files in their corresponding form inputs on the rake page
   - On the command line, place the files in the tmp folder and run `rake "csv_input:import_csv[WORK_ORDER_INPUT_FILE, TECHNICIANS_INPUT_FILE, LOCATIONS_INPUT_FILE]"`, replacing the bracketed arguments with their corresponding files

BONUS: The project can also be seen hosted on heroku at https://cole-bye-terrier-4c256193c8c9.herokuapp.com/

## Additional Comments

### Approach taken:
The scheduler is my first project in Rails, so I took my time exploring its features and 
creating small test projects before starting the main project. I initially choose sqlite for the database 
because I've used it in previous projects and a small project like this wouldn't be held back by 
its simplicity. Later I switched to postgresql to implement hosting on Heroku. Additionally, I chose 
to implement two different rake operations for maximum flexibility.  My thought was that developers 
might be more likely to use the CLI, but users would need the feature available from the front-end. 
In the future, the app could even be extended to allow users to input multiple spreadsheets for different days and weeks.

### Challenges faced:
The main challenge I faced would be hosting on Heroku.  Postgres was throwing BadConnection errors 
and refusing to connect. I spent some time digging around in config files and file permissions and 
eventually got it to work.

### Possible improvements:

Some features I'd like to implement in the future are:

- Improved conflict resolution for overlapping work orders.
- Better design for the rake page.
- More checking on csv input file validity (currently assumed that the user puts the file in the correct form input)






