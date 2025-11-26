import Foundation
import HTML
import Saga

// func uniqueTagsWithCount(_ articles: [Item<ArticleMetadata>]) -> [(String, Int)] {
//   let tags = articles.flatMap { $0.metadata.tags }
//   let tagsWithCounts = tags.reduce(into: [:]) { $0[$1, default: 0] += 1 }
//   return tagsWithCounts.sorted { $0.1 > $1.1 }
// }

func renderArticles(context: ItemsRenderingContext<ArticleMetadata>) -> NodeConvertible {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "yyyy"

  let articlesPerYear = Dictionary(
    grouping: context.items, by: { dateFormatter.string(from: $0.date) })
  let sortedByYearDescending = articlesPerYear.sorted { $0.key > $1.key }

  return baseRenderArticles(
    sortedByYearDescending,
    canocicalURL: "/articles/",
    title: "Articles",
    rssLink: "",
    extraHeader: "",
    label: yearHeader(_:)
  )
}

func renderTag<T>(context: PartitionedRenderingContext<T, ArticleMetadata>) -> NodeConvertible {
  let extraHeader = link(
    href: "/articles/tag/\(context.key.slugified)/feed.xml",
    rel: "alternate",
    title: "\(SiteMetadata.name): articles with tag \(context.key)",
    type: "application/rss+xml"
  )

  return baseRenderArticles(
    (context.key.slugified, context.items),
    canocicalURL: "/articles/tag/\(context.key.slugified)/",
    title: "Articles in \(context.key)",
    rssLink: "tag/\(context.key.slugified)/",
    extraHeader: extraHeader
  ) { tag in
    div(class: "border-b border-light grid lg:grid-cols-2 mb-12") {
      a(href: "/articles") {
        div(class: "flex flex-row gap-2") {
          img(src: "/static/images/tag.svg", width: "40")
          h1(class: "text-4xl font-extrabold") { tag }
          h1(class: "[&:hover]:border-b border-green text-2xl font-extrabold text-orange px-4") {
            "«"
          }
        }
      }
    }
  }
}

func renderYear<T>(context: PartitionedRenderingContext<T, ArticleMetadata>) -> NodeConvertible {
  baseRenderArticles(
    (context.key.slugified, context.items),
    canocicalURL: "/articles/\(context.key)/",
    title: "Articles in \(context.key)"
  ) { year in
    div(class: "pt-6 w-full") {
      a(href: "/articles/") {
        div(class: "px-6 flex flex-row gap-4") {
          img(src: "/static/images/calendar.svg", width: "40")
          h1(class: "text-4xl font-extrabold pt-3") { year }
          h1(class: "[&:hover]:border-b border-green text-2xl font-extrabold text-orange px-4") {
            "«"
          }
        }
      }
    }
  }
}

private func yearHeader(_ year: String) -> Node {
  div(class: "pt-6 w-full") {
    div(class: "px-6 flex flex-row gap-4") {
      img(src: "/static/images/calendar.svg", width: "40")
      h1(class: "text-4xl font-extrabold pt-3") { year }
    }
  }
}

private func baseRenderArticles(
  _ articles: [(key: String, value: [Item<ArticleMetadata>])],
  canocicalURL: String,
  title pageTitle: String,
  rssLink: String = "",
  extraHeader: NodeConvertible = Node.fragment([]),
  @NodeBuilder label: @escaping (String) -> Node = { _ in Node.fragment([]) }
) -> NodeConvertible {
  ArticleGrid(
    articles: articles,
    canocicalURL: canocicalURL,
    title: pageTitle,
    rssLink: rssLink,
    extraHeader: extraHeader
  ) { key in
    label(key)
  }
}

private func baseRenderArticles(
  _ articles: (key: String, value: [Item<ArticleMetadata>]),
  canocicalURL: String,
  title pageTitle: String,
  rssLink: String = "",
  extraHeader: NodeConvertible = Node.fragment([]),
  @NodeBuilder label: @escaping (String) -> Node = { _ in Node.fragment([]) }
) -> NodeConvertible {
  baseRenderArticles(
    [articles],
    canocicalURL: canocicalURL,
    title: pageTitle,
    rssLink: rssLink,
    extraHeader: extraHeader,
    label: label
  )
}
