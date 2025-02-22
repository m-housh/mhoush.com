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
    return "/articles/images/\(image)"
  }

  /// An easy way to only get public articles, since ArticleMetadata.public is optional
  var `public`: Bool {
    return metadata.public ?? true
  }
}
