# Sport Import
Sport Import is a basic JSON service which lets a user request JSON data for a baseball, football, or basketball. Data is being sourced from CBS Sports API, such as http://api.cbssports.com/fantasy/players/list?version=3.0&SPORT=baseball&response_format=JSON.

## Design Plan

### Basic Data Model
* Create a Player model
* Set up basic RSPEC tests

### Data Import
* get /import
* add fields to Player models

### JSON endpoint
* get players/
  * return all data as JSON
* get players/id
  * return player.to_json
* Reevaluate RSPEC tests

