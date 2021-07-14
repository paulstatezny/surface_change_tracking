defmodule Wrapper do
  use Surface.Component

  slot default

  def render(assigns) do
    ~F"""
    <div>
      <#slot />
    </div>
    """
  end
end

defmodule Heading do
  use Surface.Component

  prop title, :string

  def render(assigns) do
    ~F"""
    <h1>
      {@title}
    </h1>
    """
  end
end

defmodule Person do
  use Ecto.Schema

  schema "people" do
    field :name, :string
  end
end

defmodule SurfaceChangeTrackingWeb.PageLive do
  use Surface.LiveView

  alias Ecto.Changeset
  alias Surface.Components.{
    Form,
    Form.TextInput
  }

  data changeset, :changeset

  def mount(_params, _session, socket) do

    socket = assign(socket, :changeset, Changeset.cast(%Person{}, %{}, []))
    {:ok, socket}
  end

  def render(assigns) do
    ~F"""
    <Wrapper>
      <Heading title="Welcome" />

      <Form for={@changeset} as={:person} change="change">
        <TextInput field={:name} />
      </Form>
    </Wrapper>
    """
  end

  def handle_event("change", %{"person" => params}, socket) do
    changeset = Changeset.cast(%Person{}, params, [:name])
    {:noreply, assign(socket, :changeset, changeset)}
  end
end
