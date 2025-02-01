defmodule PhxPizza.Repo do
  use Ecto.Repo,
    otp_app: :phx_pizza,
    adapter: Ecto.Adapters.Postgres
end
