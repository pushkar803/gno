package votes

import (
	"gno.land/p/demo/avl"
	"std"
	"strconv"
	"time"
	"gno.land/p/demo/acl"
)

type VoteID  uint64

func (propid VoteID) String() string {
	return strconv.Itoa(int(propid))
}

type Vote struct {
	id           VoteID
	url          string
	name         string
	creator      std.Address
	createdAt    time.Time
}

func newVote(url string, name string, creator std.Address) *Vote {

	//dir := acl.New()
	//dir.AddUserPerm(creator, "read", "r/demo/groups/votes:.*")

	//verb := "write"
	//resource := "r/demo/groups/votes:.*"

	//check := dir.HasPerm(creator, verb, resource)
	//if !check {
	//	panic("u dont have permissions")
	//}

	if !reName.MatchString(name) {
		panic("invalid name: " + name)
	}

	if gVotesByName.Has(name) {
		panic("Votes with such name already exists")
	}

	return &Vote{
		id:        incGetVoteID(),
		url:       url,
		name:      name,
		creator:   creator,
		createdAt: time.Now(),
	}
}

func (vote *Vote) RenderVote() string {
	str := "Vote ID: " + votesIDKey(vote.id) + "\n\n" +
		"Vote Name: " + vote.name + "\n\n" +
		"Vote Creator: " + usernameOf(vote.creator) + "\n\n" +
		"Vote createdAt: " + vote.createdAt.String() + "\n\n"
	return str
}

func (vote *Vote) deleteVote() {
	voteidkey := votesIDKey(vote.id)
	_, gVotesRemoved := gVotes.Remove(voteidkey)
	if !gVotesRemoved {
		panic("vote does not exist with id " + vote.id.String())
	}
	gVotesByName.Remove(vote.name)

}