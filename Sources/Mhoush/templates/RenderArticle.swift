import Foundation
import HTML
import Saga

func tagPrefix(index: Int, totalTags: Int) -> Node {
  if index > 0 {
    if index == totalTags - 1 {
      return " and "
    } else {
      return ", "
    }
  }
  return ""
}

func renderArticleInfo(_ article: Item<ArticleMetadata>) -> Node {
  div(class: "text-gray gray-links text-sm") {
    span(class: "border-r border-gray pr-2 mr-2") {
      article.date.formatted("MMMM dd, yyyy")
    }

    %.text("\(article.body.withoutHtmlTags.numberOfWords) words, posted in ")

    article.metadata.tags.sorted().enumerated().map { index, tag in
      Node.fragment([
        %tagPrefix(index: index, totalTags: article.metadata.tags.count),
        %a(class: "text-orange [&:hover]:border-b border-green", href: "/articles/tag/\(tag.slugified)/") { tag }
      ])
    }
  }
}

func ogURL(_ article: Item<ArticleMetadata>) -> String {
  SiteMetadata.url
    .appendingPathComponent("/articles/images/\(article.url)")
    .absoluteString
}

private func parseOtherArticles(_ context: ItemRenderingContext<ArticleMetadata>) -> OtherArticles {
  let allArticles = context.allItems.compactMap { $0 as? Item<ArticleMetadata> }
  let otherArticles = allArticles
    .filter { $0.url != context.item.url }

  guard let primaryTag = context.item.getPrimaryTag() else {
    return .all(otherArticles)
  }

  return .related(
    otherArticles.sorted { lhs, rhs in
      switch (lhs.metadata.tags.contains(primaryTag), rhs.metadata.tags.contains(primaryTag)) {
      case (true, false): return true
      default: return false
      }
    }
  )
}

private enum OtherArticles {
  case all([Item<ArticleMetadata>])
  case related([Item<ArticleMetadata>])

  var items: [Item<ArticleMetadata>] {
    switch self {
    case let .all(items): return items
    case let .related(items): return items
    }
  }

  var title: String {
    switch self {
    case .all: return "Recent Articles"
    case .related: return "Related Articles"
    }
  }
}

func renderArticle(context: ItemRenderingContext<ArticleMetadata>) -> Node {
  let otherArticles = parseOtherArticles(context)

  return baseLayout(
    canocicalURL: context.item.url,
    section: .articles,
    title: context.item.title,
    extraHeader: generateHeader(.article(context.item))
  ) {
    article(class: "prose") {
      h1 { context.item.title }
      div(class: "-mt-6") {
        renderArticleInfo(context.item)
      }
      img(alt: "banner", src: context.item.imagePath)
      Node.raw(context.item.body)
    }

    comments

    div(class: "mt-16") {
      h2(class: "text-4xl font-extrabold mb-8") { otherArticles.title }

      div(class: "grid lg:grid-cols-2 gap-10") {
        otherArticles.items.prefix(2).map { renderArticleForGrid(article: $0) }
      }

      p(class: "prose mt-8") {
        a(href: "/articles/") { "> All Articles" }
      }
    }

    div(class: "border-t border-light mt-8 pt-8") {
      h2(class: "text-4xl font-extrabold mb-8") { "Author" }
      div(class: "flex flex-col lg:flex-row gap-8") {
        div(class: "flex-[0_0_120px]") {
          img(class: "w-[120px] h-[120px] rounded-full", src: "/static/images/avatar.png")
        }

        div(class: "prose") {
          h3(class: "!m-0") { SiteMetadata.author }
          p(class: "text-gray") { SiteMetadata.summary }
        }
      }
    }
  }
}

func renderArticleForGrid(article: Item<ArticleMetadata>) -> Node {
  section {
    h2(class: "post-title text-2xl font-bold mb-2") {
      a(class: "[&:hover]:border-b border-orange", href: article.url) { article.title }
    }
    renderArticleInfo(article)
    p {
      a(href: article.url) {
        div {
          // img(alt: "banner", src: article.imagePath)
          article.summary
        }
      }
    }
  }
}

private var comments: Node {
  div(class: "border-t border-light mt-8 pt-8") {
    Node.raw("""
          <script src="https://giscus.app/client.js"
            data-repo="m-housh/mhoush.com"
            data-repo-id="R_kgDOJagAXA"
            data-category="Article Discussions"
            data-category-id="DIC_kwDOJagAXM4CnLfv"
            data-mapping="pathname"
            data-strict="0"
            data-reactions-enabled="1"
            data-emit-metadata="0"
            data-input-position="bottom"
            data-theme="preferred_color_scheme"
            data-lang="en"
            data-loading="lazy"
            crossorigin="anonymous"
            async>
         </script>
    """)
  }
}

// private func comments(_ article: Item<ArticleMetadata>) -> Node {
//   Node.raw("""
//   <div id="cusdis_thread"
//   data-host="https://cusdis.com"
//   data-app-id="d253a590-34f9-4363-b2d9-36ed8b7a11fa"
//   data-page-id="\(article.url.slugified)"
//   data-page-url="\(article.url)"
//   data-page-title="\(article.title)"
//   data-theme=dark
//   ></div>
//   <script async defer src="https://cusdis.com/js/cusdis.es.js"></script>
//   <script>
//   window.addEventListener('load', function () {
//       let iframe = document.querySelector("#cusdis_thread iframe");
//       if (iframe) {
//           let observer = new MutationObserver(() => {
//               let scrollHeight = iframe.contentWindow.document.body.scrollHeight;
//               iframe.style.height = scrollHeight + "px";
//           });
//           observer.observe(iframe.contentWindow.document.body, { childList: true, subtree: true });
//       }
//   });
//   </script>
//   """)
// }
