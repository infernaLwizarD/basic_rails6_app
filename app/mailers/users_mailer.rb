class UsersMailer < Devise::Mailer
  def headers_for(action, opts)
    # moves the Devise template path from /views/devise/mailer to /views/web/users/mailer
    super.merge!({ template_path: '/web/users/mailer' })
  end
end
