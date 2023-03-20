// PKGPATH: gno.land/r/groups/proposals_test
package proposals_test

// SEND: 200000000ugnot

import (
	"std"
	"gno.land/r/demo/groups/proposals"
	"gno.land/r/demo/users"
	"strconv"
	"gno.land/p/demo/testutils"
	"gno.land/r/demo/users"
)

var propid proposals.ProposalID
const admin = std.Address("g1us8428u2a5satrlxzagqqa5m6vmuze025anjlj")

func main() {

	caller := std.GetOrigCaller() // main
	users.Register("", "gnouser0", "my profile 1")

	std.TestSetOrigCaller(admin)
	users.GrantInvites(caller.String() + ":1")
	// switch back to caller
	std.TestSetOrigCaller(caller)
	// invite another addr
	test1 := testutils.TestAddress("gnouser1")
	users.Invite(test1.String())
	// switch to test1
	std.TestSetOrigCaller(test1)
	users.Register(caller, "gnouser1", "my other profile 1")
	
	std.TestSetOrigCaller(test1)

	proposals.CreateProposal("test_proposal")
}

// Error:
// u dont have permissions
