import Foundation
import HTML
import Saga

// FIX: Need tags sidebar to collapse on mobile / small screens.

/// Represents the article list, with tags in the sidebar.
struct ArticleGrid: NodeConvertible {
  let articles: [(key: String, value: [Item<ArticleMetadata>])]
  let canocicalURL: String
  let title: String
  let rssLink: String
  let extraHeader: NodeConvertible
  let renderArticle: (Item<ArticleMetadata>) -> Node
  let header: (String) -> Node

  init(
    articles: [(key: String, value: [Item<ArticleMetadata>])],
    canocicalURL: String,
    title: String,
    rssLink: String,
    extraHeader: any NodeConvertible = Node.fragment([]),
    renderArticle: @escaping (Item<ArticleMetadata>) -> Node = {
      renderArticleForGrid(article: $0)
    },
    header: @escaping (String) -> Node
  ) {
    self.articles = articles
    self.canocicalURL = canocicalURL
    self.title = title
    self.rssLink = rssLink
    self.extraHeader = extraHeader
    self.renderArticle = renderArticle
    self.header = header
  }

  private var allItems: [Item<ArticleMetadata>] {
    articles.reduce(into: [Item<ArticleMetadata>]()) { $0 += $1.value }
  }

  private var sortedTags: [(String, Int)] {
    allItems.uniqueTagsWithCount()
  }

  private func sidebarLink(
    _ label: String,
    href: String
  ) -> Node {
    a(
      class: "text-slate-300 font-semibold [&:hover]:text-slate-200",
      href: href
    ) {
      div(
        class:
          "flex w-full p-2 [&:hover]:border-b border-orange-400\(href == canocicalURL ? " active" : "")"
      ) {
        span(class: "mx-8") { label }
      }
    }
  }

  func asNode() -> Node {
    baseLayout(
      canocicalURL: canocicalURL,
      section: .articles,
      title: title,
      rssLink: rssLink,
      extraHeader: extraHeader
    ) {
      div(class: "grid grid-cols-4") {
        // Sidebar
        div(class: "overflow-auto border-r border-slate-200") {
          section(class: "pt-2") {
            div(class: "flex ps-2 pt-2") {
              span(class: "mt-2 ps-2 font-extrabold text-slate-400") { "TAGS" }
            }
            sortedTags.map { tag, count in
              sidebarLink("\(tag) (\(count))", href: "/articles/tag/\(tag.lowercased())/")
            }
          }
        }

        // Articles
        div(class: "col-span-3") {
          articles.map { key, articles in
            section {
              header(key)
              div(class: "grid gap-10 mx-6 mb-16") {
                articles.map(renderArticle)
              }
            }
          }
        }
      }
    }
  }

}
