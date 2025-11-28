---
tags: general, software, programming
summary: Build an example application using Vapor and HTMX.
image: https://photos.housh.dev/share/HGtNgmJwRYTtnAckizIyFc27ZsTXhzvv7P1kJkBuPYfvNRdjZybz5BfBEw-jMEQNL6U
---

# Vapor + HTMX

## Introduction

This post is a quick example of creating a very basic todo web application using `Vapor` a swift web
framework and `Htmx`, with no custom javascript required.

[Vapor](https://docs.vapor.codes)

[Htmx](https://htmx.org)

## Getting Started

To get started you must install the vapor command-line tool that will generate our project.

```bash
brew install vapor
```

Next, generate the project using the vapor command-line tool.

![](/articles/images/2025-01-05-vapor.gif)

```bash
vapor new todo-htmx --fluent.db sqlite --leaf
```

The above command will generate a new project that uses an `SQLite` database along with vapor's
`Leaf` templating engine. You can move into the project directory and browse around the files that
are generated.

```bash
cd todo-htmx
```

## Update the Controller

Open the `Sources/App/Controllers/TodoController.swift` file. This file handles the api routes for
our `Todo` database model. Personally I like to prefix these routes with `api`.

Update the first line in the `boot(routes: RoutesBuilder)` function to look like this.

```swift
let todos = routes.grouped("api", "todos")
```

Everything else can stay the same. This changes these routes to be exposed at
`http://localhost:8080/api/todos`, which will allow our routes that return html views to be able to
be exposed at `http://localhost:8080/todos`.

## Update the Todo Model

A todo is not very valuable without a way to tell if it needs to be completed or not. So, let's add
a field to our database model (`Sources/App/Models/Todo.swift`).

Update the file to include the following:

```swift
import Fluent
import struct Foundation.UUID

/// Property wrappers interact poorly with `Sendable` checking, causing a warning for the `@ID` property
/// It is recommended you write your model with sendability checking on and then suppress the warning
/// afterwards with `@unchecked Sendable`.
final class Todo: Model, @unchecked Sendable {
  static let schema = "todos"

  @ID(key: .id)
  var id: UUID?

  @Field(key: "title")
  var title: String

  @Field(key: "complete")
  var complete: Bool

  init() {}

  init(id: UUID? = nil, title: String, complete: Bool) {
    self.id = id
    self.title = title
    self.complete = complete
  }

  func toDTO() -> TodoDTO {
    .init(
      id: id,
      title: $title.value,
      complete: $complete.value
    )
  }
}
```

Since we added a field to our database model, we also need to update the migration file
(`Sources/App/Migrations/CreateTodo.swift`).

```swift
import Fluent

struct CreateTodo: AsyncMigration {
  func prepare(on database: Database) async throws {
    try await database.schema("todos")
      .id()
      .field("title", .string, .required)
      .field("complete", .bool, .required)
      .create()
  }

  func revert(on database: Database) async throws {
    try await database.schema("todos").delete()
  }
}
```

This just adds our new field to the database schema when we run the migrations, which we will do
later on in the tutorial.

### Update the Data Transfer Object

We also need to add the `complete` field to our data transfer object (`DTO`). This model is used as
an intermediate between our database and the user.

```swift
import Fluent
import Vapor

struct TodoDTO: Content {
  var id: UUID?
  var title: String?
  var complete: Bool?

  func toModel() -> Todo {
    let model = Todo()

    model.id = id
    model.complete = complete ?? false
    if let title = title {
      model.title = title
    }
    return model
  }
}
```

## Generate the View Templates

Our index template was already generated at `Resources/Views/index.leaf`, open the file and edit the
contents to match the following.

> Note: You can learn more about the
> [leaf templating engine here.](https://docs.vapor.codes/leaf/getting-started/)

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>#(title)</title>
    <link rel="stylesheet" href="css/main.css" />
    <script src="https://unpkg.com/htmx.org@2.0.4"></script>
  </head>

  <body>
    <h1>#(title)</h1>
    <div class="container">
      <form hx-post="/todos" hx-target="#todos">
        <label for="title">Todo</label>
        <input type="text" name="title" placeholder="Title" />
        <button type="submit">Submit</button>
      </form>

      <!-- Todos List -->
      <table id="todos" class="todos" hx-get="/todos" hx-trigger="load"></table>
    </div>
  </body>
</html>
```

The important parts here are the `<script>` tag in the head element which will include `Htmx` in our
project.

The head element also contains a link to a custom `css` stylesheet that we will create shortly.

We add a `form` element that will be used to generate a new todo item in the database. This is a
basic / standard html form, but we are using `Htmx` to post the form contents to the route
`POST http://localhost:8080/todos`, which we will create shortly.

Then there's the `table` element that will contain the contents of our todos. When the page is
loaded it will use `Htmx` to fetch the todos from `GET http://localhost:8080/todos` route, which we
will create shortly.

### Todos Table Template

Create a new view template that will return our populated table of todos.

```bash
touch Resources/Views/todos.leaf
```

The contents of this file should be the following:

```html
<!-- Template for a list of todo's -->
<table id="todos"
    class="todos">
  <!-- The table header -->
  <tr>
    <th>Description</th>
    <th>Completed</th>
    <th></th>
  </tr>

  #for(todo in todos):
  <tr>
    <!-- Make the title column take up 90% of the width -->
    <td style="width: 90%;">#(todo.title)</td>
    <td>
      <input type="checkbox"
           id="todo_#(todo.id)"
           hx-put="/todos/#(todo.id)"
           hx-trigger="click"
           hx-target="#todos"
           #if(todo.complete): checked #endif>
      </input>
    </td>
    <td>
      <button hx-delete="/todos/#(todo.id)"
              hx-trigger="click"
              hx-target="#todos"
              class="btn-delete-todo">
        X
      </button>
    </td>
  </tr>
  #endfor
</table>
```

Here, we just create a table that is 3 columns wide from a list of todos that we will pass in to the
template. We use `Htmx` to handle updating a todo if a user clicks a checkbox to mark the todo as
`complete`, we also add a button in the last column of the table that we use `Htmx` to handle
deleting a todo from the database.

## Controllers

The controllers handle the routes that our website exposes. The project template creates a
controller for us that handles `JSON` / `API` requests, but we do need to make a couple of changes
to the file (`Sources/App/Controllers/TodoController.swift`).

```swift
import Fluent
import Vapor

struct TodoController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    let todos = routes.grouped("api", "todos")

    todos.get(use: index)
    todos.post(use: create)
    todos.group(":todoID") { todo in
      todo.delete(use: self.delete)
      todo.put(use: self.update)
    }
  }

  @Sendable
  func index(req: Request) async throws -> [TodoDTO] {
    try await Todo.query(on: req.db).all().map { $0.toDTO() }
  }

  @Sendable
  func create(req: Request) async throws -> TodoDTO {
    let todo = try req.content.decode(TodoDTO.self).toModel()

    try await todo.save(on: req.db)
    return todo.toDTO()
  }

  @Sendable
  func delete(req: Request) async throws -> HTTPStatus {
    guard let todo = try await Todo.find(req.parameters.get("todoID"), on: req.db) else {
      throw Abort(.notFound)
    }

    try await todo.delete(on: req.db)
    return .noContent
  }

  @Sendable
  func update(req: Request) async throws -> TodoDTO {
    // let todo = try req.content.decode(TodoDTO.self).toModel()
    guard let todo = try await Todo.find(req.parameters.get("todoID"), on: req.db) else {
      throw Abort(.notFound)
    }
    todo.complete.toggle()
    try await todo.save(on: req.db)
    return todo.toDTO()
  }

}
```

The primary changes here are to add the `update(req: Request)` function at the bottom, which handles
updating a todo that has already been created. This will be used when a user clicks on the checkbox
to mark a todo as complete or incomplete.

We also change the route in the `boot(routes: RoutesBuilder)` method to make all these routes
accessible at `/api/todos` instead of the original `/todos` as we will use the `/todos` routes for
returning our views from our view controller.

### Todo View Controller

Next we need to create our view controller, it is what will be used to handle routes that should
return `html` content for our website. This controller will actually use the api controller to do
the majority of it's work.

The easiest thing is to make a copy of the current api controller:

```bash
cp Sources/App/Controllers/TodoController.swift Sources/App/Controllers/TodoViewController.swift
```

Then update the file to the following:

```swift
import Fluent
import Vapor

struct TodoViewController: RouteCollection {

  private let api = TodoController()

  func boot(routes: RoutesBuilder) throws {
    let todos = routes.grouped("todos")

    todos.get(use: index)
    todos.post(use: create)
    todos.group(":todoID") { todo in
      todo.delete(use: self.delete)
      todo.put(use: self.update)
    }
  }

  @Sendable
  func index(req: Request) async throws -> View {
    let todos = try await api.index(req: req)
    return try await req.view.render("todos", ["todos": todos])
  }

  @Sendable
  func create(req: Request) async throws -> View {
    _ = try await api.create(req: req)
    return try await index(req: req)
  }

  @Sendable
  func delete(req: Request) async throws -> View {
    _ = try await api.delete(req: req)
    return try await index(req: req)
  }

  @Sendable
  func update(req: Request) async throws -> View {
    _ = try await api.update(req: req)
    return try await index(req: req)
  }
}
```

Here we use the api controller to do the heavy lifting of communicating with the database, then we
just always return / render the `todos.leaf` template that we created earlier, which will update our
web page with the list of todos retreived from the database.

> Note: There are better ways to handle this, however this is just a simple example.

### Update our routes

Next, we need to tell vapor to use our new view controller (`Sources/App/routes.swift`)

```swift
import Fluent
import Vapor

func routes(_ app: Application) throws {
  app.get { req async throws in
    try await req.view.render("index", ["title": "Todos"])
  }

  app.get("hello") { _ async -> String in
    "Hello, world!"
  }

  try app.register(collection: TodoController())
  try app.register(collection: TodoViewController())
}
```

Here, we just add the `TodoViewController` at the bottom so vapor will be able to handle those
routes and also update the title to be `Todos` (in the first `app.get` near the top).

## Build and Run

At this point we should be able to build and run the application.

First, let's make sure the project builds.

```bash
swift build
```

This may take a minute if it's the first time building the project as it has to fetch the
dependencies. If you experience problems here then make sure you don't have typos in your files.

Next, we need to run the database migrations.

```bash
swift run App migrate
```

Finally, we can run the application.

```bash
swift run App
```

You should be able to open your browser and type in the url: `http://localhost:8080` to view the
application. You can experiment with adding a new todo using the form.

> Note: To stop the application use `Ctrl-c`

## Bonus Styles

Hopefully you weren't blinded the first time you opened the application. You can add custom styles
by creating a `css` file (`Public/css/main.css`).

```bash
mkdir Public/css
touch Public/css/main.css
```

Update the file to the following:

```css
body {
  background-color: #1e1e2e;
  color: #ff66ff;
}

table {
  width: 100%;
}

th,
td {
  border-bottom: 1px solid grey;
  border-collapse: collapse;
}

td {
  color: white;
}

.todos {
  transition: all ease-in 1s;
}

.btn-delete-todo {
  color: red;
  margin-left: 20px;
}
```

Currently vapor does not know to serve files from the `Public` directory, so we need to update the
`Sources/App/configure.swift` file, by uncommenting the line near the top.

```swift
import Fluent
import FluentSQLiteDriver
import Leaf
import NIOSSL
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
  // uncomment to serve files from /Public folder
  app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

  app.databases.use(DatabaseConfigurationFactory.sqlite(.file("db.sqlite")), as: .sqlite)

  app.migrations.add(CreateTodo())

  app.views.use(.leaf)

  // register routes
  try routes(app)
}
```

Now you can stop and restart to see the styled website.

```bash
swift run App
```

## Conclusion

I hope you enjoyed this quick example of using `Htmx` with `Vapor`. You can view the source files at
[here](https://github.com/m-housh/todo-htmx).
