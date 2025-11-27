import Foundation
import Saga

extension Date {
  func formatted(_ format: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return formatter.string(from: self)
  }
}

extension Item where M == ArticleMetadata {

  /// The article summary, which is used when displaying a list of articles.
  var summary: String {
    // Use the summary if supplied in the articles front-matter.
    if let summary = metadata.summary {
      return summary
    }
    // Generate the summary from the first 255 words of the article.
    return String(body.withoutHtmlTags.truncate())
  }

  /// The articles banner image path.
  var imagePath: String {
    let image = metadata.image ?? "\(filenameWithoutExtension).png"
    // If the image is a link, then just return the link.
    if image.hasPrefix("http") {
      return image
    }
    return "\(SiteMetadata.url)/articles/images/\(image)"
  }

  /// An easy way to only get public articles, since ArticleMetadata.public is optional
  var `public`: Bool {
    #if DEBUG
      return true
    #else
      return metadata.public ?? true
    #endif
  }

  func getPrimaryTag() -> String? {
    guard let primaryTag = metadata.primaryTag else {
      guard metadata.tags.count == 1 else { return nil }
      return metadata.tags[0]
    }
    return primaryTag
  }
}

extension Array where Element == Item<ArticleMetadata> {
  /// Iterate through the articles and get unique tags.
  // func uniqueTags() -> Set<String> {
  //   reduce(into: Set()) { set, item in
  //     for tag in item.metadata.tags {
  //       set.insert(tag)
  //     }
  //   }
  // }

  /// Iterate through the articles and get the unique tags along with count of how
  /// many times the tag is used.
  func uniqueTagsWithCount() -> [(String, Int)] {
    let tags = flatMap { $0.metadata.tags }
    let tagsWithCount = tags.reduce(into: [:]) { $0[$1, default: 0] += 1 }
    return tagsWithCount.sorted { $0.1 > $1.1 }
  }
}
