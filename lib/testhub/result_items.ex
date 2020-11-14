defmodule Testhub.ResultItems do
  @moduledoc """
  The ResultItems context.
  """

  import Ecto.Query, warn: false
  alias Testhub.Repo

  alias Testhub.ResultItems.ResultItem

  @doc """
  Returns the list of resultitems.

  ## Examples

      iex> list_resultitems()
      [%ResultItem{}, ...]

  """
  def list_resultitems do
    Repo.all(ResultItem)
  end

  @doc """
  Gets a single result_item.

  Raises `Ecto.NoResultsError` if the Result item does not exist.

  ## Examples

      iex> get_result_item!(123)
      %ResultItem{}

      iex> get_result_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_result_item!(id), do: Repo.get!(ResultItem, id)

  @doc """
  Creates a result_item.

  ## Examples

      iex> create_result_item(%{field: value})
      {:ok, %ResultItem{}}

      iex> create_result_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_result_item(attrs \\ %{}) do
    %ResultItem{}
    |> ResultItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a result_item.

  ## Examples

      iex> update_result_item(result_item, %{field: new_value})
      {:ok, %ResultItem{}}

      iex> update_result_item(result_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_result_item(%ResultItem{} = result_item, attrs) do
    result_item
    |> ResultItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a result_item.

  ## Examples

      iex> delete_result_item(result_item)
      {:ok, %ResultItem{}}

      iex> delete_result_item(result_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_result_item(%ResultItem{} = result_item) do
    Repo.delete(result_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking result_item changes.

  ## Examples

      iex> change_result_item(result_item)
      %Ecto.Changeset{data: %ResultItem{}}

  """
  def change_result_item(%ResultItem{} = result_item, attrs \\ %{}) do
    ResultItem.changeset(result_item, attrs)
  end
end
