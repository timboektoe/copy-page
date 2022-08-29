import Foundation

enum MessageTypes: String, Decodable {
	case sourceDone = "report-source-done"
	case dataAssembled = "report-data-assembled"
}
