import Foundation
import HTML
import Saga

enum HeaderType {
  case article(Item<ArticleMetadata>)
  case home
}

func generateHeader(
  _ headerType: HeaderType
) -> NodeConvertible {
  switch headerType {
  case .home:
    return Node.fragment([
      link(href: "/static/prism.css", rel: "stylesheet"),
      meta(content: SiteMetadata.summary, name: "description"),
      meta(content: "summary_large_image", name: "twitter:card"),
      meta(content: SiteMetadata.twitterImage, name: "twitter:image"),
      meta(content: SiteMetadata.name, name: "twitter:image:alt"),
      meta(content: SiteMetadata.twitterImage, name: "og:url"),
      meta(content: SiteMetadata.author, name: "og:title"),
      meta(content: SiteMetadata.summary, name: "og:description"),
      meta(content: SiteMetadata.twitterImage, name: "og:image"),
      meta(content: "1014", name: "og:image:width"),
      meta(content: "530", name: "og:image:height")
    ])
  case let .article(article):
    return Node.fragment([
      link(href: "/static/prism.css", rel: "stylesheet"),
      link(href: "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css", rel: "stylesheet"),
      meta(content: article.summary, name: "description"),
      meta(content: "summary_large_image", name: "twitter:card"),
      meta(content: article.imagePath, name: "twitter:image"),
      meta(content: article.title, name: "twitter:image:alt"),
      meta(content: ogURL(article), name: "og:url"),
      meta(content: article.title, name: "og:title"),
      meta(content: article.summary, name: "og:description"),
      meta(content: article.imagePath, name: "og:image"),
      meta(content: "1014", name: "og:image:width"),
      meta(content: "530", name: "og:image:height"),
      script(crossorigin: "anonymous", src: "https://kit.fontawesome.com/f209982030.js"),
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
      """),
      script(defer: true, src: "https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-svg.js")
    ])
  }
}
