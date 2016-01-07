module UsersHelper

  # net/http is required for the gravatar_exists? method
  require 'net/http'

  # Returns true if a Gravatar account exists for given user's email address
  def gravatar_exists?(user)
    gravatar_check = "http://gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email.downcase)}.png?d=404"
    uri = URI.parse(gravatar_check)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    response.code.to_i != 404 # from d=404 parameter
  end

  # Returns the Gravatar for the given user
  def show_gravatar(user, size = 150)
    max_rating = 'g'
    default_image = 'monsterid'
    email_hash = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{email_hash}?s=#{size * 2}?r=#{max_rating}?d=#{default_image}"
    return image_tag(gravatar_url, alt: user.name, class: "gravatar", width: size, height: size)
  end

end
