// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {

  public enum Documentsnavigationview {
    /// Onderstaande documenten
    /// zijn door jou verzameld.
    /// Klik om te bekijken
    public static let subtitle = L10n.tr("Localizable", "documentsnavigationview.subtitle")
    /// Gegevens bekijken
    public static let title = L10n.tr("Localizable", "documentsnavigationview.title")
    public enum Tiles {
      public enum Images {
        /// Overzicht
        public static let subtitle = L10n.tr("Localizable", "documentsnavigationview.tiles.images.subtitle")
        /// Belastingdienst
        public static let title = L10n.tr("Localizable", "documentsnavigationview.tiles.images.title")
      }
      public enum Pensioen {
        /// Pensioenoverzicht
        public static let subtitle = L10n.tr("Localizable", "documentsnavigationview.tiles.pensioen.subtitle")
        /// Mijn Pensioen
        public static let title = L10n.tr("Localizable", "documentsnavigationview.tiles.pensioen.title")
      }
      public enum Uwv {
        /// Inkomensverklaring
        public static let subtitle = L10n.tr("Localizable", "documentsnavigationview.tiles.uwv.subtitle")
        /// Mijn UWV
        public static let title = L10n.tr("Localizable", "documentsnavigationview.tiles.uwv.title")
      }
    }
  }

  public enum Pinview {
    /// Join
    public static let button = L10n.tr("Localizable", "pinview.button")
    /// Type pin-code
    public static let caption = L10n.tr("Localizable", "pinview.caption")
    /// Wrong password
    /// Try again
    public static let wrongpasswordMessage = L10n.tr("Localizable", "pinview.wrongpasswordMessage")
  }

  public enum Webnavigationview {
    public enum DoneHeader {
      /// Volgende
      public static let button = L10n.tr("Localizable", "webnavigationview.doneHeader.button")
      /// Kies volgende om
      /// je gegevens te bekijken
      public static let subtitle = L10n.tr("Localizable", "webnavigationview.doneHeader.subtitle")
      /// Gegevens compleet
      public static let title = L10n.tr("Localizable", "webnavigationview.doneHeader.title")
    }
    public enum Header {
      /// Maak je dossier compleet
      /// door stap voor stap je
      /// data te verzamelen
      /// bij onderstaande bronnen
      public static let subtitle = L10n.tr("Localizable", "webnavigationview.header.subtitle")
      /// Gegevens verzamelen
      public static let title = L10n.tr("Localizable", "webnavigationview.header.title")
    }
    public enum PromptHeader {
      /// Start
      public static let button = L10n.tr("Localizable", "webnavigationview.promptHeader.button")
      /// je verzameld hier
      /// de volgende gegevens:
      /// 
      /// - BRP gegevens
      /// - Inkomens gegevens
      /// - ID gegevens
      public static let description = L10n.tr("Localizable", "webnavigationview.promptHeader.description")
      /// %@
      public static func headline(_ p1: Any) -> String {
        return L10n.tr("Localizable", "webnavigationview.promptHeader.headline", String(describing: p1))
      }
      /// Gegevens verzamelen bij
      public static let title = L10n.tr("Localizable", "webnavigationview.promptHeader.title")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
