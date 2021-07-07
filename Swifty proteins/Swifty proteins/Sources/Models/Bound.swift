
struct Bound{
    enum TypeOfBound: Int {
        case Single = 1
        case Double = 2
        case Triple = 3
    }
    
    let atomId: Int
    let boundAtomId: Int
    let typeOfBound: TypeOfBound
    
    init(atomId: Int, boundAtomId: Int, typeOfBound: Int){
        self.atomId = atomId
        self.boundAtomId = boundAtomId
        self.typeOfBound = TypeOfBound.init(rawValue: typeOfBound) ?? TypeOfBound.Single
    }
}
