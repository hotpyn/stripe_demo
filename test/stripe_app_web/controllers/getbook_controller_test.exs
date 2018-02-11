defmodule StripeAppWeb.GetbookControllerTest do
  use StripeAppWeb.ConnCase

  alias StripeApp.Products

  @create_attrs %{book_id: 42, price: 120.5, stripe_charge_id: "some stripe_charge_id", user_id: 42}
  @update_attrs %{book_id: 43, price: 456.7, stripe_charge_id: "some updated stripe_charge_id", user_id: 43}
  @invalid_attrs %{book_id: nil, price: nil, stripe_charge_id: nil, user_id: nil}

  def fixture(:getbook) do
    {:ok, getbook} = Products.create_getbook(@create_attrs)
    getbook
  end

  describe "index" do
    test "lists all getbooks", %{conn: conn} do
      conn = get conn, getbook_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Getbooks"
    end
  end

  describe "new getbook" do
    test "renders form", %{conn: conn} do
      conn = get conn, getbook_path(conn, :new)
      assert html_response(conn, 200) =~ "New Getbook"
    end
  end

  describe "create getbook" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, getbook_path(conn, :create), getbook: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == getbook_path(conn, :show, id)

      conn = get conn, getbook_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Getbook"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, getbook_path(conn, :create), getbook: @invalid_attrs
      assert html_response(conn, 200) =~ "New Getbook"
    end
  end

  describe "edit getbook" do
    setup [:create_getbook]

    test "renders form for editing chosen getbook", %{conn: conn, getbook: getbook} do
      conn = get conn, getbook_path(conn, :edit, getbook)
      assert html_response(conn, 200) =~ "Edit Getbook"
    end
  end

  describe "update getbook" do
    setup [:create_getbook]

    test "redirects when data is valid", %{conn: conn, getbook: getbook} do
      conn = put conn, getbook_path(conn, :update, getbook), getbook: @update_attrs
      assert redirected_to(conn) == getbook_path(conn, :show, getbook)

      conn = get conn, getbook_path(conn, :show, getbook)
      assert html_response(conn, 200) =~ "some updated stripe_charge_id"
    end

    test "renders errors when data is invalid", %{conn: conn, getbook: getbook} do
      conn = put conn, getbook_path(conn, :update, getbook), getbook: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Getbook"
    end
  end

  describe "delete getbook" do
    setup [:create_getbook]

    test "deletes chosen getbook", %{conn: conn, getbook: getbook} do
      conn = delete conn, getbook_path(conn, :delete, getbook)
      assert redirected_to(conn) == getbook_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, getbook_path(conn, :show, getbook)
      end
    end
  end

  defp create_getbook(_) do
    getbook = fixture(:getbook)
    {:ok, getbook: getbook}
  end
end
