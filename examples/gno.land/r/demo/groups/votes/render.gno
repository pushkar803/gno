package votes

import (
	"strings"
	"gno.land/p/demo/avl"
)

//----------------------------------------
// Render functions

func RenderVote(voteid VoteID) string {
	vote := getVote(voteid)
	if vote == nil {
		return "missing Vote"
	}
	return vote.RenderVote()
}

func Render(path string) string {
	if path == "" {
		str := "List of all Votes:\n\n"
		gVotes.Iterate("", "", func(n *avl.Node) bool {
			vote := n.Value().(*Vote)
			str += " * [" + vote.name + "](" + vote.url + ")\n"
			return false
		})
		return str
	}
	parts := strings.Split(path, "/")
	if len(parts) == 1 {
		// /r/Groups/Votes:vote_id
		name := parts[0]
		voteI, exists := gVotesByName.Get(name)
		if !exists {
			return "Votes does not exist: " + name
		}
		return voteI.(*Vote).RenderVote()
	} else {
		return "unrecognized path " + path
	}
}
