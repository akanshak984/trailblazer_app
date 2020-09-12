module User::Operation
  class SignUp < Trailblazer::Operation
    step Model(User, :new)
    step Contract::Build(constant: User::Contract::Form)
    step Contract::Validate(key: :user)
    step Contract::Persist()
    fail :set_error
    pass :issue_auth_token

    def set_error(ctx, **)
      error = ctx[:"contract.default"].errors.full_messages
      ctx[:error] = error
    end

    def issue_auth_token(ctx, **)
      token = JsonWebToken.encode(user_id: ctx[:model][:id])
      ctx[:token] = token
    end
  end
end
