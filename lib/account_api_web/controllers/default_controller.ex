defmodule AccountApiWeb.DefaultController do
  use AccountApiWeb, :controller

  def index(conn, _params) do
    text(conn, "Welcome to Account API")
  end
end
