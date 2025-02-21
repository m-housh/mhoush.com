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
        %a(href: "/articles/tag/\(tag.slugified)/") { tag }
      ])
    }
  }
}

func ogURL(_ article: Item<ArticleMetadata>) -> String {
  SiteMetadata.url
    .appendingPathComponent("/articles/images/\(article.url)")
    .absoluteString
}

@NodeBuilder
func getArticleHeader(_ article: Item<ArticleMetadata>) -> NodeConvertible {
  link(href: "/static/prism.css", rel: "stylesheet")
  meta(content: article.summary, name: "description")
  meta(content: "summary_large_image", name: "twitter:card")
  meta(content: article.imagePath, name: "twitter:image")
  meta(content: article.title, name: "twitter:image:alt")
  meta(content: ogURL(article), name: "og:url")
  meta(content: article.title, name: "og:title")
  meta(content: article.summary, name: "og:description")
  meta(content: article.imagePath, name: "og:image")
  meta(content: "1014", name: "og:image:width")
  meta(content: "530", name: "og:image:height")
  script(crossorigin: "anonymous", src: "https://kit.fontawesome.com/f209982030.js")
  Node.raw("""
  <script>
  MathJax = {
    tex: {
      inlineMath: [['$', '$']]
    },
    svg: {
      fontCache: 'global'
    }
  };
  </script>
  """)
  script(defer: true, src: "https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-svg.js")
}

func renderArticle(context: ItemRenderingContext<ArticleMetadata>) -> Node {
  let extraHeader = getArticleHeader(context.item)

  let allArticles = context.allItems.compactMap { $0 as? Item<ArticleMetadata> }
  let otherArticles = allArticles.filter { $0.url != context.item.url }.prefix(2)

  return baseLayout(
    canocicalURL: context.item.url,
    section: .articles,
    title: context.item.title,
    extraHeader: extraHeader
  ) {
    article(class: "prose") {
      h1 { context.item.title }
      div(class: "-mt-6") {
        renderArticleInfo(context.item)
      }
      img(alt: "banner", src: context.item.imagePath)
      Node.raw(context.item.body)
    }

    div(class: "border-t border-light mt-8 pt-8") {
      h2(class: "text-4xl font-extrabold mb-8") { "Written by" }
      div(class: "flex flex-col lg:flex-row gap-8") {
        div(class: "flex-[0_0_120px]") {
          img(class: "w-[120px] h-[120px] rounded-full", src: "/static/images/avatar.png")
        }

        div(class: "prose") {
          h3(class: "!m-0") { SiteMetadata.author }
          p(class: "text-gray") {
            """
            HVAC business owner with over 27 years of experience. Writes articles about HVAC,
            Programming, Home-Performance, and Building Science
            """
          }
        }
      }
    }

    div(class: "mt-16") {
      h2(class: "text-4xl font-extrabold mb-8") { "More articles" }

      div(class: "grid lg:grid-cols-2 gap-10") {
        otherArticles.map { renderArticleForGrid(article: $0) }
      }

      p(class: "prose mt-8") {
        a(href: "/articles/") { "› See all articles" }
      }
    }

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
}
