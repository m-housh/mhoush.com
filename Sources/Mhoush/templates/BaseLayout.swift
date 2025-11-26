import Foundation
import HTML

/// The base page layout used to render the different sections of the website.
///
/// - Parameters:
///   - conocicalURL: The url for the page.
///   - section: The section of the page.
///   - title: The page title.
///   - rssLink: A prefix for generating an rss feed for the page (generally only used for articles).
///   - extraHeader: Any extra items to be placed in the `head` of the html.
func baseLayout(
  canocicalURL: String,
  section: Section,
  title pageTitle: String,
  rssLink: String = "",
  extraHeader: NodeConvertible = Node.fragment([]),
  @NodeBuilder children: () -> NodeConvertible
) -> Node {
  return [
    .documentType("html"),
    html(lang: "en-US") {
      generateHeader(pageTitle, extraHeader)
      body(class: "bg-page text-white pb-5 font-avenir \(section.rawValue)") {
        siteHeader(section)

        div(class: "pt-12 lg:pt-28") {
          children()
        }

        footer(rssLink)
      }
    },
  ]
}

private func siteHeader(_ section: Section) -> Node {
  header(class: "header") {
    div(class: "header__inner") {
      div(class: "header__logo") {
        a(href: "/") {
          div(class: "logo") {
            "mhoush.com"
          }
        }
      }
    }
    nav(class: "menu") {
      ul(class: "flex flex-wrap gap-x-2 lg:gap-x-5") {
        li {
          a(class: section == .articles ? "active" : "", href: "/articles/") { "Articles" }
        }
        li {
          a(class: section == .about ? "active" : "", href: "/about.html") { "About" }
        }
      }
    }
  }
}

private func footer(_ rssLink: String) -> Node {
  div(class: "site-footer text-gray gray-links border-t border-light text-center pt-6 mt-8 text-sm")
  {
    p {
      "Copyright © Michael Housh 2023-\(Date().description.prefix(4))."
    }
    p {
      "Built in Swift using"
      a(href: "https://github.com/loopwerk/Saga", rel: "nofollow", target: "_blank") { "Saga" }
      "("
      %a(href: "https://github.com/m-housh/mhoush.com", rel: "nofollow", target: "_blank") {
        "source"
      }
      %")."
    }
    p {
      a(
        href: "\(SiteMetadata.url.absoluteString)/articles/\(rssLink)feed.xml",
        rel: "nofollow",
        target: "_blank"
      ) { "RSS" }
      " | "
      a(href: "https://github.com/m-housh", rel: "nofollow", target: "_blank") { "Github" }
      " | "
      a(
        href: "https://www.youtube.com/channel/UCb58SeURd5bObfTiL0KoliA",
        rel: "nofollow",
        target: "_blank"
      ) { "Youtube" }
      " | "
      a(href: "https://mastodon.social/@mhoush", rel: "me") { "Mastodon" }
      " | "
      a(href: "https://www.facebook.com/michael.housh", rel: "nofollow", target: "_blank") {
        "Facebook"
      }
      " | "
      a(href: "mailto:michael@mhoush.com", rel: "nofollow") { "Email" }
    }
    p {
      span {
        "All articles are licensed under Creative-Commons (CC BY-NC) 4.0"
      }
      a(href: "https://creativecommons.org/licenses/by-nc/4.0/") {
        img(class: "justify-center", src: "/static/images/by-nc.png", width: "100")
      }
    }
    script(src: "https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/components/prism-core.min.js")
    script(
      src:
        "https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/plugins/keep-markup/prism-keep-markup.min.js"
    )
    script(
      src:
        "https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/plugins/autoloader/prism-autoloader.min.js"
    )
  }
}

private func generateHeader(_ pageTitle: String, _ extraHeader: NodeConvertible) -> Node {
  head {
    meta(charset: "utf-8")
    meta(
      content: "#0e1112", name: "theme-color",
      customAttributes: ["media": "(prefers-color-scheme: dark)"])
    meta(
      content: "#566B78", name: "theme-color",
      customAttributes: ["media": "(prefers-color-scheme: light)"])
    meta(content: "Michael Housh", name: "author")
    meta(content: "Mhoush", name: "apple-mobile-web-app-title")
    meta(content: "initial-scale=1.0, width=device-width", name: "viewport")
    meta(content: "telephone=no", name: "format-detection")
    meta(content: "True", name: "HandheldFriendly")
    meta(content: "320", name: "MobileOptimized")
    meta(content: "Mhoush", name: "og:site_name")
    meta(content: "hvac, developer, swift, home-performance, design", name: "keywords")
    meta(content: "@mhoush@mastodon.social", name: "fediverse:creator")
    title { SiteMetadata.name + ": \(pageTitle)" }
    link(href: "/static/favicon.ico", rel: "shortcut icon")
    link(href: "/static/output.css", rel: "stylesheet")
    link(href: "/static/style.css", rel: "stylesheet")
    link(
      href: "/articles/feed.xml", rel: "alternate", title: SiteMetadata.name,
      type: "application/rss+xml")
    extraHeader
    script(src: "https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js")
  }
}
