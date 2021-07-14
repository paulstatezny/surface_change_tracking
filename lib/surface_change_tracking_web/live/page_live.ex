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
  slot default

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

defmodule SurfaceChangeTrackingWeb.SlotsLive do
  use Surface.LiveView

  data page_title, :string, default: "Slots + change tracking"
  data counter, :integer, default: 0

  def render(assigns) do
    ~F"""
    <Wrapper>
      <Heading title="Slots can break change tracking" />

      <button :on-click="increment">
        Increment counter
      </button>

      <p>
        Counter: {@counter}
      </p>
    </Wrapper>

    <ul style="max-width: 480px; font-size: 18px">
      <li>
        In this example, we have a <code>Wrapper</code> component: just a
        <code>&lt;div&gt;</code> with a default slot.
      </li>
      <li>
        Inside there, we have a <code>&lt;Heading&gt;</code> component that takes a string prop.
        It wraps the string prop in a <code>&lt;h1&gt;</code> tag. <strong>It also contains a default slot.</strong>
      </li>
      <li>
        In this scenario, the existence of the slot in the <code>&lt;Heading&gt;</code> component
        breaks change tracking on its contents. The LiveView sends down <code>"Slots can break change tracking"</code>
        every time you emit an event by clicking the button, even though the value hasn't changed.
      </li>
      <li>
        The default slot isn't used in the <code>&lt;Heading&gt;</code> render function, but that doesn't change the broken behavior.
        In fact, the slot can be named anything (and be used or not) and change tracking will break the same way.
        (Try removing the slot from the component and see that change tracking is fixed.)
      </li>
    </ul>
    """
  end

  def handle_event("increment", _params, socket) do
    {:noreply, assign(socket, :counter, socket.assigns.counter + 1)}
  end
end
