// PKGPATH: gno.land/r/groups/proposals_test
package proposals_test

// SEND: 200000000ugnot

import (
	"gno.land/r/demo/groups/proposals"
	"gno.land/r/demo/users"
)

var propid proposals.ProposalID

func main() {
	users.Register("", "ramana", "my profile")
	println(proposals.Render(""))
}


// Output:
// List of all Proposals:
