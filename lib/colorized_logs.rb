require 'active_support/logger'

class ColorizedLogs < ActiveSupport::Logger
  def initialize(*args)
    super
    define_color_maps
  end

  def add(severity, message = nil, progname = nil, &block)
    message = colorize_log(yield) if progname.nil? && block
    progname = colorize_log(progname) if progname

    super(severity, message, progname, &block)
  end

  private

  def colorize_log(text)
    @colored_output = String.new(text) if text.is_a?(String)
    @colored_output ||= String.new(text.inspect.to_s)

    @color_maps.each do |color, keywords|
      colorize_word(color, keywords)
    end

    @colored_output
  end

  def colorize_word(color, keywords)
    keywords.each do |keyword|
      if @colored_output.include?(keyword)
        @colored_output.gsub!(keyword, "\e[1m\e[#{ansi_colors[color]}m#{keyword}\e[0m")
      else
        @colored_output = "\e[1m\e[#{ansi_colors[:yellow]}m#{@colored_output}\e[0m"
      end
    end
  end

  def define_color_maps
    colors = %i[red yellow green blue cyan purple]
    @color_maps = {}
    colors.each do |color|
      @color_maps[color] = color_logs(color)
    end
  end

  def color_logs(color)
    env_color = ENV["#{color.to_s.upcase}LOGS"]
    colored_words = env_color.split(',') if env_color
    colored_words ||= send("default_#{color.to_s}_words")
    colored_words
  end

  def default_red_words
    %w[ERROR FATAL Failed Error not_found unprocessable_entity not_method]
  end

  def default_yellow_words
    %w[DEBUG]
  end

  def default_green_words
    %w[INFO GET POST PUT PATCH DELETE Controller Service Helper # 200 OK]
  end

  def default_blue_words
    %w[WARN index show new edit create update destroy]
  end

  def default_cyan_words
    %w[Processing Parameters]
  end

  def default_purple_words
    %w[Completed]
  end

  def ansi_colors
    {
      red: 31,    # Red
      yellow: 33, # Yellow
      green: 32,  # Green
      blue: 34,  # Blue
      cyan: 36,  # Cyan
      purple: 35 # Purple
    }
  end
end
