# Change Log

## [Unreleased](https://github.com/Hearst-DD/ObjectMapper/tree/HEAD)

[Full Changelog](https://github.com/Hearst-DD/ObjectMapper/compare/0.12...HEAD)

**Closed issues:**

- Code=3840 "The operation couldn’t be completed." [\#126](https://github.com/Hearst-DD/ObjectMapper/issues/126)

- Dictionaries of Arrays? [\#121](https://github.com/Hearst-DD/ObjectMapper/issues/121)

**Merged pull requests:**

- Use ArraySlice for performance optimization in recursive functions [\#125](https://github.com/Hearst-DD/ObjectMapper/pull/125) ([ikesyo](https://github.com/ikesyo))

## [0.12](https://github.com/Hearst-DD/ObjectMapper/tree/0.12) (2015-05-17)

[Full Changelog](https://github.com/Hearst-DD/ObjectMapper/compare/0.11...0.12)

**Closed issues:**

- Implicit mapping from underscore to camel case? [\#122](https://github.com/Hearst-DD/ObjectMapper/issues/122)

- Can't get the sample work [\#120](https://github.com/Hearst-DD/ObjectMapper/issues/120)

- Empty dictionaries/arrays of custom types not reflected in JSON [\#119](https://github.com/Hearst-DD/ObjectMapper/issues/119)

- Trying to use TransformOf, to Map \[lat, lon\] Array to CLLocation [\#118](https://github.com/Hearst-DD/ObjectMapper/issues/118)

**Merged pull requests:**

- Dictionary of arrays [\#124](https://github.com/Hearst-DD/ObjectMapper/pull/124) ([tristanhimmelman](https://github.com/tristanhimmelman))

## [0.11](https://github.com/Hearst-DD/ObjectMapper/tree/0.11) (2015-04-30)

[Full Changelog](https://github.com/Hearst-DD/ObjectMapper/compare/0.10...0.11)

**Closed issues:**

- A little help with nested objects needed [\#114](https://github.com/Hearst-DD/ObjectMapper/issues/114)

- fail to import ObjectMapper from cocoapods [\#113](https://github.com/Hearst-DD/ObjectMapper/issues/113)

- put the transform dir in 1 swift file [\#111](https://github.com/Hearst-DD/ObjectMapper/issues/111)

- Xcode 6.3 and ObjectMapper 0.9 [\#110](https://github.com/Hearst-DD/ObjectMapper/issues/110)

- Help Wanted: Mapping Arrays of Mappables? [\#106](https://github.com/Hearst-DD/ObjectMapper/issues/106)

- loss order when deserializing json string [\#105](https://github.com/Hearst-DD/ObjectMapper/issues/105)

**Merged pull requests:**

- Add array and dictionary support for mapping with transform [\#117](https://github.com/Hearst-DD/ObjectMapper/pull/117) ([ikesyo](https://github.com/ikesyo))

- Do not use force unwrapping for RawRepresentable mapping [\#116](https://github.com/Hearst-DD/ObjectMapper/pull/116) ([ikesyo](https://github.com/ikesyo))

- Added support for NSString input [\#115](https://github.com/Hearst-DD/ObjectMapper/pull/115) ([tiemevanveen](https://github.com/tiemevanveen))

- Enum \(RawRepresentable\)  objects mapping [\#112](https://github.com/Hearst-DD/ObjectMapper/pull/112) ([RyomaKawajiri](https://github.com/RyomaKawajiri))

- Use @autoclosure for a default value which may not be used [\#109](https://github.com/Hearst-DD/ObjectMapper/pull/109) ([ikesyo](https://github.com/ikesyo))

- Fix method parameter of sample code in README [\#108](https://github.com/Hearst-DD/ObjectMapper/pull/108) ([kishikawakatsumi](https://github.com/kishikawakatsumi))

- Fix typo in README [\#107](https://github.com/Hearst-DD/ObjectMapper/pull/107) ([kishikawakatsumi](https://github.com/kishikawakatsumi))

- Improve immutable mapping [\#104](https://github.com/Hearst-DD/ObjectMapper/pull/104) ([ikesyo](https://github.com/ikesyo))

## [0.10](https://github.com/Hearst-DD/ObjectMapper/tree/0.10) (2015-04-08)

[Full Changelog](https://github.com/Hearst-DD/ObjectMapper/compare/0.9...0.10)

**Closed issues:**

- Can't map json string into my class! [\#95](https://github.com/Hearst-DD/ObjectMapper/issues/95)

- Can't map array from root node of json [\#93](https://github.com/Hearst-DD/ObjectMapper/issues/93)

- Add an external parameter name to Map.map\(JSON: AnyObject?\) [\#74](https://github.com/Hearst-DD/ObjectMapper/issues/74)

- Library not loaded: @rpath/ObjectMapper.framework [\#64](https://github.com/Hearst-DD/ObjectMapper/issues/64)

**Merged pull requests:**

- Capitalized the MappingType enum values [\#103](https://github.com/Hearst-DD/ObjectMapper/pull/103) ([tristanhimmelman](https://github.com/tristanhimmelman))

- Specify Release configuration for testing build [\#102](https://github.com/Hearst-DD/ObjectMapper/pull/102) ([ikesyo](https://github.com/ikesyo))

- Remove AnyObject variants of `basicType` in `FromJSON` [\#101](https://github.com/Hearst-DD/ObjectMapper/pull/101) ([ikesyo](https://github.com/ikesyo))

- Workaround swift crash with nested mappings [\#100](https://github.com/Hearst-DD/ObjectMapper/pull/100) ([barnybug](https://github.com/barnybug))

- Change functions of `FromJSON` and `ToJSON` to `class func`, make the classes final [\#99](https://github.com/Hearst-DD/ObjectMapper/pull/99) ([ikesyo](https://github.com/ikesyo))

- Exclude README from iOS build target [\#98](https://github.com/Hearst-DD/ObjectMapper/pull/98) ([ikesyo](https://github.com/ikesyo))

- Remove `basicArray` and `basicDictionary`, implement that at `basicType` in `ToJSON` [\#97](https://github.com/Hearst-DD/ObjectMapper/pull/97) ([ikesyo](https://github.com/ikesyo))

- Simplification of Mapper interface [\#96](https://github.com/Hearst-DD/ObjectMapper/pull/96) ([tristanhimmelman](https://github.com/tristanhimmelman))

- \[WIP\] Change the return type of `map\(JSON:\)` to optional, not IUO, for better type safety [\#94](https://github.com/Hearst-DD/ObjectMapper/pull/94) ([ikesyo](https://github.com/ikesyo))

- Introduce Nimble for better assertion [\#89](https://github.com/Hearst-DD/ObjectMapper/pull/89) ([ikesyo](https://github.com/ikesyo))

## [0.9](https://github.com/Hearst-DD/ObjectMapper/tree/0.9) (2015-03-23)

[Full Changelog](https://github.com/Hearst-DD/ObjectMapper/compare/0.8...0.9)

**Closed issues:**

- Add OSX target to project [\#90](https://github.com/Hearst-DD/ObjectMapper/issues/90)

- Mapping \[String\] [\#86](https://github.com/Hearst-DD/ObjectMapper/issues/86)

- Set up CI environment [\#79](https://github.com/Hearst-DD/ObjectMapper/issues/79)

- Problem in mapping numberic strings [\#78](https://github.com/Hearst-DD/ObjectMapper/issues/78)

- Thread and async problems... [\#77](https://github.com/Hearst-DD/ObjectMapper/issues/77)

- parse integer response always nil [\#73](https://github.com/Hearst-DD/ObjectMapper/issues/73)

- Non-optional mapping [\#26](https://github.com/Hearst-DD/ObjectMapper/issues/26)

**Merged pull requests:**

- Add OS X target [\#91](https://github.com/Hearst-DD/ObjectMapper/pull/91) ([ikesyo](https://github.com/ikesyo))

- Create EnumTransform to transform into RawRepresentable Enums [\#88](https://github.com/Hearst-DD/ObjectMapper/pull/88) ([kaandedeoglu](https://github.com/kaandedeoglu))

- Allow ObjectMapper be used within an app extension [\#87](https://github.com/Hearst-DD/ObjectMapper/pull/87) ([pizthewiz](https://github.com/pizthewiz))

- \[ToJSON\] Improve nested keys support [\#84](https://github.com/Hearst-DD/ObjectMapper/pull/84) ([ikesyo](https://github.com/ikesyo))

- Refactored date formatters and added new Test class for Custom Transforms [\#83](https://github.com/Hearst-DD/ObjectMapper/pull/83) ([tristanhimmelman](https://github.com/tristanhimmelman))

- Set up Travis CI [\#82](https://github.com/Hearst-DD/ObjectMapper/pull/82) ([ikesyo](https://github.com/ikesyo))

- Handle NSNumber as a basic JSON value type [\#81](https://github.com/Hearst-DD/ObjectMapper/pull/81) ([ikesyo](https://github.com/ikesyo))

- adding a custom date format transform class [\#80](https://github.com/Hearst-DD/ObjectMapper/pull/80) ([mccrackend](https://github.com/mccrackend))

- Fix redundant mapping call at subclasses in test target [\#76](https://github.com/Hearst-DD/ObjectMapper/pull/76) ([ikesyo](https://github.com/ikesyo))

- Symetric mappings for nested keys [\#75](https://github.com/Hearst-DD/ObjectMapper/pull/75) ([yuseinishiyama](https://github.com/yuseinishiyama))

## [0.8](https://github.com/Hearst-DD/ObjectMapper/tree/0.8) (2015-03-02)

[Full Changelog](https://github.com/Hearst-DD/ObjectMapper/compare/0.7...0.8)

**Merged pull requests:**

- \[WIP\]\[POC\] Split Mappable functionality to the immutable variant and the mutable one [\#71](https://github.com/Hearst-DD/ObjectMapper/pull/71) ([ikesyo](https://github.com/ikesyo))

## [0.7](https://github.com/Hearst-DD/ObjectMapper/tree/0.7) (2015-02-25)

[Full Changelog](https://github.com/Hearst-DD/ObjectMapper/compare/0.6...0.7)

**Closed issues:**

- Can't map a generic array [\#67](https://github.com/Hearst-DD/ObjectMapper/issues/67)

- Incorrect compiler behavior for overloaded parsing functions\(Xcode Version 6.1.1 \(6A2008a\)\) [\#65](https://github.com/Hearst-DD/ObjectMapper/issues/65)

- Guidance needed: how to pass a Mappable to a function that can map to it as a generic? [\#63](https://github.com/Hearst-DD/ObjectMapper/issues/63)

- parse integer response always nil \(e.g status = 200\) the result is always becomes nil .. any help ? thanks [\#62](https://github.com/Hearst-DD/ObjectMapper/issues/62)

**Merged pull requests:**

- Updated operator from '<=' to '<|' which overrides the native less-than-equal-to [\#72](https://github.com/Hearst-DD/ObjectMapper/pull/72) ([vpalivela](https://github.com/vpalivela))

- Add a white space between custom operator and generics [\#70](https://github.com/Hearst-DD/ObjectMapper/pull/70) ([ken0nek](https://github.com/ken0nek))

- \[FromJSON\] Remove unused type parameter [\#69](https://github.com/Hearst-DD/ObjectMapper/pull/69) ([ikesyo](https://github.com/ikesyo))

- Can't map a generic array [\#66](https://github.com/Hearst-DD/ObjectMapper/pull/66) ([hborders](https://github.com/hborders))

- Ikesyo anyobject maparray [\#59](https://github.com/Hearst-DD/ObjectMapper/pull/59) ([tristanhimmelman](https://github.com/tristanhimmelman))

- Add map/mapArray/mapDictionary overload to Mapper that takes an AnyObject? [\#58](https://github.com/Hearst-DD/ObjectMapper/pull/58) ([ikesyo](https://github.com/ikesyo))

## [0.6](https://github.com/Hearst-DD/ObjectMapper/tree/0.6) (2015-02-09)

[Full Changelog](https://github.com/Hearst-DD/ObjectMapper/compare/0.5...0.6)

**Closed issues:**

- Can ObjectMapper work in iOS 7.0 [\#51](https://github.com/Hearst-DD/ObjectMapper/issues/51)

- Support for mapTo and mapFrom [\#42](https://github.com/Hearst-DD/ObjectMapper/issues/42)

**Merged pull requests:**

- Map.mappingType should also be public [\#57](https://github.com/Hearst-DD/ObjectMapper/pull/57) ([ikesyo](https://github.com/ikesyo))

- Make MappingType public, address \#42 [\#56](https://github.com/Hearst-DD/ObjectMapper/pull/56) ([ikesyo](https://github.com/ikesyo))

- Implicitly unwrapped optionals [\#55](https://github.com/Hearst-DD/ObjectMapper/pull/55) ([tristanhimmelman](https://github.com/tristanhimmelman))

- Ikesyo refactor from json to json [\#54](https://github.com/Hearst-DD/ObjectMapper/pull/54) ([tristanhimmelman](https://github.com/tristanhimmelman))

- Refactor FromJSON and ToJSON [\#53](https://github.com/Hearst-DD/ObjectMapper/pull/53) ([ikesyo](https://github.com/ikesyo))

- Implement Transforms based on Protocol and type aliases [\#52](https://github.com/Hearst-DD/ObjectMapper/pull/52) ([ikesyo](https://github.com/ikesyo))

- Extract `valueFor` from Map, make it a tail recursive function [\#50](https://github.com/Hearst-DD/ObjectMapper/pull/50) ([ikesyo](https://github.com/ikesyo))

- Make Mapper and Map more immutable [\#49](https://github.com/Hearst-DD/ObjectMapper/pull/49) ([ikesyo](https://github.com/ikesyo))

## [0.5](https://github.com/Hearst-DD/ObjectMapper/tree/0.5) (2015-02-03)

[Full Changelog](https://github.com/Hearst-DD/ObjectMapper/compare/0.4...0.5)

**Closed issues:**

- iOS 7 Cocoapods support [\#48](https://github.com/Hearst-DD/ObjectMapper/issues/48)

- Removal of toType affects subclassing [\#47](https://github.com/Hearst-DD/ObjectMapper/issues/47)

- DateTransform crashing [\#46](https://github.com/Hearst-DD/ObjectMapper/issues/46)

**Merged pull requests:**

- Refactor Mapper class [\#45](https://github.com/Hearst-DD/ObjectMapper/pull/45) ([ikesyo](https://github.com/ikesyo))

- Refactor switch-case usage [\#44](https://github.com/Hearst-DD/ObjectMapper/pull/44) ([ikesyo](https://github.com/ikesyo))

- fix typo and ad unit tests [\#43](https://github.com/Hearst-DD/ObjectMapper/pull/43) ([corinnekrych](https://github.com/corinnekrych))

## [0.4](https://github.com/Hearst-DD/ObjectMapper/tree/0.4) (2015-01-26)

[Full Changelog](https://github.com/Hearst-DD/ObjectMapper/compare/0.3...0.4)

**Closed issues:**

- iOS 7 support [\#40](https://github.com/Hearst-DD/ObjectMapper/issues/40)

- \[RFC\] Rename MapperProtocol to something [\#39](https://github.com/Hearst-DD/ObjectMapper/issues/39)

**Merged pull requests:**

- Make Mapper class itself generic, :fire: `toType` parameter [\#41](https://github.com/Hearst-DD/ObjectMapper/pull/41) ([ikesyo](https://github.com/ikesyo))

## [0.3](https://github.com/Hearst-DD/ObjectMapper/tree/0.3) (2015-01-23)

[Full Changelog](https://github.com/Hearst-DD/ObjectMapper/compare/0.2...0.3)

**Closed issues:**

- Build failed on iPhone 5 [\#36](https://github.com/Hearst-DD/ObjectMapper/issues/36)

**Merged pull requests:**

- Fix ISO8601DateTransform not to crash with invalid input [\#38](https://github.com/Hearst-DD/ObjectMapper/pull/38) ([ikesyo](https://github.com/ikesyo))

- Add `TransformOf` transform [\#37](https://github.com/Hearst-DD/ObjectMapper/pull/37) ([ikesyo](https://github.com/ikesyo))

- add mapping function to map a json dictionary to an existing object to m... [\#35](https://github.com/Hearst-DD/ObjectMapper/pull/35) ([brandonroth](https://github.com/brandonroth))

- set iOS 8 as minimum to allow App Store submission [\#23](https://github.com/Hearst-DD/ObjectMapper/pull/23) ([pizthewiz](https://github.com/pizthewiz))

## [0.2](https://github.com/Hearst-DD/ObjectMapper/tree/0.2) (2015-01-22)

[Full Changelog](https://github.com/Hearst-DD/ObjectMapper/compare/0.1...0.2)

**Closed issues:**

- Map \[N\] to JSON array [\#30](https://github.com/Hearst-DD/ObjectMapper/issues/30)

**Merged pull requests:**

- Updated Readme for Carthage [\#34](https://github.com/Hearst-DD/ObjectMapper/pull/34) ([eoinoconnell](https://github.com/eoinoconnell))

- Support Carthage [\#33](https://github.com/Hearst-DD/ObjectMapper/pull/33) ([eoinoconnell](https://github.com/eoinoconnell))

- Add struct support [\#32](https://github.com/Hearst-DD/ObjectMapper/pull/32) ([ikesyo](https://github.com/ikesyo))

## [0.1](https://github.com/Hearst-DD/ObjectMapper/tree/0.1) (2015-01-20)

[Full Changelog](https://github.com/Hearst-DD/ObjectMapper/compare/0.0.3...0.1)

**Closed issues:**

- Add PodSpec to Cocoapods [\#29](https://github.com/Hearst-DD/ObjectMapper/issues/29)

- Create a new release/tag with podspec file [\#27](https://github.com/Hearst-DD/ObjectMapper/issues/27)

- Map dict/array to existing object [\#21](https://github.com/Hearst-DD/ObjectMapper/issues/21)

**Merged pull requests:**

- Fixes crash when trying to transform invalid urlString [\#28](https://github.com/Hearst-DD/ObjectMapper/pull/28) ([mathiasnagler](https://github.com/mathiasnagler))

## [0.0.3](https://github.com/Hearst-DD/ObjectMapper/tree/0.0.3) (2015-01-09)

[Full Changelog](https://github.com/Hearst-DD/ObjectMapper/compare/0.0.2...0.0.3)

**Closed issues:**

- Combine multiple data from the JSON dictionary into one property [\#25](https://github.com/Hearst-DD/ObjectMapper/issues/25)

- How to map from Alamofire JSON response AnyObject? [\#20](https://github.com/Hearst-DD/ObjectMapper/issues/20)

- More complex data structures / Nested collections [\#19](https://github.com/Hearst-DD/ObjectMapper/issues/19)

- custom subtypes cannot be implicitly unwrapped optionals [\#18](https://github.com/Hearst-DD/ObjectMapper/issues/18)

- Parse json object with unknown keys [\#17](https://github.com/Hearst-DD/ObjectMapper/issues/17)

- CoreData relationships support [\#16](https://github.com/Hearst-DD/ObjectMapper/issues/16)

- check dependencies error [\#15](https://github.com/Hearst-DD/ObjectMapper/issues/15)

- Cannot convert an object contains generic member [\#14](https://github.com/Hearst-DD/ObjectMapper/issues/14)

- Cannot invoke '<=' with custom transformer [\#12](https://github.com/Hearst-DD/ObjectMapper/issues/12)

- Doubles not mapped correctly [\#11](https://github.com/Hearst-DD/ObjectMapper/issues/11)

**Merged pull requests:**

- Adding podspec [\#24](https://github.com/Hearst-DD/ObjectMapper/pull/24) ([marcelofabri](https://github.com/marcelofabri))

- ISO 8601 date transformer [\#22](https://github.com/Hearst-DD/ObjectMapper/pull/22) ([pizthewiz](https://github.com/pizthewiz))

- Fixed parsing of JSON strings when providing an object instance [\#13](https://github.com/Hearst-DD/ObjectMapper/pull/13) ([nmccann](https://github.com/nmccann))

## [0.0.2](https://github.com/Hearst-DD/ObjectMapper/tree/0.0.2) (2014-11-19)

[Full Changelog](https://github.com/Hearst-DD/ObjectMapper/compare/0.0.1...0.0.2)

**Closed issues:**

- How to handle collections? [\#10](https://github.com/Hearst-DD/ObjectMapper/issues/10)

- Mapping nested values [\#9](https://github.com/Hearst-DD/ObjectMapper/issues/9)

## [0.0.1](https://github.com/Hearst-DD/ObjectMapper/tree/0.0.1) (2014-11-11)

**Closed issues:**

- MapperProtocol requires init\(\) [\#3](https://github.com/Hearst-DD/ObjectMapper/issues/3)

**Merged pull requests:**

- Made methods in transforms public [\#8](https://github.com/Hearst-DD/ObjectMapper/pull/8) ([coenert](https://github.com/coenert))

- Make Transform funcs public so they can be overridden by external code [\#7](https://github.com/Hearst-DD/ObjectMapper/pull/7) ([jacksonh](https://github.com/jacksonh))

- Fix Small copy & paste error in the installation instructions [\#6](https://github.com/Hearst-DD/ObjectMapper/pull/6) ([jacksonh](https://github.com/jacksonh))

- Declare MapperTransform.init to be public. [\#4](https://github.com/Hearst-DD/ObjectMapper/pull/4) ([asmallteapot](https://github.com/asmallteapot))

- a couple additional tests for unexpected behaviors [\#2](https://github.com/Hearst-DD/ObjectMapper/pull/2) ([neocortical](https://github.com/neocortical))



\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*