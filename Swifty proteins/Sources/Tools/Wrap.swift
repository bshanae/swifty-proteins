import Foundation

class Wrap<T> {
	public var value: T? = nil

	public var hasValue: Bool {
		value != nil
	}
}
