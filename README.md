# REPresent  
[![Build Status](https://travis-ci.org/AntonioJacksonII/represent.svg?branch=master)](https://travis-ci.org/AntonioJacksonII/represent)  

As participants in democracy, it is difficult for voters to know whether or not the representatives they send to Congress on their behalf are pursuing the policy goals the voters sent them there to pursue. This problem makes it difficult for voters to know whether or not they should return their representatives to Congress. REPresent is a solution to this problem. REPresent is a platform to hold representatives accountable by allowing a user to compare their votes on bills with how the representatives voted. A user can favorite representatives, compare votes on bills, and receive a comparison score that is saved on their user dashboard. When this representative is up for reelection, a user can easily review their comparison score with that representative to determine whether or not they want to send them back to Congress. This provides a way for citizens to easily stay informed on the actions of their representatives and cast their votes with confidence.

Deployed Application: [https://represent-application.herokuapp.com/](https://represent-application.herokuapp.com/)

## Getting Started

* Click "Fork" in the upper right hand corner of the page
* Follow instructions below:

```
git clone git@github.com:YOUR_USER_NAME_HERE/represent.git
cd represent
- bundle install
- bundle update
- rake db:{create, migrate}
```


### Prerequisites

```
ruby -v
rails -v
```

The output should start with something like `ruby 2.5.X`
The output of rails should start with something like `rails 5.1.X`

If your ruby version is not the following, please follow the link [here](https://www.ruby-lang.org/en/documentation/installation/)
If your rails version doesn't start with 5.1, please follow the link [here](http://railsapps.github.io/installing-rails.html)

### Installing

To seed the databases, run the following rake tasks:

```
rake seed_reps:load
rake seed_bills:load
```

This should result in 100 Senator objects and 437 HouseMember objects matching the active members of the current 116th United States Congress, and 168 Bill objects that correspond to bills that have received recorded passage votes in either the US House of Representatives or the Senate.


## Running the tests

To run the tests, simply execute:

```
bundle exec rspec
```

There should be 70 passing tests.

## Built With

* **Rails**
* **Ruby**
* **PostgreSQL**
* **JavaScript ES6**
* **CSS**
* **SCSS**
* **HTML5**

## Authors

- **Antonio Jackson** (https://github.com/AntonioJacksonII)
- **Rostam Mahabadi** (https://github.com/Rostammahabadi)
- **Derek Borski** (https://github.com/dborski)
- **Alex Pariseau** (https://github.com/arpariseau)
