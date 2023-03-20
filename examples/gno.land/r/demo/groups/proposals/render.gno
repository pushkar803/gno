package proposals

import (
	"strings"
	"gno.land/p/demo/avl"
)

//----------------------------------------
// Render functions

func RenderProposal(propid ProposalID) string {
	proposal := getProposal(propid)
	if proposal == nil {
		return "missing Proposal"
	}
	return proposal.RenderProposal()
}

func Render(path string) string {
	if path == "" {
		str := "List of all Proposals:\n\n"
		gProps.Iterate("", "", func(n *avl.Node) bool {
			proposal := n.Value().(*Proposal)
			str += " * [" + proposal.name + "](" + proposal.url + ")\n"
			return false
		})
		return str
	}
	parts := strings.Split(path, "/")
	if len(parts) == 1 {
		// /r/Groups/Proposals:Proposal_NAME
		name := parts[0]
		proposalI, exists := gPropsByName.Get(name)
		if !exists {
			return "Proposal does not exist: " + name
		}
		return proposalI.(*Proposal).RenderProposal()
	} else {
		return "unrecognized path " + path
	}
}
