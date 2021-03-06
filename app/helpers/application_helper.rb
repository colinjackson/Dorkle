module ApplicationHelper
  def auth_input
    <<-HTML.html_safe
      <input type="hidden" name="authenticity_token"
          value="#{form_authenticity_token}">
    HTML
  end

  def update_input(method)
    <<-HTML.html_safe
      <input type="hidden" name="_method" value="#{method}">
    HTML
  end

  def time_string(time)
    return "0:00" if time <= 0

    mins = (time / 60).to_s
    secs = "0#{(time % 60)}".last(2)

    "#{mins}:#{secs}"
  end

  def auth_action?
    authActions = ["create", "new", "edit", "update", "destroy"]
    authControllers = ["users", "sessions"]

    authActions.include?(params[:action]) &&
      authControllers.include?(params[:controller])
  end

  def acquiesce
    ["yep", "uh-huh", "got it", "cool", "okay", "kthxbye"].sample
  end
end
