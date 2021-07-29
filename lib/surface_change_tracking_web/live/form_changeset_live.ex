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

    <ul style="max-width: 640px; font-size: 18px">
      <li>
        This example has <code>&lt;Form for=&#123;@changeset&#125; change="change"&gt;</code>
      </li>

      <li>
        There is also an <code>Input</code> component, which renders a
        <code>Surface.Components.Form.TextInput</code> and a label passed in as a prop.
      </li>

      <li>
        The change event handler simply updates <code>assigns.changeset</code>
        using the input data.
      </li>

      <li>
        Note that when the change event fires (by typing in the input), the
        label "Name" is sent in the set of changes even though it hasn't
        changed, and even though none of the LiveEEx Pitfalls outlined in the
        <a target="_blank" href="https://hexdocs.pm/phoenix_live_view/assigns-eex.html#liveeex-pitfalls">official guide</a>
        have been violated.
      </li>
    </ul>
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
