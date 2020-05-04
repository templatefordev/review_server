defmodule ReviewServerWeb.ResourceControllerTest do
  @moduledoc false

  use ReviewServerWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "show/2" do
    test "renders review if the review is found", %{conn: conn} do
      resource_id = Ecto.UUID.generate()
      _review = insert!(:review, rating: 1, resource_id: resource_id)
      review = insert!(:review, rating: 4, resource_id: resource_id)

      conn = get(conn, Routes.resource_path(conn, :show, review.resource_id))

      assert json_response(conn, 200) == %{
               "resource" => %{
                 "id" => review.resource_id,
                 "avg_rating" => "2.50",
                 "count_reviews" => 2
               }
             }
    end

    test "renders with a message indicating review not found", %{conn: conn} do
      error_message = Jason.encode!(%{errors: %{detail: "Not Found"}})

      response =
        assert_error_sent 404, fn ->
          get(conn, Routes.resource_path(conn, :show, Ecto.UUID.generate()))
        end

      assert {404, [_h | _t], ^error_message} = response
    end

    test "renders with a bad request message if id not uuid", %{conn: conn} do
      error_message = Jason.encode!(%{errors: %{detail: "Bad Request"}})

      response =
        assert_error_sent 400, fn ->
          get(conn, Routes.resource_path(conn, :show, "123"))
        end

      assert {400, [_h | _t], ^error_message} = response
    end
  end
end
