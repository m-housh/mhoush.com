import HTML
import Saga

func renderPage(context: ItemRenderingContext<PageMetadata>) -> Node {
  let section = Section(rawValue: context.item.metadata.section ?? "")
  assert(section != nil)

  return baseLayout(
    canocicalURL: context.item.url,
    section: section!,
    title: context.item.title,
    extraHeader: section == .home ? generateHeader(.home) : Node.fragment([])
  ) {
    switch section {
    case .home:
      renderHome(body: context.item.body)
    case .notFound:
      let articles = context.allItems
        .compactMap { $0 as? Item<ArticleMetadata> }
        .prefix(10)
      render404(body: context.item.body, articles: Array(articles))
    default:
      renderNonHome(body: context.item.body)
    }
  }
}

func renderHome(body: String) -> Node {
  div {
    img(alt: "Avatar", class: "my-24 w-[315px] h-200px mx-auto", src: "/static/images/avatar.png")

    div(
      class:
        "my-24 uppercase font-avenir text-[40px] leading-[1.25] font-thin text-center [&>h1>strong]:font-bold"
    ) {
      Node.raw(body)
    }
  }
}

func renderNonHome(body: String) -> Node {
  div(class: "w-full mx-20 max-w-[90vw]") {
    article {
      div(class: "prose") {
        Node.raw(body)
      }
    }
  }
}

func render404(body: String, articles: [Item<ArticleMetadata>]) -> Node {
  article(class: "prose") {
    Node.raw(body)

    ul {
      articles.map { article in
        li {
          a(href: article.url) { article.title }
        }
      }
    }

    div {
      a(href: "/articles/") { "› See all articles" }
    }
  }
}
