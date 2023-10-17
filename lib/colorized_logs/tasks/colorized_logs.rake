namespace :colorized_logs do
  desc 'Install the colorized logs'
  task install: :environment do
    new_text = <<~TEXT
      Rails.application.configure do
        require 'colorized_logs'
        logger = ColorizedLogs.new(STDOUT)
        logger.formatter = config.log_formatter
        config.logger = logger
    TEXT
    old_text = 'Rails.application.configure do'
    file_path = 'config/environments/development.rb'
    file_contents = File.read(file_path)
    is_already_included = file_contents.include?(new_text)

    unless is_already_included
      new_contents = file_contents.gsub(old_text, new_text.chomp)
      File.write(file_path, new_contents)
    end
  end
end
