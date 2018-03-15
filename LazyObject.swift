class LazyObject<T> {
    var object: T {
        if _object == nil {
            _object = self.getter()
        }
        return _object!
    }
    fileprivate var _object: T?
    private let getter: () -> T
    
    init(getter: @escaping () -> T) {
        self.getter = getter
    }
}

class MutableLazyObject<T>: LazyObject<T> {
    func use(_ block: (inout T) -> Void) {
        var object = self.object
        block(&object)
        _object = object
    }
}

@inline(__always) func lazy<T>(_ getter: @escaping () -> T) -> LazyObject<T> {
    return LazyObject(getter: getter)
}

@inline(__always) func lazy<T>(_ getter: @autoclosure @escaping () -> T) -> LazyObject<T> {
    return LazyObject(getter: getter)
}

@inline(__always) func mutableLazy<T>(_ getter: @escaping () -> T) -> MutableLazyObject<T> {
    return MutableLazyObject(getter: getter)
}

@inline(__always) func mutableLazy<T>(_ getter: @autoclosure @escaping () -> T) -> MutableLazyObject<T> {
    return MutableLazyObject(getter: getter)
}
