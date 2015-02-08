ImageHex
========

[View the Wiki for more information.](https://github.com/connorshea/ImageHex/wiki)

Some things to note:

1. You MUST install ImageMagick. Easily acomplished through the package manager
   of most distros and Homebrew.
2. We use a loose form of TDD. Have tests to ensure that your code works, but,
   if it makes sense to write code first and tests later, do that as well. Use
   discretion. If you're working here you're smart.
3. Push all changes to a branch specifically for the task assigned to you.
   Branch that off the "develop" branch. When it's ready to join the rest of
   the codebase (when your task is done), merge back into develop. 
   When we're ready to push up to Heroku, Anthony or Connor will merge 
   develop back into master and push it up.
4. Set up the DB according to the config file.
5. Use "rake doc:app" to generate the RDoc documentation.
