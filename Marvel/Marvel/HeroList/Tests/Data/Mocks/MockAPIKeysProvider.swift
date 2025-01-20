import Core

struct MockAPIKeysProvider: APIKeysProvider {
    var publicKey: String = "TestPublicKey"
    var privateKey: String = "TestPrivateKey"
}
