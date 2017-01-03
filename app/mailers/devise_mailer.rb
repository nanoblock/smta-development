class DeviseMailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers
  default from: 'contact@showmetheapps.co'
  layout 'mailer'

  def reset_password_instructions(record, token, opts={})
    @token = token
    @resource = record

    opts[:subject] = 'This is Test subject'
    opts[:from] = 'contact@showmetheapps.co'
    opts[:template_path] = 'users/mailer'
    opts[:template_name] = 'reset_password_instructions'
    p opts
    devise_mail(record, :reset_password_instructions, opts)
  end


end