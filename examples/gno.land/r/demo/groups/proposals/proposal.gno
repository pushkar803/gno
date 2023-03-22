package proposals

import (
	"gno.land/p/demo/avl"
	"std"
	"strconv"
	"time"
	"gno.land/p/demo/acl"
	"gno.land/r/demo/auth"
)

type ProposalID  uint64

func (propid ProposalID) String() string {
	return strconv.Itoa(int(propid))
}

type Proposal struct {
	id           ProposalID
	url          string
	name         string
	creator      std.Address
	createdAt    time.Time
}

func newProposal(url string, name string, creator std.Address) *Proposal {

	check := auth.CheckRealmAccess("r/demo/groups/proposals", "write", creator.String())
	if !check {
		panic("u dont have permissions")
	}

	if !reName.MatchString(name) {
		panic("invalid name: " + name)
	}
	if gPropsByName.Has(name) {
		panic("Proposal with such name already exists")
	}
	return &Proposal{
		id:        incGetPropID(),
		url:       url,
		name:      name,
		creator:   creator,
		createdAt: time.Now(),
	}
}

func (proposal *Proposal) RenderProposal() string {
	str := "Proposal ID: " + propsIDKey(proposal.id) + "\n\n" +
		"Proposal Name: " + proposal.name + "\n\n" +
		"Proposal Creator: " + usernameOf(proposal.creator) + "\n\n" +
		"Proposal createdAt: " + proposal.createdAt.String() + "\n\n"
	return str
}

func (proposal *Proposal) deleteProposal() {
	propidkey := propsIDKey(proposal.id)
	_, gPropsRemoved := gProps.Remove(propidkey)
	if !gPropsRemoved {
		panic("proposal does not exist with id " + proposal.id.String())
	}
	gPropsByName.Remove(proposal.name)

}