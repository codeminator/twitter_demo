module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from Twitter::Error::TooManyRequests do |ex|
      flash[:error] = t('app.messages.errors.rate_limit_exceeded')
      redirect_to error_url
    end
    rescue_from Twitter::Error::NotFound do |ex|
      flash[:error] = t('app.messages.errors.user_not_found')
      redirect_to error_url
    end
    rescue_from Twitter::Error::RequestTimeout do |ex|
      flash[:error] = t('app.messages.errors.timeout')
      redirect_to error_url
    end

    rescue_from OAuth::Unauthorized do |ex|
      flash[:error] = t('app.messages.errors.auth_required')
      redirect_to error_url
    end
  end
end