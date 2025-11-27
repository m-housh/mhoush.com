import Foundation
import HTML
import PathKit
@preconcurrency import Saga
import SagaParsleyMarkdownReader
import SagaSwimRenderer

func permalink(item: Item<ArticleMetadata>) {
  // Insert the publication year into the permalink.
  // If the `relativeDestination` was "articles/looking-for-django-cms/index.html", then it becomes "articles/2009/looking-for-django-cms/index.html"
  var components = item.relativeDestination.components
  components.insert("\(Calendar.current.component(.year, from: item.date))", at: 1)
  item.relativeDestination = Path(components: components)
}

func removingBreaks<M>(item: Item<M>) {
  // remove explicit <br /> from items that show up likely due to how prettier formats
  // markdown files inside of neovim.
  item.body = item.body.removeBreaks
}

@main
struct Run {
  static func main() async throws {
    try await Saga(input: "content", output: "deploy")
      // All markdown files within the "articles" subfolder will be parsed to html,
      // using ArticleMetadata as the Item's metadata type.
      // Furthermore we are only interested in public articles.
      .register(
        folder: "articles",
        metadata: ArticleMetadata.self,
        readers: [.parsleyMarkdownReader],
        itemProcessor: sequence(removingBreaks, publicationDateInFilename, permalink),
        filter: \.public,
        writers: [
          .itemWriter(swim(renderArticle)),
          .listWriter(swim(renderArticles)),
          .tagWriter(swim(renderTag), tags: \.metadata.tags),
          .yearWriter(swim(renderYear)),
          // Atom feed for all articles, and a feed per tag
          .listWriter(
            atomFeed(
              title: SiteMetadata.name,
              author: SiteMetadata.author,
              baseURL: SiteMetadata.url,
              summary: \.metadata.summary
            ),
            output: "feed.xml"
          ),
          .tagWriter(
            atomFeed(
              title: SiteMetadata.name,
              author: SiteMetadata.author,
              baseURL: SiteMetadata.url,
              summary: \.metadata.summary
            ),
            output: "tag/[key]/feed.xml",
            tags: \.metadata.tags
          ),
        ]
      )
      // All the remaining markdown files will be parsed to html,
      // using the default EmptyMetadata as the Item's metadata type.
      .register(
        metadata: PageMetadata.self,
        readers: [.parsleyMarkdownReader],
        itemProcessor: removingBreaks,
        itemWriteMode: .keepAsFile,  // need to keep 404.md as 404.html, not 404/index.html
        writers: [.itemWriter(swim(renderPage))]
      )
      // Run the steps we registered above
      .run()
      // All the remaining files that were not parsed to markdown, so for example images, raw html files and css,
      // are copied as-is to the output folder.
      .staticFiles()
  }
}
