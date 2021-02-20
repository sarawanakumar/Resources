
protocol Vehicle {
    var model: String { get }
    var brand: String { get }
    func isEqualTo(_ other: Vehicle) -> Bool
    func asEquatable() -> EquatableVehicle
}

extension Vehicle where Self: Equatable {
    func isEqualTo(_ other: Vehicle) -> Bool {
        guard let otherVehicle = other as? Self else { return false }

        return otherVehicle == self
    }

    func asEquatable() -> EquatableVehicle {
        return EquatableVehicle(self)
    }
}


struct EquatableVehicle: Vehicle {

    var model: String {
        return vehicle.model
    }

    var brand: String {
        return vehicle.brand
    }

    private let vehicle: Vehicle

    init(_ vehicle: Vehicle) {
        self.vehicle = vehicle
    }
}

extension EquatableVehicle: Equatable {
    static func == (lhs: EquatableVehicle, rhs: EquatableVehicle) -> Bool {
        return lhs.vehicle.isEqualTo(rhs.vehicle)
    }
}


//Testing
struct Hatchback: Vehicle, Equatable {
    var model: String

    var brand: String

}

struct Suv: Vehicle, Equatable {
    var model: String

    var brand: String

}

let hundaiI20: Vehicle = Hatchback(model: "Hundai", brand: "i20")
let marutiBaleno: Vehicle = Hatchback(model: "Maruti", brand: "baleno")
let anotherHundaiI20: Vehicle = Hatchback(model: "Hundai", brand: "i20")
let anSuv: Vehicle = Suv(model: "Maruti", brand: "baleno")

print(hundaiI20.asEquatable() == anotherHundaiI20.asEquatable())
print(hundaiI20.asEquatable() == marutiBaleno.asEquatable())
print(hundaiI20.asEquatable() == anSuv.asEquatable())
