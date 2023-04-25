import Plot
import Publish

extension Theme where Site == Mhoush {
  static var mhoush: Self {
    Theme(
      htmlFactory: MhoushHTMLFactory(),
      resourcePaths: ["Resources/MyTheme/styles.css"]
    )
  }
}

private struct MhoushHTMLFactory: HTMLFactory {
  
  typealias Site = Mhoush
  
  func makeIndexHTML(
    for index: Index,
    context: PublishingContext<Site>
  ) throws -> HTML {
    HTML(
      .lang(context.site.language),
      .head(for: context.site),
      .body {
        Div {
          SiteHeader(context: context, selectedSelectionID: nil)
          SiteSidebar()
          Wrapper(index.content.body)
          //          H1(index.content.body)
          //          H1(index.title)
          //          Paragraph(context.site.description)
          //            .class("description")
          //          H2("Latest content")
          //          ItemList(
          //            items: context.allItems(
          //              sortedBy: \.date,
          //              order: .descending
          //            ),
          //            site: context.site
          //          )
          //        }
          SiteFooter()
        }
        .class("main-content")
      }
    )
  }
  
  func makeSectionHTML(
    for section: Section<Site>,
    context: PublishingContext<Site>
  ) throws -> HTML {
    HTML(
      .lang(context.site.language),
      .head(for: context.site),
      .body {
        SiteHeader(context: context, selectedSelectionID: section.id)
        SiteSidebar()
        Wrapper {
          Article {
            Div(section.body)
              .class("content")
          }
//          ItemList(items: section.items, site: context.site)
        }
        SiteFooter()
      }
    )
  }
  
  func makeItemHTML(for item: Item<Site>,
                    context: PublishingContext<Site>) throws -> HTML {
    HTML(
      .lang(context.site.language),
      .head(for: context.site),
      .body(
        .class("item-page"),
        .components {
          SiteHeader(context: context, selectedSelectionID: item.sectionID)
          Wrapper {
            Article {
              Div(item.content.body).class("content")
              Span("Tagged with: ")
              ItemTagList(item: item, site: context.site)
            }
          }
          SiteFooter()
        }
      )
    )
  }
  
  func makePageHTML(
    for page: Page,
    context: PublishingContext<Site>
  ) throws -> HTML {
    HTML(
      .lang(context.site.language),
      .head(for: context.site),
      .body {
        SiteHeader(context: context, selectedSelectionID: nil)
        Wrapper(page.body)
        SiteFooter()
      }
    )
  }
  
  func makeTagListHTML(
    for page: TagListPage,
    context: PublishingContext<Site>
  ) throws -> HTML? {
    HTML(
      .lang(context.site.language),
      .head(for: context.site),
      .body {
        SiteHeader(context: context, selectedSelectionID: nil)
        Wrapper {
          H1("Browse all tags")
          List(page.tags.sorted()) { tag in
            ListItem {
              Link(tag.string,
                   url: context.site.path(for: tag).absoluteString
              )
            }
            .class("tag")
          }
          .class("all-tags")
        }
        SiteFooter()
      }
    )
  }
  
  func makeTagDetailsHTML(for page: TagDetailsPage,
                          context: PublishingContext<Site>) throws -> HTML? {
    HTML(
      .lang(context.site.language),
      .head(for: page, on: context.site),
      .body {
        SiteHeader(context: context, selectedSelectionID: nil)
        Wrapper {
          H1 {
            Text("Tagged with ")
            Span(page.tag.string).class("tag")
          }
          
          Link("Browse all tags",
               url: context.site.tagListPath.absoluteString
          )
          .class("browse-all")
          
          ItemList(
            items: context.items(
              taggedWith: page.tag,
              sortedBy: \.date,
              order: .descending
            ),
            site: context.site
          )
        }
        SiteFooter()
      }
    )
  }
}
