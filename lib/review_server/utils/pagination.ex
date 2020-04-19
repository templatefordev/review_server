defmodule ReviewServer.Utils.Pagination do
  def build_meta(data) do
    %{
      page_number: data.page_number,
      page_size: data.page_size,
      total_pages: data.total_pages,
      total_entries: data.total_entries
    }
  end
end
