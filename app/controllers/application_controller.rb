class ApplicationController < ActionController::Metal

  # Remove unnecessary stuff
  # We must keep ActionController::ConditionalGet to be able to
  # respond with "head 200" instead of "render nothing: true, status: 200"
  WITHOUT = [
      AbstractController::Translation,
      AbstractController::AssetPaths,
      ActionController::UrlFor,
      ActionController::Redirecting,
      ActionController::Renderers::All,
      ActionController::Caching,
      ActionController::MimeResponds,
      ActionController::Cookies,
      ActionController::Flash,
      ActionController::RequestForgeryProtection,
      ActionController::Streaming,
      ActionController::DataStreaming,
      ActionController::HttpAuthentication::Basic::ControllerMethods,
      ActionController::HttpAuthentication::Digest::ControllerMethods,
      ActionController::HttpAuthentication::Token::ControllerMethods,
      ActionController::Instrumentation,
      ActionController::ParamsWrapper
  ]

  ActionController::Base.without_modules(*WITHOUT).each do |el|
    include el
  end

  # Delay failures for up to 20ms to thwart timing based attacks
  def delay
    sleep SecureRandom.random_number(10)
  end
end

