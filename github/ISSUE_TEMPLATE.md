### Your JSON dictionary:

```json
{
  "name": "ObjectMapper",
  "url": "https://github.com/Hearst-DD/ObjectMapper"
}
```

### Your model:

```swift
struct Repo: Mappable {
  var name: String!
  var url: URL!

  init(_ map: Map) {
    name <- map["name"]
    url <- map["url"]
  }
}
```

### What you did:

```swift
let repo = Mapper<Repo>().map(myJSONDictionary)
```

### What you expected:

I exepected something like:

```swift
Repo(name: "ObjectMapper", url: "https://github.com/Hearst-DD/ObjectMapper")
```

### What you got:

```swift
Repo(name: "ObjectMapper", url: nil)  // expected the url is mapped correctly
```

