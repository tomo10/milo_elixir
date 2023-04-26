defmodule MiloWeb.Router do
  use MiloWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug MiloWeb.Plugs.SetCurrentUser
  end

  # this stuff explained 7.00 min of GQL prag prog video
  # or at 2 mins of video 16

  scope "/api", MiloWeb do
    pipe_through :api
    forward("/", Absinthe.Plug, schema: MiloWeb.Schema.Schema)
  end

  scope "/gql" do
    pipe_through :api
    forward "/GraphiQL", Absinthe.Plug.GraphiQL, schema: MiloWeb.Schema.Schema
  end

  # scope "/" do
  #   pipe_through :api

  #   forward("/api", Absinthe.Plug, schema: MiloWeb.Schema.Schemas)

  #   forward("/graphiql", Absinthe.Plug.GraphiQL,
  #     schema: MiloWeb.Schema.Schema,
  #     socket: MiloWeb.UserSocket
  #   )
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:milo, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: MiloWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
