
struct Bound{
	enum TypeOfBound: Int {
		case Single = 1
		case Double = 2
		case Triple = 3
	}
	
	public let atomId: Int
	public let boundAtomId: Int
	public let typeOfBound: TypeOfBound

	public static func parse(atomId: Int, boundAtomId: Int, typeOfBound: Int) -> Bound {
		Bound(
			atomId: atomId,
			boundAtomId: boundAtomId,
			typeOfBound: TypeOfBound.init(rawValue: typeOfBound) ?? TypeOfBound.Single
		)
	}
	
	private init(atomId: Int, boundAtomId: Int, typeOfBound: TypeOfBound) {
		self.atomId = atomId
		self.boundAtomId = boundAtomId
		self.typeOfBound = typeOfBound
	}
}
