# LazyObject.swift
*This is an experiment and not a complete library.*

`LazyObject` allows you to create/access any object lazily:
```
let bar = lazy(Bar())
print(bar) // will be LazyObject<Bar>
print(bar.object) // will bar Bar
```

A full explanation is available as [Medium Post](https://medium.com/@floschliep/experiment-lazy-objects-in-swift-a7a33a625862).

