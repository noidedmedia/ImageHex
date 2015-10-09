ImageHex [![Codeship Status for connorshea/ImageHex](https://codeship.com/projects/3deaa030-bd7d-0132-9ea7-7a0ba2699df2/status?branch=develop)](https://codeship.com/projects/72579)
========
### ImageHex wants to be *the* place to buy, sell, search, and share your artwork.

[View the Wiki for more information.](https://github.com/connorshea/ImageHex/wiki)

**Notes:**

* You MUST install ImageMagick. Easily accomplished through the package manager
  of most distros and Homebrew.
* We use a loose form of TDD. Have tests to ensure that your code works, but,
  if it makes sense to write code first and tests later, do that as well. Use
  discretion. If you're working here you're smart.
* Push all changes to a branch specifically for the task assigned to you.
  The branch should be based off `develop`. When the feature is complete,
  open a Pull Request to merge back into `develop`. When we're ready to
  push up to Heroku, Anthony or Connor will merge `develop` back into `master`
  and push it up.
* Set up the DB according to the config file.
* Use `rake documentation` to generate the RDoc documentation.


### Setting up your Development environment

This tutorial assumes you have some basic understanding of using the Terminal and Git/GitHub. You don't need to be able to hack the Pentagon, but you should know what `cd` and `ls` do, how to make a branch, and how to submit a pull request on GitHub.

If you don't, check out [Codecademy's Command Line course](https://www.codecademy.com/courses/learn-the-command-line) and GitHub's [Git tutorial](https://help.github.com/articles/set-up-git/) before getting started.

Before starting you'll want to set up Two Factor Authentication on your GitHub account, if you haven't already (you shouldn't have access to this repo if you haven't done that, so I have no idea how you're reading this). This is to protect our source code and other data that may be used to compromise user information.

#### OS X
1. Install the Xcode command-line tools with `xcode-select –install`. This'll be necessary to install Homebrew.
2. Install [Homebrew](http://brew.sh/) with the following command: `ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`.
3. Install [RVM](https://rvm.io/).
4. Use RVM to install Ruby 2.2.3 (`rvm install ruby-2.2.3`) and then switch to that version of Ruby with `rvm use ruby-2.2.3 --default`.
5. Install [Git](https://git-scm.com/) with `brew install git`, then either use Git from the terminal or [the GitHub Desktop app](https://desktop.github.com/) to pull down the ImageHex repository.
6. Install PostgreSQL 9.4 with `brew install postgresql`. We also recommend using [Postgres.app](http://postgresapp.com/) on OS X to get the Postgres server running after the initial setup.
7. Install [ImageMagick](http://www.imagemagick.org/script/index.php) with `brew install imagemagick`.
8. Install [Bundler](http://bundler.io/) with `gem install bundler`.
9. In the ImageHex directory (wherever you installed the Git repository), run `bundle install` to install all the relevant gems you'll need for developing ImageHex. This might take a bit of time, be patient!
10. Run `rake db:setup` to set up the Postgres development server.
11. If everything has gone right so far, you'll be able to start up a Rails server with `rails s`!
12. Get working!

You can update packages installed with Homebrew at any time with `brew update` and `brew upgrade`. You'll likely want to do this once a week, just in case there are security issues in anything you've installed. We recommend using Homebrew as much as possible to install development dependencies, as it makes uninstalling and updating things much easier!

#### Linux
Note: Replace `apt-get install` with your distro's equivalent package manager, this uses `apt-get` for simplicity's sake.

1. Install [RVM](https://rvm.io/).
2. Use RVM to install Ruby 2.2.3 (`rvm install ruby-2.2.3`) and then switch to that version of Ruby with `rvm use ruby-2.2.3 --default`.
3. Install [Git](https://git-scm.com/) if you need to, then use git from the terminal to pull down the ImageHex repository.
4. Install PostgreSQL 9.4 with `apt-get install postgresql`.
5. Install [ImageMagick](http://www.imagemagick.org/script/index.php) with `apt-get install imagemagick`.
6. Install [Bundler](http://bundler.io/) with `gem install bundler`.
7. In the ImageHex directory (wherever you installed the Git repository), run `bundle install` to install all the relevant gems you'll need for developing ImageHex. This might take a bit of time, be patient!
8. Run `rake db:setup` to set up the Postgres development server.
9. If everything has gone right so far, you'll be able to start up a Rails server with `rails s`!
10. Get working!


### How do I generate the icon font after adding a new icon?

Icon font auto-generation technique courtesy of Scott Nelson's post [here](http://thisbythem.com/blog/rails-custom-font-icons/).

1. Assuming you have Homebrew installed on OS X, run `brew install fontforge ttfautohint` from the terminal.
  * If you want to install the prerequisites to FontCustom using other means, you can see the installation instructions in the [FontCustom README](https://github.com/FontCustom/fontcustom/#installation).
2. Add icons as `.svg` files to `app/assets/icons`.
3. From the terminal, in the base ImageHex directory, run `rake icons:compile`.
4. The new icon font should be generated and immediately useable, you can add the new icon to the site by using the auto-generated CSS classes. For example, if we take an SVG named `heart.svg`, the css class will be `icon-heart`.

