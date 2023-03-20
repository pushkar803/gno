package votes

import (
	"std"
	"gno.land/r/demo/users"
)

//----------------------------------------
// Public facing functions

func GetVoteosalIDFromName(name string) (VoteID, bool) {
	voteI, exists := gVotesByName.Get(name)
	if !exists {
		return 0, false
	}
	return voteI.(*Vote).id, true
}

func CreateVote(name string) VoteID {
	std.AssertOriginCall()
	caller := std.GetOrigCaller()
	usernameOf(caller)
	url := "/r/demo/groups/votes:" + name
	vote := newVote(url, name, caller)
	voteidkey := votesIDKey(vote.id)
	gVotes.Set(voteidkey, vote)
	gVotesByName.Set(name, vote)
	return vote.id
}

func DeleteVote(voteid VoteID) {
	std.AssertOriginCall()
	caller := std.GetOrigCaller()
	vote := getVote(voteid)
	vote.deleteVote()
}

