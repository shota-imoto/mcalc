module UrlHelper
  require 'uri'

  def app_url_with_params(params)
    url_with_params(app_url, params)
  end

  def url_with_params(url, params)
    params_str = URI.encode_www_form(params)
    url.concat('?', params_str)
  end

  private

  def app_url
    'firecountdownapp://home'
  end
end
