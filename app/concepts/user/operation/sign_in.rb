module User::Operation
  class SignIn < Trailblazer::Operation
    step Model(User, :find_by, :email)
    step :check_credentials
    fail :set_error
    pass :issue_token 

    def check_credentials(ctx, **)
      user = ctx[:model]
      password = ctx[:params][:password]
      user.authenticate(password)
    end

    def set_error(ctx, **)
      ctx[:error] = I18n.t('invalid_credentials')
    end

    def issue_token(ctx, **)
      token = JsonWebToken.encode(user_id: ctx[:model][:id])
      ctx[:token] = token
    end
  end
end
