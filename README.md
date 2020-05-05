[![pipeline status](https://gitlab.com/multidesk24/review_server/badges/master/pipeline.svg)](https://gitlab.com/multidesk24/review_server/-/commits/master)

# ReviewServer API Spec

```text
API_URL=http://localhost:6000/api
```

# Endpoints

## List Reviews

`GET /reviews?resource_id=`

or

`GET /reviews?owner_id=`

Paginate (page_size default 20):
`?page=1&page_size=10`

Response(200 OK):

```JSON
{
  "reviews": [
    {
      "id": "aae0aa13-25f0-42af-bd81-fe90f68bc483",
      "rating": 1,
      "comment": "some comment 1",
      "resource_id": "d89e9aca-9f57-4250-abe8-50ec5e36bcf5",
      "owner_id": "d89e9aca-9f57-4250-abe8-50ec5e36bcf7",
      "inserted_at": "2020-04-30T23:07:04.851717Z",
      "updated_at": "2020-04-30T23:07:04.851717Z"
    }
  ],
  "meta": {
    "page_number": 1,
    "page_size": 20,
    "total_entries": 1,
    "total_pages": 1
  }
}
```

## Get Review

`GET /reviews/:id`

Response(200 OK):

```JSON
{
  "review": {
    "id": "aae0aa13-25f0-42af-bd81-fe90f68bc483",
    "rating": 1,
    "comment": "some comment 1",
    "resource_id": "d89e9aca-9f57-4250-abe8-50ec5e36bcf5",
    "owner_id": "d89e9aca-9f57-4250-abe8-50ec5e36bcf7",
    "inserted_at": "2020-04-30T23:07:04.851717Z",
    "updated_at": "2020-04-30T23:07:04.851717Z"
  }
}
```

## Create Review

`POST /reviews`

Example request body:

```JSON
{
  "review": {
    "rating": 4,
    "comment": "some comment",
    "resource_id": "d89e9aca-9f57-4250-abe8-50ec5e36bcf1",
    "owner_id": "d89e9aca-9f57-4250-abe8-50ec5e36bcf9"
  }
}
```

Response(201 Created):

```JSON
{
  "review": {
    "id": "83853ac4-f70c-4f30-b6bb-29bdcd6ae3de",
    "rating": 4,
    "comment": "some comment",
    "owner_id": "d89e9aca-9f57-4250-abe8-50ec5e36bcf9",
    "resource": {
      "id": "d89e9aca-9f57-4250-abe8-50ec5e36bcf1",
      "avg_rating": "4.00",
      "count_reviews": 1
    }
  }
}
```

## Update Review

`PUT /reviews/:id`

Example request body:

```JSON
{
  "review": {
    "rating": 5,
    "comment": "some comment updated"
  }
}
```

Response(200 OK):

```JSON
{
  "review": {
    "id": "83853ac4-f70c-4f30-b6bb-29bdcd6ae3de",
    "rating": 5,
    "comment": "some comment updated",
    "owner_id": "d89e9aca-9f57-4250-abe8-50ec5e36bcf9",
    "resource": {
      "id": "d89e9aca-9f57-4250-abe8-50ec5e36bcf1",
      "avg_rating": "5.00",
      "count_reviews": 1
    }
  }
}
```

## Delete Review

`DELETE /reviews/:id`

Response(204 No Content)

## Delete Reviews by resource_id

`DELETE /reviews/?resource_id=`

Response(204 No Content)

## Get Resource stats

`GET /resources/:id/stats`

Response(200 OK):

```JSON
{
  "resource": {
    "id": "d89e9aca-9f57-4250-abe8-50ec5e36bcf1",
    "avg_rating": "3.43",
    "count_reviews": 7
  }
}
```

## ERRORS

If a request fails any validations, expect a 422 and errors in the following format:

```JSON
{
  "errors": {
    "owner_id": ["can't be blank"],
    "rating": ["can't be blank"]
  }
}
```

400 for Bad request:

```JSON
{
  "errors": {
    "detail": "Bad Request"
  }
}
```

404 for Not found request:

```JSON
{
  "errors": {
    "detail": "Not Found"
  }
}
```

500 for Internal Server Error:

```JSON
{
  "errors": {
    "detail": "Internal Server Error"
  }
}
```

To start your Phoenix server:

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:6000`](http://localhost:6000) from your browser.
