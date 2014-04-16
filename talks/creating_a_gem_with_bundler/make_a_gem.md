# [fit] Let's make a gem

---

## What is a gem?

---

## Let's make a gem
1. Creating a Gem with Bundler

---

## Let's make a gem
1. Creating a Gem with Bundler
1. Testing it with rspec

---

## Let's make a gem
1. Creating a Gem with Bundler
1. Testing it with rspec
1. Setting up continuous integration

---

## Let's make a gem
1. Creating a Gem with Bundler
1. Testing it with rspec
1. Setting up continuous integration
1. Publishing to Rubygems

---

## Let's make a gem
1. Creating a Gem with Bundler
1. Testing it with rspec
1. Setting up continuous integration
1. Publishing to Rubygems
1. Publishing to a private gem server

---

1. Creating a Gem

---

### RVM
### Bundler
### Rubygems

---

## Initializing our Gem
```bash
$ rvm use 2.1.0
$ gem install bundler
$ bundle gem eleventh
$ cd eleventh
$ rvm --rvmrc --create 2.1.0@eleventh
$ cd ..; cd -
```

---

## Generated structure
```
$ ls
eleventh
|--- README.md
|--- eleventh.gemspec
|--- Rakefile
|--- Gemfile
|--- lib
     |--- eleventh.rb
     |--- eleventh
          |--- version.rb

```

---

## Exploring the generated structure
```bash
$ vim eleventh.gemspec
$ vim Gemfile
$ vim lib/eleventh.rb
$ vim lib/eleventh/version.rb
$ rake -T
```

---

## Make it do something
```bash
$ vim lib/eleventh/array_access.rb
$ vim lib/eleventh.rb
$ git add .
$ git commit -m "Version 1"
```

---
## Make it do something
```ruby
# ./lib/eleventh/array_access.rb
class Array
  def eleventh
    self[10]
  end
end

# ./lib/eleventh.rb
require "eleventh/version"
require "eleventh/array_access"

module Eleventh
end
```

---

2\. Testing our gem with rspec

---

### Testing our gem
```bash
$ mkdir spec
$ vim spec/spec_helper.rb
$ vim spec/array_access_spec.rb
$ rspec spec/array_access.rb
```

---

### Testing our gem

```ruby
# ./spec/spec_helper.rb
require 'rubygems'
require 'bundler/setup'

Bundler.setup

require 'eleventh'

RSpec.configure do |config|
end
```

---

### Testing our gem

```ruby
# ./spec/array_access.rb
require 'spec_helper'

describe Array do
  describe '#eleventh' do
    it 'should return the eleventh element' do
      arr = (1..15).to_a

      arr.eleventh.should eq(11)
    end

    it 'should return nil if the eleventh element not not exist' do
      arr = (1..9).to_a

      arr.eleventh.should eq(nil)
    end
  end
end
```

---

### Testing our gem

```bash
$ rspec spec/array_access.rb
..
Finished in 0.00135 seconds
2 examples, 0 failures
```

---

### Testing our gem

```bash
$ vim Rakefile
```

```ruby
# ./Rakefile
require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('spec')

task :default => :spec
```

---

### Testing our gem
```bash
$ rake
/Users/bmorris/.rvm/rubies/ruby-2.1.0-p247/bin/ruby -S rspec ./spec/array_access_spec.rb
..

Finished in 0.00066 seconds
2 examples, 0 failures
```

---

3\. Setting up continuous integration

---

##  Jenkins
![40% left](http://i.imgur.com/59OBUL1.png)

^ Hosted. Pain to setup

---

##  Circle CI
![40% original right](http://i.imgur.com/ve5qSNU.png)

^ Good for private. Paid only

---

##  Travis CI
![40% original left](http://i.imgur.com/3QbhcR5.png)

^ Free for open source. Good feature set. Just works

---

### Setting up continuous integration
```bash
$ vim travis.yml
$ vim eleventh.gemspec
$ vim README.md
$ vim git commit -m "Setting up Travis CI"
$ git push
```

^ Setup github
Login to travis
Setup project
Add image to readme
[![Build Status](https://travis-ci.org/bnmrrs/eleventh.svg?branch=master)](https://travis-ci.org/bnmrrs/eleventh)


---

### Setting up continuous integration
```
# ./travis.yml

language: ruby
rvm:
  - 2.1.0
```

---

4\. Publishing to Rubygems

---

# Publishing to Rubygems
```bash
$ rake -T
$ rake release

$ gem build eleventh.gemspec
$ gem push eleventh-0.0.1.gem

$ open rubygems.org
```

---

# [fit] TA-DA!

---

# Removing the gem
```bash
$ gem yank eleventh -v 0.0.1
```

---

5\. Publishing to a private gem server

---

### Why private?

---

##  Github
![40% original right](http://i.imgur.com/tGANP32.png)

^ Github needs ssh keys, difficult to manage versions

---

##  Geminabox
![40% original left](http://i.imgur.com/pCBMY0R.png)

^ Geminabox is difficult to setup

---

##  Gemfury
![40% original right](http://i.imgur.com/naAPv4U.png)

^ Gemfury is affordable, easy to set up

---

### Publishing to Gemfury
```bash
$ gem install gemfury
$ gem build eleventh.gemspec
$ fury push eleventh-0.0.1.gem

$ git remote add fury https://bnmrrs@git.fury.io/bnmrrs/eleventh.git
$ git push fury master
```

---

### Publishing to Gemfury
```bash
$ cd ../other-project
$ vim Gemfile
```

```ruby
# ../other-project/Gemfile
source 'https://TOKEN@gem.fury.io/bnmrrs/'
```

```bash
$ bundle install
```

---

### Publishing a new version
```bash
$ vim lib/eleventh/version.rb
$ gem build eleventh.gemspec
$ git add .
$ git commit -m "Version 2"
$ fury push eleventh-0.0.2.gem
$ fury list
```

---
# Questions?

@bnmrrs
www.boltmade.com

https://github.com/bnmrrs/talks