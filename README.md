# Sport Import
Sport Import is a basic JSON service which lets a user request JSON data for a baseball, football, or basketball. Data is being sourced from CBS Sports API, such as http://api.cbssports.com/fantasy/players/list?version=3.0&SPORT=baseball&response_format=JSON.

## Setup
This is a typical Rails project, so clone this repo and run:
* bundle install
* rake db:migrate
* rake data:import

This will set up the project and add data to the database. Run the server using:
* bundle exec rails server

Run RSPEC tests via:
* rspec

## Usage
This is a JSON service, so you can request all data as JSON by visiting:
* localhost/

You can search players using typical URL params, such as requesting all football quarterbacks:
* localhost/?sport=football&position=qb

## Design Plan

### Basic Data Model
* Create a Player model
* Set up basic RSPEC tests

### Data Import
* rake data:import
* add fields to Player models

### JSON endpoint
* get players/
  * return all data as JSON
* get players/id
  * return player.to_json
* Reevaluate RSPEC tests

