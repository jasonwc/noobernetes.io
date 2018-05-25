# Writing a simple app
## Introduction
In order to play around with Kubernetes, we're going to write a simple Ruby web server with Sinatra. Feel free to skip this section if you want to jump to Docker and Kubernetes. The complete app code can be found under `applications/sinatra` in this repo.

### Verifying that we have Ruby installed
Most Mac's come with Ruby installed. We can verify that with the following command:

```
> ruby -v
ruby 2.3.7p456 (2018-03-28 revision 63024) [x86_64-darwin17]

```

If you don't, thats ok too! Follow the [installation guide](https://www.ruby-lang.org/en/documentation/installation/) at ruby-lang.org to install ruby on your system.

### Installing RVM

We're going to install [rvm](https://rvm.io/), a ruby version manager so that we can keep our dependencies isolated for this application. You can check to see if you have it installed by running this command.

```
> rvm -v
rvm 1.29.3 (latest) by Michal Papis, Piotr Kuczynski, Wayne E. Seguin [https://rvm.io]
```

If you don't have it installed rvm has an [install guide](https://rvm.io/rvm/install) with instructions for various systems.


### Anatomy of a Sinatra app
We're going to define a couple of files in this section:

- Our `Gemfile` lets us specify our ruby dependencies and take advantage of [bundler](https://bundler.io/) for including packages.
- Our `.ruby-gemset` and `.ruby-version` let us use RVM to isolate our installation on our local machine from any other ruby apps we might have.
- Our `web.rb` is going to be our actual web app. We're going to take advantage of Sinatra to write a super quick web server.

### Creating our project
Create a directory called `noobernetes` with the `mkdir` command.

```
> mkdir noobernetes
```

`cd` into that directory as we'll use that to write our application.

### Writing our `.ruby-version` and `.ruby-gemset`
These files simply let us declare a separate ruby version and gemset so that we can isolate our apps dependencies and ruby version from the rest of our ruby apps.

We'll start by creating a `.ruby-version` file. In our case, we're going to use `ruby-2.3.7`.

```
2.3.7
```

Next we'll create a `.ruby-gemset` file and create a name for where we want our gems to be installed.

```
noobernetes
```

Now that we've defined these files, we should be able to `cd` out of the directory and back into it so that `rvm` can use them to do its magic.

```
> cd ..
> cd noobernetes
Required ruby-2.3.7 is not installed.
To install do: 'rvm install "ruby-2.3.7"'
```

We see that ruby-2.3.7 is not yet installed. We can now install the version of ruby that we've specified in our `.ruby-version` without impacting our system installed Ruby.

```
> rvm install ruby-2.3.7
> cd ..
> cd noobernetes
ruby-2.3.7 - #gemset created /Users/mavenlink/.rvm/gems/ruby-2.3.7@noobernetes
ruby-2.3.7 - #generating noobernetes wrappers - please wait
```

### Writing our Gemfile

We're going to write a simple Gemfile so that we can include our sinatra dependency. 

```ruby 
source "https://rubygems.org"

gem 'sinatra'
```

Once we've gotten our Gemfile written, we're going to install our dependencies to use bundler to install our dependencies.

We'll first need to install `bundler`.

```
> gem install bundler
Fetching: bundler-1.16.2.gem (100%)
Successfully installed bundler-1.16.2
Parsing documentation for bundler-1.16.2
Installing ri documentation for bundler-1.16.2
Done installing documentation for bundler after 6 seconds
1 gem installed
```

Then we can run `bundle install` to install Sinatra and its dependencies.

```
> bundle install
Fetching gem metadata from https://rubygems.org/.........
Using bundler 1.16.2
Fetching mustermann 1.0.2
Installing mustermann 1.0.2
Fetching rack 2.0.4
Installing rack 2.0.4
Fetching rack-protection 2.0.1
Installing rack-protection 2.0.1
Fetching tilt 2.0.8
Installing tilt 2.0.8
Fetching sinatra 2.0.1
Installing sinatra 2.0.1
Bundle complete! 1 Gemfile dependency, 6 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
Bundle complete! 1 Gemfile dependency, 85 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
```

### Writing our Web Server
We're going to make a simple web application that has one route. It will build widgets, so that we can simulate CPU load in future tutorial steps. To start, create a file called `web.rb` with the following content.

```ruby

# frozen_string_literal: true

require 'sinatra'

set :bind, '0.0.0.0'

def build_widget
  100.times do |i|
    100000.downto(1) do |j|
      Math.sqrt(j) * i / 0.2
    end
  end
end

get '/' do
  build_widget
  "Your widget was built!"
end

```

### Running it locally
Now that we've got our app built, we can run it with the following command:

```
> ruby web.rb
[2018-05-20 15:23:10] INFO  WEBrick 1.3.1
[2018-05-20 15:23:10] INFO  ruby 2.3.7 (2018-03-28) [x86_64-darwin17]
== Sinatra (v2.0.1) has taken the stage on 4567 for development with backup from WEBrick
[2018-05-20 15:23:10] INFO  WEBrick::HTTPServer#start: pid=49289 port=4567
```

We can visit the app and see it running at `localhost:4576`

## Conclusion
We now have a simple Ruby server running locally. Next we're going to get it containerized with Docker!

## Resources
- [Sinatra Docs](http://sinatrarb.com/)
- [An Introduction to Sinatra](http://budiirawan.com/introduction-sinatra/)

---

Continue to [Containerizing our app](./3-containerizing-our-app.md)
