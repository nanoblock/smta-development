class DeviseMailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers
  default from: 'contact@showmetheapps.co', template_path: 'users/mailer'
  layout 'mailer'

  def reset_password_instructions(record, token, opts={})
    @token = token
    @resource = record

    opts[:subject] = '[SHOWMETHEAPPS] 비밀번호를 잊으셨나요?'
    opts[:from] = 'contact@showmetheapps.co'
    opts[:template_path] = 'users/mailer'
    opts[:template_name] = 'reset_password_instructions'

    devise_mail(record, :reset_password_instructions, opts)
  end

  def confirmation_instructions(record, token ,opts={})
    @token = token
    @resource = record

    opts[:subject] = '[SHOWMETHEAPPS] 회원가입을 축하합니다! 이메일을 인증해주세요.'
    opts[:from] = 'contact@showmetheapps.co'
    opts[:template_path] = 'users/mailer'
    opts[:template_name] = 'confirmation_instructions'

    devise_mail(record, :confirmation_instructions, opts)
  end

  def unlock_instructions(record, token, opts={})
    @token = token

    opts[:subject] = '[SHOWMETHEAPPS] 회원가입을 축하합니다! 이메일을 인증해주세요.'
    opts[:from] = 'contact@showmetheapps.co'
    opts[:template_path] = 'users/mailer'
    opts[:template_name] = 'unlock_instructions'

    devise_mail(record, :unlock_instructions, opts)
  end


end