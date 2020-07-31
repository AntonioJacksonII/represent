# Project Title

One Paragraph of project description goes here

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

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Built With

* **Rails**
* **Ruby**
* **PostgreSQL**
* **JavaScript ES6**
* **CSS**
* **SCSS**
* **HTML5**

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

- **Antonio Jackson** (https://github.com/AntonioJacksonII) 
- **Rostam Mahabadi** (https://github.com/Rostammahabadi) 
- **Derek Borski** (https://github.com/dborski) 
- **Alex Pariseau** (https://github.com/arpariseau)
