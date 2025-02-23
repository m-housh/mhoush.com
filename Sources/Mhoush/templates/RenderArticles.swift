import Foundation
import HTML
import Saga

func uniqueTagsWithCount(_ articles: [Item<ArticleMetadata>]) -> [(String, Int)] {
  let tags = articles.flatMap { $0.metadata.tags }
  let tagsWithCounts = tags.reduce(into: [:]) { $0[$1, default: 0] += 1 }
  return tagsWithCounts.sorted { $0.1 > $1.1 }
}

func renderArticles(context: ItemsRenderingContext<ArticleMetadata>) -> Node {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "yyyy"

  let articlesPerYear = Dictionary(grouping: context.items, by: { dateFormatter.string(from: $0.date) })
  let sortedByYearDescending = articlesPerYear.sorted { $0.key > $1.key }

  return baseLayout(canocicalURL: "/articles/", section: .articles, title: "Articles", rssLink: "", extraHeader: "") {
    // TODO: Add list of tags here that can be navigated to.
    sortedByYearDescending.map { year, articles in
      div {
        h1(class: "text-4xl font-extrabold mb-12") { year }

        div(class: "grid gap-10 mb-16") {
          articles.map { renderArticleForGrid(article: $0) }
        }
      }
    }
  }
}

func renderTag<T>(context: PartitionedRenderingContext<T, ArticleMetadata>) -> Node {
  let extraHeader = link(
    href: "/articles/tag/\(context.key.slugified)/feed.xml",
    rel: "alternate",
    title: "\(SiteMetadata.name): articles with tag \(context.key)",
    type: "application/rss+xml"
  )

  return baseRenderArticles(
    context.items,
    canocicalURL: "/articles/tag/\(context.key.slugified)/",
    title: "Articles in \(context.key)",
    rssLink: "tag/\(context.key.slugified)/",
    extraHeader: extraHeader
  ) {
    div(class: "grid lg:grid-cols-2 mb-12") {
      a(href: "/articles") {
        div(class: "flex flex-row gap-2") {
          h1(class: "[&:hover]:border-b border-green text-2xl font-extrabold text-orange px-4") { "«" }
          img(src: "/static/images/tag.svg", width: "40")
          h1(class: "text-4xl font-extrabold") { "\(context.key)" }
        }
      }
    }
  }
}

func renderYear<T>(context: PartitionedRenderingContext<T, ArticleMetadata>) -> Node {
  baseRenderArticles(context.items, canocicalURL: "/articles/\(context.key)/", title: "Articles in \(context.key)")
}

private func baseRenderArticles(
  _ articles: [Item<ArticleMetadata>],
  canocicalURL: String,
  title pageTitle: String,
  rssLink: String = "",
  extraHeader: NodeConvertible = Node.fragment([]),
  @NodeBuilder label: () -> Node = { Node.fragment([]) }
) -> Node {
  return baseLayout(
    canocicalURL: canocicalURL,
    section: .articles,
    title: pageTitle,
    rssLink: rssLink,
    extraHeader: extraHeader
  ) {
    label()
    articles.map { article in
      section(class: "mb-10") {
        h1(class: "post-title text-2xl font-bold mb-2") {
          a(class: "[&:hover]:border-b border-orange", href: article.url) { article.title }
        }
        renderArticleInfo(article)
        p(class: "mt-4") {
          a(href: article.url) { article.summary }
        }
      }
    }
  }
}
