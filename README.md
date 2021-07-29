# SurfaceChangeTracking

An attempt to reproduce a potential issue with Surface and LiveView change tracking.

To start the Phoenix server:

  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Problem scenarios

### Change tracking breaking with nested components using slots

Start the server as directed above, and navigate to
[`localhost:4000`](http://localhost:4000).  The page contains instructions and
explanation.

### Change tracking breaking with Forms backed by Changesets

Start the server as directed above, and navigate to
[`localhost:4000/form-for-changeset`](http://localhost:4000/form-for-changeset).
The page contains instructions and explanation.
