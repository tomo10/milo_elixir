defmodule MiloWeb.Schema.ChangesetErrors do
  @doc """
  Transforms a changeset into a map of errors that can be returned in a GraphQL. For example:
  %{start_date: ["can't be blank"], end_date: ["can't be blank"]}
  """

  def error_details(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(
        opts,
        msg,
        fn {key, value}, acc ->
          String.replace(acc, "%{#{key}}", to_string(value))
        end
      )
    end)
  end
end
