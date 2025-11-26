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
        Node.raw(
          """
          <i class="fa fa-home"></i>
          """),
        %a(
          class: "text-orange [&:hover]:border-b border-green",
          href: "/articles/tag/\(tag.slugified)/"
        ) {
          tag
        },
      ])
    }
  }
}

func ogURL(_ article: Item<ArticleMetadata>) -> String {
  SiteMetadata.url
    .appendingPathComponent("\(article.url)")
    .absoluteString
}

private func parseOtherArticles(_ context: ItemRenderingContext<ArticleMetadata>) -> OtherArticles {
  let allArticles = context.allItems.compactMap { $0 as? Item<ArticleMetadata> }
  let otherArticles =
    allArticles
    .filter { $0.url != context.item.url }

  guard let primaryTag = context.item.getPrimaryTag() else {
    return .all(otherArticles)
  }

  return .related(
    tag: primaryTag,
    items: otherArticles.sorted { lhs, rhs in
      switch (lhs.metadata.tags.contains(primaryTag), rhs.metadata.tags.contains(primaryTag)) {
      case (true, false): return true
      default: return false
      }
    }
  )
}

private enum OtherArticles {
  case all([Item<ArticleMetadata>])
  case related(tag: String, items: [Item<ArticleMetadata>])

  var items: [Item<ArticleMetadata>] {
    switch self {
    case .all(let items): return items
    case .related(_, let items): return items
    }
  }

  var title: String {
    switch self {
    case .all: return "Recent Articles"
    case .related: return "Related Articles"
    }
  }

  var tag: String? {
    guard case .related(let tag, _) = self else { return nil }
    return tag
  }
}

var tagSVG: Node {
  Node.raw(
    """
    <svg viewBox="0 0 33 33" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:sketch="http://www.bohemiancoding.com/sketch/ns" fill="#5a5a5a" stroke="#5a5a5a"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <title>tag-2</title> <desc>Created with Sketch Beta.</desc> <defs> </defs> <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd" sketch:type="MSPage"> <g id="Icon-Set" sketch:type="MSLayerGroup" transform="translate(-360.000000, -774.000000)" fill="#5b5b5b"> <path d="M390.097,789.321 C390.097,789.849 389.611,790.623 389.095,791.139 L378.823,801.378 L365.634,788.197 L375.89,777.974 C376.36,777.504 377.111,776.903 377.641,776.903 L389.139,776.903 C389.668,776.903 390.097,777.331 390.097,777.858 L390.097,789.321 L390.097,789.321 Z M375.89,804.304 C375.079,805.111 373.765,805.111 372.955,804.304 L362.684,794.063 C361.873,793.256 361.873,791.946 362.684,791.139 L364.166,789.66 L377.341,802.856 L375.89,804.304 L375.89,804.304 Z M390.097,774.993 L376.683,774.993 C375.624,774.993 375.431,775.455 374.422,776.511 L361.217,789.676 C359.596,791.291 359.596,793.911 361.217,795.526 L371.487,805.767 C373.108,807.382 375.735,807.382 377.356,805.767 L390.563,792.602 C391.412,791.754 392.014,791.332 392.014,790.276 L392.014,776.903 C392.014,775.849 391.155,774.993 390.097,774.993 L390.097,774.993 Z M383.959,786.019 C383.148,786.826 381.835,786.826 381.024,786.019 C380.214,785.211 380.214,783.901 381.024,783.093 C381.835,782.285 383.148,782.285 383.959,783.093 C384.77,783.901 384.77,785.211 383.959,786.019 L383.959,786.019 Z M379.558,781.63 C377.937,783.246 377.937,785.865 379.558,787.481 C381.178,789.097 383.806,789.097 385.427,787.481 C387.047,785.865 387.047,783.246 385.427,781.63 C383.806,780.015 381.178,780.015 379.558,781.63 L379.558,781.63 Z" id="tag-2" sketch:type="MSShapeGroup"> </path> </g> </g> </g></svg>
    """)
}

func renderArticle(context: ItemRenderingContext<ArticleMetadata>) -> Node {
  let otherArticles = parseOtherArticles(context)

  return baseLayout(
    canocicalURL: context.item.url,
    section: .articles,
    title: context.item.title,
    extraHeader: generateHeader(.article(context.item))
  ) {
    div(class: "w-full mx-20 max-w-[90vw]") {
      article(class: "prose") {
        h1 { context.item.title }
        div(class: "-mt-6") {
          renderArticleInfo(context.item)
        }
        img(alt: "banner", src: context.item.imagePath)
        Node.raw(context.item.body)
      }

      div(class: "border-t border-light pt-8 mt-16") {
        div(class: "grid lg:grid-cols-2") {
          h2(class: "text-4xl font-extrabold mb-8") { otherArticles.title }
          if let tag = otherArticles.tag {
            a(href: "/articles/tag/\(tag)") {
              div(class: " [&:hover]:border-b border-orange px-5 flex flex-row gap-5") {
                img(src: "/static/images/tag.svg", width: "40")
                span(class: "text-4xl font-extrabold text-orange") { tag }
              }
            }
          }
        }

        div(class: "grid lg:grid-cols-2 gap-10") {
          otherArticles.items.prefix(2).map { renderArticleForGrid(article: $0) }
        }

        div(class: "prose mt-10") {
          a(href: "/articles/") {
            div(class: "flex flex-row gap-2") {
              span(class: "mt-8") { "All Articles" }
              img(src: "/static/images/document.svg", width: "40")
            }
          }
        }
      }

      // Giscus comment section.
      commentSection

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

private var commentSection: Node {
  div(class: "border-t border-light pt-8") {
    Node.raw(
      """
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
