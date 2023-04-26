defmodule MiloWeb.AuthToken do
  @user_salt "user auth salt"
  @doc """
  Encondes the given user id and signs it, returning a token clients can use as identification when using the API
  """
  def sign(user) do
    Phoenix.Token.sign(MiloWeb.Endpoint, @user_salt, %{id: user.id})
  end

  @doc """
  Decodes the orig data from the gien token and verifies its integrity
  """
  def verify(token) do
    Phoenix.Token.verify(MiloWeb.Endpoint, @user_salt, token, max_age: 365 * 24 * 60 * 60)
  end
end
