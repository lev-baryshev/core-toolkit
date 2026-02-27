# expressive and useful toolkit for Swift with beautiful syntax!

### unwrapping optionals:

```swift
let url = unwrap(address) { URL(string: $0) }
```

### structured concurrency tools:

``` swift
// queue over async/await structured concurrency:
let background = Async.Fifo()
background.enqueue { [weak self] in await self?.parseNext() }

// main actor control:
onMain       { [weak self] in await self?.controlUi() }
inBackground { [weak self] in await self?.heavyWork() }

// pause:
await idle(seconds)
```

### expressive dependency injection tools:

``` swift
container.singleton(Service?.self) { Service.Engine() } // registering singleton service in Di
let service = di.inject(Service?.self)                  // injecting dependency
```

### lacoinc logs:

``` swift
log("user list screen opened")   // "[ ] user list screen opened"
log(error: "invalid parameters") // "[x] invalid parameters"
log(warning: "network lost")     // "[!] network lost"
```

### resources tools:

```swift
extension Resources.Image {
    static let logo = "logo_resource_key".imageResource
}
Image(.logo)
UIImage(.logo)

extension Resources.String {
    static let warning = "warning_resource_key".stringResource
}
Text(.warning)
String(.warning)

```

### time tools:

```swift
date.as("dd.MM.yyy") // "25.05.1986"
date.iso8601utc      // "1986-05-25T15:25:55+00:00"
date.HHmmss          // "15:25:25"
.now - date          // 12345 seconds
.now.since(date)     // 12345 seconds
```

### colors:

```swift
let rgb = Rgb(r: 0xFF, g: 0x15, b: 0x7F, a: 0xFF)
rgb.int                   // 0xFF157FFF
rgb.rrggbb                // "0xFF157F"
let color   = rgb.color   // SwiftUI Color
let uiColor = rgb.uiColor // UIKit UIColor
color.rgb                 // Color -> Rgb
uiColor.rgb               // UIColor -> Rgb
```

### ... and even more expressive and laconic tools:

``` swift
let random: Int = UUID().int // random int

Bundle.version.number        // 1.5.0
Bundle.version.build         // 208805231431

array[safe: index]           // safe access to avoid out of range

let users: [UserId : User] = [user1, user2, user3].transform(key: \.id)

URL("api.backend.com")/"endpoint"  // url: api.backend.com/endpoint
```
