defmodule ReviewServerWeb.ReviewControllerTest do
  use ReviewServerWeb.ConnCase

  @create_attrs %{
    rating: 1,
    comment: "some comment",
    resource_id: "e31e9137-97f5-497e-bcd2-34c35169a883",
    owner_id: "7488a646-e31f-11e4-aace-600308960662"
  }
  @update_attrs %{
    rating: 5,
    comment: "some updated comment"
  }
  @invalid_attrs %{rating: nil, comment: nil, resource_id: nil, owner_id: nil}

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

  describe "create/2" do
    test "renders review when data is valid", %{conn: conn} do
      conn = post(conn, Routes.review_path(conn, :create), review: @create_attrs)

      assert %{
               "id" => id,
               "rating" => 1,
               "comment" => "some comment",
               "resource_id" => "e31e9137-97f5-497e-bcd2-34c35169a883",
               "owner_id" => "7488a646-e31f-11e4-aace-600308960662",
               "inserted_at" => inserted_at,
               "updated_at" => updated_at
             } = json_response(conn, 201)["review"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.review_path(conn, :create), review: @invalid_attrs)

      assert json_response(conn, 422)["errors"] == %{
               "owner_id" => ["can't be blank"],
               "rating" => ["can't be blank"],
               "resource_id" => ["can't be blank"]
             }
    end

    test "renders errors when rating is less than 1", %{conn: conn} do
      conn = post(conn, Routes.review_path(conn, :create), review: %{@invalid_attrs | rating: 0})
      assert %{"rating" => ["must be greater than 0"]} = json_response(conn, 422)["errors"]
    end

    test "renders errors when rating is greater than 5", %{conn: conn} do
      conn = post(conn, Routes.review_path(conn, :create), review: %{@invalid_attrs | rating: 6})
      assert %{"rating" => ["must be less than 6"]} = json_response(conn, 422)["errors"]
    end

    test "renders errors when uuid is valid", %{conn: conn} do
      conn =
        post(conn, Routes.review_path(conn, :create),
          review: %{@invalid_attrs | resource_id: "123", owner_id: "123"}
        )

      assert %{
               "resource_id" => ["is invalid"],
               "owner_id" => ["is invalid"]
             } = json_response(conn, 422)["errors"]
    end
  end

  describe "update/2" do
    setup do
      {:ok, review: insert!(:review)}
    end

    test "renders review when data is valid", %{conn: conn, review: %Review{id: id} = review} do
      conn = put(conn, Routes.review_path(conn, :update, review), review: @update_attrs)

      assert %{
               "id" => ^id,
               "rating" => 5,
               "comment" => "some updated comment",
               "resource_id" => resource_id,
               "owner_id" => owner_id,
               "inserted_at" => inserted_at,
               "updated_at" => updated_at
             } = json_response(conn, 200)["review"]
    end

    test "renders with a message indicating review not found", %{conn: conn} do
      error_message = Jason.encode!(%{errors: %{detail: "Not Found"}})

      response =
        assert_error_sent 404, fn ->
          get(conn, Routes.review_path(conn, :show, Ecto.UUID.generate()))
        end

      assert {404, [_h | _t], ^error_message} = response
    end

    test "renders errors when rating is less than 1", %{conn: conn, review: review} do
      conn =
        put(conn, Routes.review_path(conn, :update, review), review: %{@update_attrs | rating: 0})

      assert %{"rating" => ["must be greater than 0"]} = json_response(conn, 422)["errors"]
    end

    test "renders errors when rating is greater than 5", %{conn: conn, review: review} do
      conn =
        put(conn, Routes.review_path(conn, :update, review), review: %{@update_attrs | rating: 6})

      assert %{"rating" => ["must be less than 6"]} = json_response(conn, 422)["errors"]
    end

    test "renders errors when data is invalid", %{conn: conn, review: review} do
      conn = put(conn, Routes.review_path(conn, :update, review), review: @invalid_attrs)

      assert json_response(conn, 422)["errors"] == %{
               "rating" => ["can't be blank"]
             }
    end
  end
end
