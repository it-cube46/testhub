defmodule Testhub.TestsApi do
  @moduledoc """
  The TestsApi context.
  """

  import Ecto.Query, warn: false
  alias Testhub.Repo

  alias Testhub.TestsApi.TestApi

  @doc """
  Returns the list of tests.

  ## Examples

      iex> list_tests()
      [%TestApi{}, ...]

  """
  def list_tests do
    Repo.all(TestApi)
  end

  @doc """
  Gets a single test_api.

  Raises `Ecto.NoResultsError` if the Test api does not exist.

  ## Examples

      iex> get_test_api!(123)
      %TestApi{}

      iex> get_test_api!(456)
      ** (Ecto.NoResultsError)

  """
  def get_test_api!(id), do: Repo.get!(TestApi, id)

  @doc """
  Creates a test_api.

  ## Examples

      iex> create_test_api(%{field: value})
      {:ok, %TestApi{}}

      iex> create_test_api(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_test_api(attrs \\ %{}) do
    %TestApi{}
    |> TestApi.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a test_api.

  ## Examples

      iex> update_test_api(test_api, %{field: new_value})
      {:ok, %TestApi{}}

      iex> update_test_api(test_api, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_test_api(%TestApi{} = test_api, attrs) do
    test_api
    |> TestApi.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a test_api.

  ## Examples

      iex> delete_test_api(test_api)
      {:ok, %TestApi{}}

      iex> delete_test_api(test_api)
      {:error, %Ecto.Changeset{}}

  """
  def delete_test_api(%TestApi{} = test_api) do
    Repo.delete(test_api)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking test_api changes.

  ## Examples

      iex> change_test_api(test_api)
      %Ecto.Changeset{data: %TestApi{}}

  """
  def change_test_api(%TestApi{} = test_api, attrs \\ %{}) do
    TestApi.changeset(test_api, attrs)
  end
end
