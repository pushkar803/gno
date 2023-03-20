package votes

import (
	"regexp"

	"gno.land/p/demo/avl"
)

//----------------------------------------
// Realm (package) state

var (
	gVotes       avl.Tree // id -> *Vote
	gVotesCtr    int      // increments Vote.id
	gVotesByName avl.Tree // name -> *Vote
)

//----------------------------------------
// Constants

var reName = regexp.MustCompile(`^[a-z]+[_a-z0-9]{2,29}$`)
