package proposals

import (
	"std"
	"strconv"
	"strings"
	"gno.land/r/demo/users"
)

//----------------------------------------
// private utility methods
// XXX ensure these cannot be called from public.

func getProposal(propid ProposalID) *Proposal {
	propidkey := propsIDKey(propid)
	proposal_, exists := gProps.Get(propidkey)
	if !exists {
		panic("proposal id ("+propid.String()+") does not exists")
	}
	proposal := proposal_.(*Proposal)
	return proposal
}

func incGetPropID() ProposalID {
	gPropsCtr++
	return ProposalID(gPropsCtr)
}

func padLeft(str string, length int) string {
	if len(str) >= length {
		return str
	} 
	return strings.Repeat(" ", length-len(str)) + str
}

func padZero(u64 uint64, length int) string {
	str := strconv.Itoa(int(u64))
	if len(str) >= length {
		return str
	} 
	return strings.Repeat("0", length-len(str)) + str
	
}

func propsIDKey(propid ProposalID) string {
	return padZero(uint64(propid), 10)
}


func indentBody(indent string, body string) string {
	lines := strings.Split(body, "\n")
	res := ""
	for i, line := range lines {
		if i > 0 {
			res += "\n"
		}
		res += indent + line
	}
	return res
}

// NOTE: length must be greater than 3.
func summaryOf(str string, length int) string {
	lines := strings.SplitN(str, "\n", 2)
	line := lines[0]
	if len(line) > length {
		line = line[:(length-3)] + "..."
	} else if len(lines) > 1 {
		// len(line) <= 80
		line = line + "..."
	}
	return line
}

func displayAddressMD(addr std.Address) string {
	user := users.GetUserByAddress(addr)
	if user == nil {
		return "[" + addr.String() + "](/r/users:" + addr.String() + ")"
	} 
	return "[@" + user.Name() + "](/r/users:" + user.Name() + ")"
}

func usernameOf(addr std.Address) string {
	user := users.GetUserByAddress(addr)
	if user == nil {
		panic("user not found")
	} 
	return user.Name()
	
}