defmodule SurfaceChangeTrackingWeb.FormChangesetLive do
  use Surface.LiveView

  defmodule Input do
    use Surface.Component
    alias Surface.Components.Form.TextInput
    prop label, :string, required: true
    def render(assigns) do
      ~F"""
      {@label}
      <TextInput />
      """
    end
  end

  alias Surface.Components.{Form, Form.FieldContext}
  alias Ecto.Changeset

  data changeset, :changeset

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :changeset, changeset())}
  end

  def render(assigns) do
    ~F"""
    <Form for={@changeset} as={:person} change="change">
      <FieldContext name={:name}>
        <Input label="Name" />
      </FieldContext>
    </Form>
    """
  end

  def handle_event("change", %{"person" => params}, socket) do
    {:noreply, assign(socket, :changeset, changeset(params))}
  end

  defp changeset(params \\ %{}) do
    {%{}, %{name: :string}}
    |> Changeset.cast(params, [:name])
  end
end
