defmodule ExMonWeb.WelcomeController do
  use ExMonWeb, :controller

  def index(conn, _params) do
    text(conn, "Bem-vindo à API ExMon do Edilberto!")
  end
end
