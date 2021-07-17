import Foundation

class Wrap<T> {
	public init(_ value: T) {
		self.value = value
	}
	
	public var value: T
}
