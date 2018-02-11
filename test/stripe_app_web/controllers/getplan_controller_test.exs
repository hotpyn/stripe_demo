defmodule StripeAppWeb.GetplanControllerTest do
  use StripeAppWeb.ConnCase

  alias StripeApp.Products

  @create_attrs %{plan_id: 42, price: 120.5, status: 42, stripe_sub_id: "some stripe_sub_id", user_id: 42}
  @update_attrs %{plan_id: 43, price: 456.7, status: 43, stripe_sub_id: "some updated stripe_sub_id", user_id: 43}
  @invalid_attrs %{plan_id: nil, price: nil, status: nil, stripe_sub_id: nil, user_id: nil}

  def fixture(:getplan) do
    {:ok, getplan} = Products.create_getplan(@create_attrs)
    getplan
  end

  describe "index" do
    test "lists all getplans", %{conn: conn} do
      conn = get conn, getplan_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Getplans"
    end
  end

  describe "new getplan" do
    test "renders form", %{conn: conn} do
      conn = get conn, getplan_path(conn, :new)
      assert html_response(conn, 200) =~ "New Getplan"
    end
  end

  describe "create getplan" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, getplan_path(conn, :create), getplan: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == getplan_path(conn, :show, id)

      conn = get conn, getplan_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Getplan"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, getplan_path(conn, :create), getplan: @invalid_attrs
      assert html_response(conn, 200) =~ "New Getplan"
    end
  end

  describe "edit getplan" do
    setup [:create_getplan]

    test "renders form for editing chosen getplan", %{conn: conn, getplan: getplan} do
      conn = get conn, getplan_path(conn, :edit, getplan)
      assert html_response(conn, 200) =~ "Edit Getplan"
    end
  end

  describe "update getplan" do
    setup [:create_getplan]

    test "redirects when data is valid", %{conn: conn, getplan: getplan} do
      conn = put conn, getplan_path(conn, :update, getplan), getplan: @update_attrs
      assert redirected_to(conn) == getplan_path(conn, :show, getplan)

      conn = get conn, getplan_path(conn, :show, getplan)
      assert html_response(conn, 200) =~ "some updated stripe_sub_id"
    end

    test "renders errors when data is invalid", %{conn: conn, getplan: getplan} do
      conn = put conn, getplan_path(conn, :update, getplan), getplan: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Getplan"
    end
  end

  describe "delete getplan" do
    setup [:create_getplan]

    test "deletes chosen getplan", %{conn: conn, getplan: getplan} do
      conn = delete conn, getplan_path(conn, :delete, getplan)
      assert redirected_to(conn) == getplan_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, getplan_path(conn, :show, getplan)
      end
    end
  end

  defp create_getplan(_) do
    getplan = fixture(:getplan)
    {:ok, getplan: getplan}
  end
end
