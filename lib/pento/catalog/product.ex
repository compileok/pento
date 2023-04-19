defmodule Pento.Catalog.Product do
  #Notice the use Ecto.Schema expression.
  #The use macro injects code from the specified module into the current module.
  #Here, the generated code is giving the Product schema access to the functionality implemented in the Ecto.Schema module.
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :description, :string
    field :name, :string
    field :sku, :integer
    field :unit_price, :float

    # “The timestamps function means our code will also have :inserted_at and updated_at timestamps.”
    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    # Ecto.Changeset.cast/4 function filters the user data we pass into params.
    # our changeset allows the :name,:description,:unit_price,:sku fields, other fields are rejected.
    # and transforms them int the right types.
    |> cast(attrs, [:name, :description, :unit_price, :sku])
    |> validate_required([:name, :description, :unit_price, :sku])
    |> unique_constraint(:sku)
    |> validate_number(:unit_price, greater_than: 0.0)
  end
end
