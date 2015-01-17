if exists('g:loaded_autoload_gruntmaster') || v:version < 702
  finish
endif
let g:loaded_autoload_gruntmaster = 1

function! s:Gruntmaster()
ruby << EOF
  require 'rubygems'
  require 'net/http'
  require 'uri'
  
  class Gruntmaster
    attr_reader :user, :pass
    attr_accessor :url
    
    def initialize
      @user, @pass, @url = [VIM::evaluate("g:gruntmaster_username"), VIM::evaluate("g:gruntmaster_password"), VIM::evaluate("g:gruntmaster_base_url")].map { |v| v.chomp.strip }
      
      unless @user or @pass or @url
        VIM::message("Missing information. Consult README.md for more information")
      end
      
      @url.chop! if @url[-1] == '/'
    end

    def send_solution path
      uri = URI.parse(@url + path)
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.request_uri)
      request.basic_auth(@user, @pass)
      params = {"problem" => get_filename, "prog_format" => get_format_of_file, "source_code" => get_contents_of_file }
      request.set_form_data(params)
      response = http.request(request)
      log = response['Location']
      VIM::message("File was successfully uploaded to #{@url}.")
      open_in_browser(@url + log)
    end

    private
      def open_in_browser url
        cmd = case RUBY_PLATFORM
        when /darwin/ then "open"
        when /linux/ then "xdg-open"
        end
        VIM::command("call system('#{cmd} #{url}')")
      end
      
      def get_filename
        VIM::evaluate("expand('%:t:r')")
      end
      
      def get_format_of_file
        extension = VIM::evaluate("expand('%:t')").split(".")[1]
        case extension
        when 'c' then format = 'C'
        when 'cc', 'cpp', 'cxx', 'c' then format = 'CPP'
        when 'go' then format = 'GOLANG'
        when 'hs', 'lhs' then format = 'HASKELL'
        when 'java' then format = 'JAVA'
        when 'pss' then format = 'PASCAL'
        when 'pl' then format = 'PERL'
        when 'py' then format = 'PYTHON'
        end
      end
      
      def get_contents_of_file
        File.read(VIM::evaluate("expand('%:p')"))
      end
    
  end

  user = Gruntmaster.new
  
  # maybe I'll add different routes
  user.send_solution("/action/submit")
EOF
endfunction

command! -bar -narg=* SubmitToGruntmaster call s:Gruntmaster()
command! -bar -narg=* STG call s:Gruntmaster()
