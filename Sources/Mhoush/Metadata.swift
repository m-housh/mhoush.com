import Foundation
import Saga

/// Represents constants about the site.
enum SiteMetadata {
  #if DEBUG
    static let url = URL(string: "http://localhost:8080")!
  #else
    static let url = URL(string: "https://mhoush.com")!
  #endif
  static let name = "mhoush"
  static let author = "Michael Housh"
  /// Summary used for metadata / twitter card for home page,
  /// also displayed at bottom of articles.
  static let summary = """
    HVAC business owner with over 27 years of experience. Writes articles about HVAC,
    Programming, Home-Performance, and Building Science
    """
  /// The default twitter image when linking to home page.
  static let twitterImage = "/static/images/home-twitter-image.png"
}

/// Represents the valid file metadata for an article.
struct ArticleMetadata: @unchecked Sendable, Metadata {
  /// The articles associated tags.
  let tags: [String]

  /// A custom summary for the article, if not supplied then it is generated
  /// using the `String.truncate` method in the String+Extensions.swift file.
  var summary: String?

  /// Whether the articles is public, defaults to `true` if not supplied.
  /// This is useful if working on an article.
  let `public`: Bool?

  /// Specify a custom banner image path, if not supplied it uses the articles
  /// filename with a `png` extension and searches in the content/articles/images
  /// directory.  So it's often not required to be supplied.
  let image: String?

  /// Specify the primary tag for suggesting related articles, if not supplied,
  /// then most recent articles are suggested.
  let primaryTag: String?

  enum CodingKeys: String, CodingKey {
    case tags
    case summary
    case `public`
    case image
    case primaryTag
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    if let tags = try? container.decode([String].self, forKey: .tags) {
      self.tags = tags
    } else if let tags = try? container.decode(String.self, forKey: .tags) {
      self.tags = tags
        .split(separator: ",")
        .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        .filter { !$0.isEmpty }
    } else {
      self.tags = []
    }

    summary = try container.decodeIfPresent(String.self, forKey: .summary)
    `public` = try container.decodeIfPresent(Bool.self, forKey: .public)
    image = try container.decodeIfPresent(String.self, forKey: .image)
    primaryTag = try container.decodeIfPresent(String.self, forKey: .primaryTag)
  }
}

/// Represents valid metadata for the files that are not an `article`.
struct PageMetadata: Metadata {

  /// The section of the website for the file.
  let section: String?
}
