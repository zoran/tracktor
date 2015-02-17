class ApplicationController < ActionController::Metal

  # Remove unnecessary stuff
  WITHOUT = [
      AbstractController::Translation,
      AbstractController::AssetPaths,
      ActionController::UrlFor,
      ActionController::Redirecting,
      ActionController::Renderers::All,
      ActionController::ConditionalGet,
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
end
