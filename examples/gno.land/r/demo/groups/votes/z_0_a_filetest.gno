// PKGPATH: gno.land/r/groups/votes_test
package votes_test

// SEND: 200000000ugnot

import (
	"std"
	"gno.land/r/demo/groups/votes"
	"gno.land/r/demo/users"
	"strconv"
	"gno.land/p/demo/testutils"
	"gno.land/r/demo/users"
)

var propid votes.VoteID

func main() {

	users.Register("", "gnouser", "my profile")
	vid := votes.CreateVote("test_vote")
	println(vid)
	println(votes.Render(""))
}

// Output:
// 1
// List of all Votes:
//
//  * [test_vote](/r/demo/groups/votes:test_vote)

