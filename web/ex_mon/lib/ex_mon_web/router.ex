defmodule ExMonWeb.Router do
  use ExMonWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ExMonWeb do
    pipe_through :api
    resources "/trainers", TrainersController, only: [:create, :show, :delete, :update]
    # only defini quais rotas vc quer criar, pode se escolher a quantidade desejada
    resources "/trainer_pokemons", TrainerPokemonsController,
      only: [:create, :show, :delete, :update]

    get "/pokemons/:name", PokemonsController, :show

    # neste caso nao foi usado o resources para criar a rota show, criamos apenas o get com a action show
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: ExMonWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  scope "/", ExMonWeb do
    pipe_through :api

    get "/", WelcomeController, :index
  end
end
