defmodule PhxPizzaStore.Repo do
  use Ecto.Repo,
    otp_app: :phx_pizza_store,
    adapter: Ecto.Adapters.Postgres
end
