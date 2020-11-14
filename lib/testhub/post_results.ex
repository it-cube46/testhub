defmodule Testhub.PostResults do
  @moduledoc """
  The PostResults context.
  """

  import Ecto.Query, warn: false
  alias Testhub.Repo

  alias Testhub.PostResults.Result

  @doc """
  Returns the list of results.

  ## Examples

      iex> list_results()
      [%Result{}, ...]

  """
  def list_results do
    Repo.all(Result)
  end

  @doc """
  Gets a single result.

  Raises `Ecto.NoResultsError` if the Result does not exist.

  ## Examples

      iex> get_result!(123)
      %Result{}

      iex> get_result!(456)
      ** (Ecto.NoResultsError)

  """
  def get_result!(id), do: Repo.get!(Result, id)

  @doc """
  Creates a result.

  ## Examples

      iex> create_result(%{field: value})
      {:ok, %Result{}}

      iex> create_result(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_result(attrs \\ %{}) do
    %Result{}
    |> Result.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a result.

  ## Examples

      iex> update_result(result, %{field: new_value})
      {:ok, %Result{}}

      iex> update_result(result, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_result(%Result{} = result, attrs) do
    result
    |> Result.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a result.

  ## Examples

      iex> delete_result(result)
      {:ok, %Result{}}

      iex> delete_result(result)
      {:error, %Ecto.Changeset{}}

  """
  def delete_result(%Result{} = result) do
    Repo.delete(result)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking result changes.

  ## Examples

      iex> change_result(result)
      %Ecto.Changeset{data: %Result{}}

  """
  def change_result(%Result{} = result, attrs \\ %{}) do
    Result.changeset(result, attrs)
  end

  alias Testhub.PostResults.PostResult

  @doc """
  Returns the list of results.

  ## Examples

      iex> list_results()
      [%PostResult{}, ...]

  """
  def list_results do
    Repo.all(PostResult)
  end

  @doc """
  Gets a single post_result.

  Raises `Ecto.NoResultsError` if the Post result does not exist.

  ## Examples

      iex> get_post_result!(123)
      %PostResult{}

      iex> get_post_result!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post_result!(id), do: Repo.get!(PostResult, id)

  @doc """
  Creates a post_result.

  ## Examples

      iex> create_post_result(%{field: value})
      {:ok, %PostResult{}}

      iex> create_post_result(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post_result(attrs \\ %{}) do
    %PostResult{}
    |> PostResult.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post_result.

  ## Examples

      iex> update_post_result(post_result, %{field: new_value})
      {:ok, %PostResult{}}

      iex> update_post_result(post_result, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post_result(%PostResult{} = post_result, attrs) do
    post_result
    |> PostResult.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a post_result.

  ## Examples

      iex> delete_post_result(post_result)
      {:ok, %PostResult{}}

      iex> delete_post_result(post_result)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post_result(%PostResult{} = post_result) do
    Repo.delete(post_result)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post_result changes.

  ## Examples

      iex> change_post_result(post_result)
      %Ecto.Changeset{data: %PostResult{}}

  """
  def change_post_result(%PostResult{} = post_result, attrs \\ %{}) do
    PostResult.changeset(post_result, attrs)
  end
end
