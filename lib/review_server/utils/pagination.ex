defmodule ReviewServer.Utils.Pagination do
  @moduledoc """
  Provides a function `build_meta/1` to build pagination metadata
  """

  @doc false
  def build_meta(%Scrivener.Page{} = data) do
    %{
      page_number: data.page_number,
      page_size: data.page_size,
      total_pages: data.total_pages,
      total_entries: data.total_entries
    }
  end
end
