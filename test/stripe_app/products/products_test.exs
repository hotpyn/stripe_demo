defmodule StripeApp.ProductsTest do
  use StripeApp.DataCase

  alias StripeApp.Products

  describe "books" do
    alias StripeApp.Products.Book

    @valid_attrs %{author: "some author", image: "some image", price: 120.5, title: "some title", url: "some url", visi: "some visi"}
    @update_attrs %{author: "some updated author", image: "some updated image", price: 456.7, title: "some updated title", url: "some updated url", visi: "some updated visi"}
    @invalid_attrs %{author: nil, image: nil, price: nil, title: nil, url: nil, visi: nil}

    def book_fixture(attrs \\ %{}) do
      {:ok, book} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Products.create_book()

      book
    end

    test "list_books/0 returns all books" do
      book = book_fixture()
      assert Products.list_books() == [book]
    end

    test "get_book!/1 returns the book with given id" do
      book = book_fixture()
      assert Products.get_book!(book.id) == book
    end

    test "create_book/1 with valid data creates a book" do
      assert {:ok, %Book{} = book} = Products.create_book(@valid_attrs)
      assert book.author == "some author"
      assert book.image == "some image"
      assert book.price == 120.5
      assert book.title == "some title"
      assert book.url == "some url"
      assert book.visi == "some visi"
    end

    test "create_book/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_book(@invalid_attrs)
    end

    test "update_book/2 with valid data updates the book" do
      book = book_fixture()
      assert {:ok, book} = Products.update_book(book, @update_attrs)
      assert %Book{} = book
      assert book.author == "some updated author"
      assert book.image == "some updated image"
      assert book.price == 456.7
      assert book.title == "some updated title"
      assert book.url == "some updated url"
      assert book.visi == "some updated visi"
    end

    test "update_book/2 with invalid data returns error changeset" do
      book = book_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_book(book, @invalid_attrs)
      assert book == Products.get_book!(book.id)
    end

    test "delete_book/1 deletes the book" do
      book = book_fixture()
      assert {:ok, %Book{}} = Products.delete_book(book)
      assert_raise Ecto.NoResultsError, fn -> Products.get_book!(book.id) end
    end

    test "change_book/1 returns a book changeset" do
      book = book_fixture()
      assert %Ecto.Changeset{} = Products.change_book(book)
    end
  end

  describe "plans" do
    alias StripeApp.Products.Plan

    @valid_attrs %{interval: ~N[2010-04-17 14:00:00.000000], name: "some name", price: 120.5, stripe_id: "some stripe_id", visible: true}
    @update_attrs %{interval: ~N[2011-05-18 15:01:01.000000], name: "some updated name", price: 456.7, stripe_id: "some updated stripe_id", visible: false}
    @invalid_attrs %{interval: nil, name: nil, price: nil, stripe_id: nil, visible: nil}

    def plan_fixture(attrs \\ %{}) do
      {:ok, plan} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Products.create_plan()

      plan
    end

    test "list_plans/0 returns all plans" do
      plan = plan_fixture()
      assert Products.list_plans() == [plan]
    end

    test "get_plan!/1 returns the plan with given id" do
      plan = plan_fixture()
      assert Products.get_plan!(plan.id) == plan
    end

    test "create_plan/1 with valid data creates a plan" do
      assert {:ok, %Plan{} = plan} = Products.create_plan(@valid_attrs)
      assert plan.interval == ~N[2010-04-17 14:00:00.000000]
      assert plan.name == "some name"
      assert plan.price == 120.5
      assert plan.stripe_id == "some stripe_id"
      assert plan.visible == true
    end

    test "create_plan/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_plan(@invalid_attrs)
    end

    test "update_plan/2 with valid data updates the plan" do
      plan = plan_fixture()
      assert {:ok, plan} = Products.update_plan(plan, @update_attrs)
      assert %Plan{} = plan
      assert plan.interval == ~N[2011-05-18 15:01:01.000000]
      assert plan.name == "some updated name"
      assert plan.price == 456.7
      assert plan.stripe_id == "some updated stripe_id"
      assert plan.visible == false
    end

    test "update_plan/2 with invalid data returns error changeset" do
      plan = plan_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_plan(plan, @invalid_attrs)
      assert plan == Products.get_plan!(plan.id)
    end

    test "delete_plan/1 deletes the plan" do
      plan = plan_fixture()
      assert {:ok, %Plan{}} = Products.delete_plan(plan)
      assert_raise Ecto.NoResultsError, fn -> Products.get_plan!(plan.id) end
    end

    test "change_plan/1 returns a plan changeset" do
      plan = plan_fixture()
      assert %Ecto.Changeset{} = Products.change_plan(plan)
    end
  end

  describe "getbooks" do
    alias StripeApp.Products.Getbook

    @valid_attrs %{book_id: 42, price: 120.5, stripe_charge_id: "some stripe_charge_id", user_id: 42}
    @update_attrs %{book_id: 43, price: 456.7, stripe_charge_id: "some updated stripe_charge_id", user_id: 43}
    @invalid_attrs %{book_id: nil, price: nil, stripe_charge_id: nil, user_id: nil}

    def getbook_fixture(attrs \\ %{}) do
      {:ok, getbook} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Products.create_getbook()

      getbook
    end

    test "list_getbooks/0 returns all getbooks" do
      getbook = getbook_fixture()
      assert Products.list_getbooks() == [getbook]
    end

    test "get_getbook!/1 returns the getbook with given id" do
      getbook = getbook_fixture()
      assert Products.get_getbook!(getbook.id) == getbook
    end

    test "create_getbook/1 with valid data creates a getbook" do
      assert {:ok, %Getbook{} = getbook} = Products.create_getbook(@valid_attrs)
      assert getbook.book_id == 42
      assert getbook.price == 120.5
      assert getbook.stripe_charge_id == "some stripe_charge_id"
      assert getbook.user_id == 42
    end

    test "create_getbook/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_getbook(@invalid_attrs)
    end

    test "update_getbook/2 with valid data updates the getbook" do
      getbook = getbook_fixture()
      assert {:ok, getbook} = Products.update_getbook(getbook, @update_attrs)
      assert %Getbook{} = getbook
      assert getbook.book_id == 43
      assert getbook.price == 456.7
      assert getbook.stripe_charge_id == "some updated stripe_charge_id"
      assert getbook.user_id == 43
    end

    test "update_getbook/2 with invalid data returns error changeset" do
      getbook = getbook_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_getbook(getbook, @invalid_attrs)
      assert getbook == Products.get_getbook!(getbook.id)
    end

    test "delete_getbook/1 deletes the getbook" do
      getbook = getbook_fixture()
      assert {:ok, %Getbook{}} = Products.delete_getbook(getbook)
      assert_raise Ecto.NoResultsError, fn -> Products.get_getbook!(getbook.id) end
    end

    test "change_getbook/1 returns a getbook changeset" do
      getbook = getbook_fixture()
      assert %Ecto.Changeset{} = Products.change_getbook(getbook)
    end
  end

  describe "getplans" do
    alias StripeApp.Products.Getplan

    @valid_attrs %{plan_id: 42, price: 120.5, status: 42, stripe_sub_id: "some stripe_sub_id", user_id: 42}
    @update_attrs %{plan_id: 43, price: 456.7, status: 43, stripe_sub_id: "some updated stripe_sub_id", user_id: 43}
    @invalid_attrs %{plan_id: nil, price: nil, status: nil, stripe_sub_id: nil, user_id: nil}

    def getplan_fixture(attrs \\ %{}) do
      {:ok, getplan} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Products.create_getplan()

      getplan
    end

    test "list_getplans/0 returns all getplans" do
      getplan = getplan_fixture()
      assert Products.list_getplans() == [getplan]
    end

    test "get_getplan!/1 returns the getplan with given id" do
      getplan = getplan_fixture()
      assert Products.get_getplan!(getplan.id) == getplan
    end

    test "create_getplan/1 with valid data creates a getplan" do
      assert {:ok, %Getplan{} = getplan} = Products.create_getplan(@valid_attrs)
      assert getplan.plan_id == 42
      assert getplan.price == 120.5
      assert getplan.status == 42
      assert getplan.stripe_sub_id == "some stripe_sub_id"
      assert getplan.user_id == 42
    end

    test "create_getplan/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_getplan(@invalid_attrs)
    end

    test "update_getplan/2 with valid data updates the getplan" do
      getplan = getplan_fixture()
      assert {:ok, getplan} = Products.update_getplan(getplan, @update_attrs)
      assert %Getplan{} = getplan
      assert getplan.plan_id == 43
      assert getplan.price == 456.7
      assert getplan.status == 43
      assert getplan.stripe_sub_id == "some updated stripe_sub_id"
      assert getplan.user_id == 43
    end

    test "update_getplan/2 with invalid data returns error changeset" do
      getplan = getplan_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_getplan(getplan, @invalid_attrs)
      assert getplan == Products.get_getplan!(getplan.id)
    end

    test "delete_getplan/1 deletes the getplan" do
      getplan = getplan_fixture()
      assert {:ok, %Getplan{}} = Products.delete_getplan(getplan)
      assert_raise Ecto.NoResultsError, fn -> Products.get_getplan!(getplan.id) end
    end

    test "change_getplan/1 returns a getplan changeset" do
      getplan = getplan_fixture()
      assert %Ecto.Changeset{} = Products.change_getplan(getplan)
    end
  end
end
