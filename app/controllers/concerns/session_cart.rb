module SessionCart
  def initialize_session
    session[:cart] ||= []
  end
end
