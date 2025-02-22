/// Represents different sections of the website.
///
/// This is used to render base layouts appropriately for the given section.
enum Section: String {
  /// The home page of the site.
  case home
  /// The articles / blog posts of the site.
  case articles
  /// The about page of the site.
  case about
  /// The 404 / not found page of the site.
  case notFound
}
