class RegistrationsController < Devise::RegistrationsController
  layout 'application'
  self.responder = TurboDeviseController::Responder
  respond_to :html, :turbo_stream
end