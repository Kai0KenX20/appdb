import ObjectMapper

/// Represents an official appdb application returned by API 1.7
class OfficialApp: Item {
    var name: String = ""
    var bundleId: String = ""
    var version: String = ""
    var developer: String = ""
    var description_: String = ""
    var downloadURL: String = ""
    var icon: String = ""

    required init?(map: Map) {
        super.init(map: map)
    }

    override func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
        bundleId    <- map["bundle_id"]
        version     <- map["version"]
        developer   <- map["developer"]
        description_ <- map["description"]
        downloadURL <- map["download_url"]
        icon        <- map["icon"]
    }
}

