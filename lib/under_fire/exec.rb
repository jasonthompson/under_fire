module UnderFire
  class Exec
    attr_reader :args, :input

    def initialize(args, input)
      @args = args
      @input = input
      parse_input(args)
    end

    def parse_input(input)
      if input.first[0] == '-'
        puts execute(input.first, options)
      else
        puts execute(input.first, commands)
      end
      puts output
    end

    def execute(item, options)
      if option_exists?(item, options)
        puts send options[item]
      else
        invalid_argument(item)
      end
    end

    

    def invalid_argument(arg)
      puts "'#{arg}' is not a valid argument.\n #{help}"
    end

    def options
      {"-h"=>:help,
       "--help"=>:help}
    end

    def commands
      {"album"=>:album,
       "toc"=>:toc}
    end

    def album_options
      {"-h"=>:help,
       "--help"=>:help,
       "-a"=>:artist,
       "--artist"=>:artist,
       "-s"=>:track_title,
       "--song"=>:track_title,
       "-t"=>:album_title,
       "--album_title"=>:album_title}
    end

    def toc_options
      {"-h"=>:help,
       "--help"=>:help}
    end

    def accepted?(item, accepted_collection)
      options.has_key?(accepted_collection)
    end

    def help
      "You need help."
    end

    def album
      
    end

    def toc
      toc = ""
      if args[1][0] == "-" && option_exists?(args[1], toc_options)
        puts send(toc_options, arg)
      elsif args[1][0] == "-"
        puts invalid_argument(args[1])
      else
        toc = args[1..-1]
      end
    end
  end
end
