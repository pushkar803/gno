package proposals

import (
	"std"
	"gno.land/r/demo/users"
)

//----------------------------------------
// Public facing functions

func GetProposalIDFromName(name string) (ProposalID, bool) {
	proposalI, exists := gPropsByName.Get(name)
	if !exists {
		return 0, false
	}
	return proposalI.(*Proposal).id, true
}

func CreateProposal(name string) ProposalID {
	std.AssertOriginCall()
	caller := std.GetOrigCaller()
	usernameOf(caller)
	url := "/r/demo/groups/proposals2:" + name
	proposal := newProposal(url, name, caller)
	propidkey := propsIDKey(proposal.id)
	gProps.Set(propidkey, proposal)
	gPropsByName.Set(name, proposal)
	return proposal.id
}

func DeleteProposal(propid ProposalID) {
	std.AssertOriginCall()
	caller := std.GetOrigCaller()
	proposal := getProposal(propid)
	proposal.deleteProposal()
}

