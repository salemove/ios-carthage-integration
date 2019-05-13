import Quick
import Nimble
import SalemoveSDK

class QuickNimbleCarthageSpec: QuickSpec {
    override func spec() {
        describe("SalemoveSDK") {
            it("should configure AppToken") {
                let token = "test"
                expect {(try Salemove.sharedInstance.configure(appToken: token))}.toNot(throwError())
                expect(Salemove.sharedInstance.appToken) == token
            }
        }
    }
}
