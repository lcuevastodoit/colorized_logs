# colorized_logs
Ruby gem to colorize Rails logs

#### Installing the gem in a project via Gemfile (recommended)
-  First add the gem to the Gemfile
```ruby
gem 'colorized_logs', '0.1.0', git: "https://github.com/lcuevastodoit/colorized_logs.git", branch: 'main'
```
-  then run bundle install from the terminal
```shell
bundle install
```
-  finally add these lines in the config/development.rb after `Rails.application.configure do`

```ruby
Rails.application.configure do
  require 'colorized_logs'
  logger = ColorizedLogs.new(STDOUT)
  logger.formatter = config.log_formatter
  config.logger = logger
  # the rest of the file
end
```

#### Installing the gem globally (optional)
- Maybe you want install this gem globally to access it from any project, to do that you need to install the gem specific_install

  ```shell
  gem install specific_install
  gem specific_install https://github.com/lcuevastodoit/colorized_logs.git
  ```
- then obtain the path of the gem
  ```shell
  gem which colorized_logs
  ```

-  then add this line in the config/development.rb after `Rails.application.configure do`

```ruby
   require '<path of the gem>'
   Rails.application.configure do
    logger = ColorizedLogs.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = logger
    # the rest of the file
  end
```

## How to use
-  Just start the rails server and you can see some colored words on rails logs
  ```ruby
  bundle exec rails s
  ```
- If you want to colorize some words in specific color, you can pass an environment variable to the rails server. You can mark only one word or multiple words separated by comma

```shell
REDLOGS=error,fatal,lost bundle exec rails s
```

-  or if you use an alias to start the server. Use `export` before the alias

```shell
export REDLOGS=Controller,Service,gems rails_alias
```
#### Available environment variables
-  REDLOGS: colorize words in red
-  YELLOWLOGS: colorize words in yellow
-  GREENLOGS: colorize words in green
-  BLUELOGS: colorize words in blue
-  CYANLOGS: colorize words in cyan
-  PURPLELOGS: colorize words in purple
