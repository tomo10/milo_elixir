defmodule MiloWeb.Schema.Middleware.Authenticate do
  @behaviour Absinthe.Middleware

  # this resolution struct is the same arguement as we get to as the third argument in our resolver functions

  @doc """
  If the resolution struct has a current_user key in its context, we return the resolution struct as is.
  """
  def call(resolution, _) do
    case resolution.context do
      %{current_user: _} -> resolution
      _ -> resolution |> Absinthe.Resolution.put_result({:error, "Please sign in first"})
    end
  end
end
