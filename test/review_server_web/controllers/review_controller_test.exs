defmodule ReviewServerWeb.ReviewControllerTest do
  use ReviewServerWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index/2" do
    test "renders errors without resource_id in params", %{conn: conn} do
      conn = get(conn, Routes.review_path(conn, :index))
      assert json_response(conn, 422)["errors"] == %{"resource_id" => ["can't be blank"]}
    end

    test "lists all reviews", %{conn: conn} do
      review = insert!(:review)
      conn = get(conn, Routes.review_path(conn, :index), resource_id: review.resource_id)

      assert json_response(conn, 200) == %{
               "reviews" => [
                 %{
                   "id" => review.id,
                   "rating" => review.rating,
                   "comment" => review.comment,
                   "resource_id" => review.resource_id,
                   "owner_id" => review.owner_id,
                   "inserted_at" => DateTime.to_iso8601(review.inserted_at),
                   "updated_at" => DateTime.to_iso8601(review.updated_at)
                 }
               ],
               "meta" => %{
                 "page_number" => 1,
                 "page_size" => 20,
                 "total_entries" => 1,
                 "total_pages" => 1
               }
             }
    end

    test "list all reviews with pagination and ordering", %{conn: conn} do
      review_one = insert!(:review)
      _review_two = insert!(:review, resource_id: review_one.resource_id)

      conn =
        get(
          conn,
          Routes.review_path(conn, :index),
          resource_id: review_one.resource_id,
          page: 2,
          page_size: 1
        )

      assert json_response(conn, 200) == %{
               "reviews" => [
                 %{
                   "id" => review_one.id,
                   "rating" => review_one.rating,
                   "comment" => review_one.comment,
                   "resource_id" => review_one.resource_id,
                   "owner_id" => review_one.owner_id,
                   "inserted_at" => DateTime.to_iso8601(review_one.inserted_at),
                   "updated_at" => DateTime.to_iso8601(review_one.updated_at)
                 }
               ],
               "meta" => %{
                 "page_number" => 2,
                 "page_size" => 1,
                 "total_entries" => 2,
                 "total_pages" => 2
               }
             }
    end
  end

  describe "show/2" do
    test "renders review if the review is found", %{conn: conn} do
      review = insert!(:review)

      conn = get(conn, Routes.review_path(conn, :show, review.id))

      assert json_response(conn, 200) == %{
               "review" => %{
                 "id" => review.id,
                 "rating" => review.rating,
                 "comment" => review.comment,
                 "resource_id" => review.resource_id,
                 "owner_id" => review.owner_id,
                 "inserted_at" => DateTime.to_iso8601(review.inserted_at),
                 "updated_at" => DateTime.to_iso8601(review.updated_at)
               }
             }
    end

    test "renders with a message indicating review not found", %{conn: conn} do
      error_message = Jason.encode!(%{errors: %{detail: "Not Found"}})

      response =
        assert_error_sent 404, fn ->
          get(conn, Routes.review_path(conn, :show, Ecto.UUID.generate()))
        end

      assert {404, [_h | _t], ^error_message} = response
    end

    test "renders with a bad request message if id not uuid", %{conn: conn} do
      error_message = Jason.encode!(%{errors: %{detail: "Bad Request"}})

      response =
        assert_error_sent 400, fn ->
          get(conn, Routes.review_path(conn, :show, "123"))
        end

      assert {400, [_h | _t], ^error_message} = response
    end
  end
end
