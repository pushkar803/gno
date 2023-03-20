package proposals

import (
	"regexp"

	"gno.land/p/demo/avl"
)

//----------------------------------------
// Realm (package) state

var (
	gProps       avl.Tree // id -> *Proposal
	gPropsCtr    int      // increments Proposal.id
	gPropsByName avl.Tree // name -> *Proposal
)

//----------------------------------------
// Constants

var reName = regexp.MustCompile(`^[a-z]+[_a-z0-9]{2,29}$`)
