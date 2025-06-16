class SessionsController < Devise::SessionsController
  layout 'application'
  self.responder = TurboDeviseController::Responder
  respond_to :html, :turbo_stream

  def create
    super { @token = current_token }
  end

  def show
  end

  private

  def current_token
    request.env['warden-jwt_auth.token']
  end
end